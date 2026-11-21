import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Enforces the MVVM layering so it cannot erode (see ARCHITECTURE.md).
///
///   view  ->  view_model (Bloc/Cubit)  ->  domain (model + repository interface)
///                                                 ^
///                                      data (repository impl, Drift, Dio)
void main() {
  final libFiles = Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where(
        (f) => !f.path.endsWith('.g.dart') && !f.path.endsWith('.freezed.dart'),
      )
      .toList();

  final importRe = RegExp(r'''^import\s+['"]([^'"]+)['"]''', multiLine: true);

  /// Resolves an import to a path relative to lib/, or null for packages.
  String? resolve(File from, String import) {
    if (import.startsWith('package:app_mobile/')) {
      return import.substring('package:app_mobile/'.length);
    }
    if (import.startsWith('package:') || import.startsWith('dart:')) {
      return null;
    }
    final dir = from.parent.path;
    final parts = [...dir.split('/'), ...import.split('/')];
    final out = <String>[];
    for (final p in parts) {
      if (p == '..') {
        out.removeLast();
      } else if (p != '.') {
        out.add(p);
      }
    }
    return out.skip(1).join('/'); // drop leading "lib"
  }

  String rel(File f) => f.path.substring('lib/'.length);

  List<String> violations(
    bool Function(String file) applies,
    bool Function(String file, String target, String raw) bad,
  ) {
    final found = <String>[];
    for (final f in libFiles) {
      final path = rel(f);
      if (!applies(path)) continue;
      for (final m in importRe.allMatches(f.readAsStringSync())) {
        final raw = m.group(1)!;
        final target = resolve(f, raw);
        if (bad(path, target ?? '', raw)) found.add('$path imports $raw');
      }
    }
    return found;
  }

  bool inLayer(String p, String layer) =>
      RegExp('^features/[^/]+/$layer/').hasMatch(p);
  String? featureOf(String p) =>
      RegExp('^features/([^/]+)/').firstMatch(p)?.group(1);

  test('domain is pure Dart: no Flutter, Drift, Dio, Retrofit, JSON, or other layers', () {
    final v = violations(
      (p) => inLayer(p, 'domain'),
      (p, t, raw) =>
          raw.startsWith('package:flutter') ||
          raw.startsWith('package:material_ui') ||
          raw.startsWith('package:drift') ||
          raw.startsWith('package:dio') ||
          raw.startsWith('package:retrofit') ||
          raw.startsWith('package:json_annotation') ||
          raw.startsWith('package:go_router') ||
          raw.startsWith('package:get_it') ||
          t.contains('/data/') ||
          t.contains('/presentation/') ||
          t.startsWith('core/database') ||
          t.startsWith('core/network'),
    );
    expect(v, isEmpty, reason: v.join('\n'));
  });

  test('presentation calls use cases only: no repositories, data, Drift, Dio, Retrofit', () {
    final v = violations(
      (p) => inLayer(p, 'presentation'),
      (p, t, raw) =>
          t.contains('/data/') ||
          t.contains('/domain/repositories/') ||
          raw.startsWith('package:drift') ||
          raw.startsWith('package:dio') ||
          raw.startsWith('package:retrofit') ||
          t.startsWith('core/database') ||
          t.startsWith('core/network/api_client'),
    );
    expect(v, isEmpty, reason: v.join('\n'));
  });

  test('data never touches presentation or Flutter UI, and only data uses Retrofit', () {
    final v = violations(
      (p) => inLayer(p, 'data'),
      (p, t, raw) =>
          t.contains('/presentation/') ||
          raw.startsWith('package:material_ui') ||
          raw == 'package:flutter/widgets.dart',
    );
    expect(v, isEmpty, reason: v.join('\n'));

    final outside = violations(
      (p) => !inLayer(p, 'data'),
      (p, t, raw) => raw.startsWith('package:retrofit'),
    );
    expect(outside, isEmpty, reason: outside.join('\n'));
  });

  test('use cases are one class per file, live in domain/usecases, and implement UseCase', () {
    final bad = <String>[];
    for (final f in libFiles) {
      final p = rel(f);
      if (!RegExp(r'^features/[^/]+/domain/usecases/').hasMatch(p)) {
        continue;
      }
      final src = f.readAsStringSync();
      final classes = RegExp(
        r'^(?:final |abstract |base )?class \w+',
        multiLine: true,
      ).allMatches(src).length;
      final implementsUseCase = RegExp(r'implements (Stream)?UseCase<')
          .hasMatch(src);
      if (classes != 1 || !implementsUseCase) {
        bad.add(p);
      }
    }
    expect(bad, isEmpty, reason: bad.join('\n'));
  });

  test('repository implementations implement a domain interface and live in data/repositories', () {
    final bad = <String>[];
    for (final f in libFiles) {
      final p = rel(f);
      if (!p.endsWith('_repository_impl.dart')) {
        continue;
      }
      if (!inLayer(p, 'data') || !p.contains('/data/repositories/')) {
        bad.add('$p must live in data/repositories');
      }
      if (!RegExp(r'implements \w+Repository').hasMatch(f.readAsStringSync())) {
        bad.add('$p must implement a domain repository interface');
      }
    }
    expect(bad, isEmpty, reason: bad.join('\n'));
  });

  test(
    'features do not import another feature\'s data or presentation internals',
    () {
      final v = violations((p) => featureOf(p) != null, (p, t, raw) {
        final other = featureOf(t);
        if (other == null || other == featureOf(p)) {
          return false;
        }
        // Cross-feature use is limited to another feature's domain and to
        // app-scoped view models/widgets that are provided from the app root.
        return t.contains('/data/');
      });
      expect(v, isEmpty, reason: v.join('\n'));
    },
  );

  test('core does not depend on features, except the composition root', () {
    const composition = {
      'core/di/injection.dart',
      'core/router/app_router.dart',
    };
    final v = violations(
      (p) => p.startsWith('core/') && !composition.contains(p),
      (p, t, raw) => t.startsWith('features/'),
    );
    expect(v, isEmpty, reason: v.join('\n'));
  });

  test('widgets contain no raw colour literals (use context.tokens)', () {
    final offenders = <String>[];
    for (final f in libFiles) {
      final p = rel(f);
      if (p.startsWith('core/theme/app_tokens')) continue;
      if (RegExp(r'Color\(0x[0-9A-Fa-f]{8}\)').hasMatch(f.readAsStringSync())) {
        offenders.add(p);
      }
    }
    expect(offenders, isEmpty, reason: offenders.join('\n'));
  });

  test('the product name is configuration, never a literal (only BrandConfig may spell it)', () {
    // Built from parts so this file does not contain the word it forbids.
    final name = RegExp(
      'gr'
      'ov',
      caseSensitive: false,
    );
    const allowed = {'lib/core/config/brand_config.dart'};
    final offenders = <String>[];
    for (final root in ['lib', 'test']) {
      for (final f in Directory(
        root,
      ).listSync(recursive: true).whereType<File>()) {
        final path = f.path;
        final checked = path.endsWith('.dart') || path.endsWith('.arb');
        final generated =
            path.endsWith('.g.dart') || path.endsWith('.freezed.dart');
        if (!checked || generated || allowed.contains(path)) {
          continue;
        }
        if (name.hasMatch(path) || name.hasMatch(f.readAsStringSync())) {
          offenders.add(path);
        }
      }
    }
    expect(
      offenders,
      isEmpty,
      reason:
          'Use BrandConfig.name or a {brand} ARB placeholder:\n${offenders.join('\n')}',
    );
  });
}
