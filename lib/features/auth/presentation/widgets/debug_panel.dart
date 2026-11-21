import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/config/debug_config.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;

// DEBUG BUILDS ONLY. Developer tooling, so its text is not in the ARB and is
// not translated. Every use is behind `kDebugMode`, so release builds drop it.

/// The chip on Welcome that shows which data the sign-on screens use and opens
/// the debug sheet.
class const DebugPanelButton({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return const SizedBox.shrink();
    }
    final c = context.tokens;
    return ValueListenableBuilder<bool>(
      valueListenable: DebugConfig.sampleData,
      builder: (context, sample, _) => Material(
        color: Colors.transparent,
        child: ActionChip(
          avatar: Icon(Icons.bug_report_outlined, size: 18, color: c.ink),
          label: Text(sample ? 'Debug · sample data' : 'Debug · live API'),
          backgroundColor: c.palmTint,
          side: BorderSide(color: c.palmStrong),
          onPressed: () => showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            builder: (_) => const _DebugSheet(),
          ),
        ),
      ),
    );
  }
}

class const _DebugSheet() extends StatelessWidget {
  static const _apiBase = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final c = context.tokens;
    final bold = text.titleSmall;
    final body = text.bodyMedium?.copyWith(color: c.inkMuted);
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpace.s5,
            0,
            AppSpace.s5,
            AppSpace.s6,
          ),
          children: [
            Text('Debug', style: text.titleMedium),
            const SizedBox(height: AppSpace.s2),
            ValueListenableBuilder<bool>(
              valueListenable: DebugConfig.sampleData,
              builder: (context, sample, _) => SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: sample,
                onChanged: (v) => DebugConfig.sampleData.value = v,
                title: Text('Use sample data (no backend)', style: bold),
                subtitle: Text(
                  sample
                      ? 'Sign-on is answered on the device. Nothing is sent.'
                      : 'Live API: $_apiBase',
                  style: body,
                ),
              ),
            ),
            const Divider(),
            Text('Open an email-link screen', style: bold),
            const SizedBox(height: AppSpace.s2),
            Wrap(
              spacing: AppSpace.s2,
              children: [
                OutlinedButton(
                  onPressed: () =>
                      _open(context, 'sample-reset-token-1234567890'),
                  child: const Text('Reset link'),
                ),
                OutlinedButton(
                  onPressed: () =>
                      _open(context, 'expired-sample-reset-token-12'),
                  child: const Text('Expired link'),
                ),
              ],
            ),
            const Divider(),
            Text('What to type (sample data)', style: bold),
            const SizedBox(height: AppSpace.s2),
            _Rule('Email', [
              'anything → new account (join)',
              'has "known" → log in with a password',
              'has "google" → Google-only account',
              'has "locked" → account locked',
              'has "unverified" → log in, then the email code',
            ], body),
            _Rule('Password', [
              'any → signs in, except "wrong" → wrong password',
              'has "password" or 12345678 → common (join, reset)',
            ], body),
            _Rule('Join', [
              'email has "taken" → email taken',
              'phone ends 0000 → phone taken',
            ], body),
            _Rule('Email code', [
              '123456 (or any) → accepted',
              '111111 → wrong · 222222 → expired · 000000 → too many tries',
            ], body),
          ],
        ),
      ),
    );
  }

  void _open(BuildContext context, String token) {
    Navigator.of(context).pop();
    context.go('${Routes.reset}?token=$token');
  }
}

class const _Rule(
  final String title,
  final List<String> lines,
  final TextStyle? style,
) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpace.s3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        for (final l in lines) Text('• $l', style: style),
      ],
    ),
  );
}
