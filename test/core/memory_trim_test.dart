import 'package:app_mobile/core/platform/memory_trim.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class _SpyCache() extends ImageCache {
  int clears = 0;
  @override
  void clear() {
    clears++;
    super.clear();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _SpyCache images;
  late int svgClears;
  late int extra;
  late MemoryTrimObserver observer;

  setUp(() {
    images = _SpyCache();
    svgClears = 0;
    extra = 0;
    observer = MemoryTrimObserver(
      imageCache: images,
      clearSvgCache: () => svgClears++,
      extraTrimmers: [() => extra++],
    );
    WidgetsBinding.instance.addObserver(observer);
  });
  tearDown(() => WidgetsBinding.instance.removeObserver(observer));

  void state(AppLifecycleState s) =>
      WidgetsBinding.instance.handleAppLifecycleStateChanged(s);

  test('going to the background releases images, SVGs and extra caches', () {
    state(AppLifecycleState.hidden);
    expect(images.clears, 1);
    expect(svgClears, 1);
    expect(extra, 1);
  });

  test('paused does the same (idempotent with hidden)', () {
    state(AppLifecycleState.paused);
    expect(images.clears, 1);
    expect(svgClears, 1);
  });

  test('coming back or being inactive releases nothing', () {
    state(AppLifecycleState.inactive);
    state(AppLifecycleState.resumed);
    expect(images.clears, 0);
    expect(svgClears, 0);
    expect(extra, 0);
  });

  test('memory pressure releases SVGs and extras; the framework owns the image cache', () {
    WidgetsBinding.instance.handleMemoryPressure();
    expect(svgClears, 1);
    expect(extra, 1);
    expect(
      images.clears,
      0,
      reason: 'Flutter already clears its image cache on this signal',
    );
  });

  test('trim() releases everything on demand', () {
    observer.trim();
    expect(images.clears, 1);
    expect(svgClears, 1);
    expect(extra, 1);
  });

  test(
    'the default caches are the real ones and clearing them does not throw',
    () {
      final real = MemoryTrimObserver();
      expect(real.trim, returnsNormally);
    },
  );
}
