import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Gives memory back that the app can rebuild, so it is not held while the app
/// is out of sight or the phone is short of RAM.
///
/// Google Play's bitmap-memory vital (from February 2027) says bitmaps should
/// not stay in memory in background and cached states, and the phones we
/// target have 2 GB. What is released:
///
/// - **Backgrounded** (`hidden`, `paused`): the decoded-image cache and the
///   parsed-SVG cache. Both refill on demand when the app returns.
/// - **Memory pressure**: the parsed-SVG cache. Flutter itself already clears
///   the image cache on this signal, so it is not repeated here.
///
/// Anything else that holds rebuildable GPU or bitmap memory (a blur capture,
/// a glass texture) should be released through [trim] too.
class MemoryTrimObserver({
  /// Test seams; default to the app's real caches.
  final ImageCache? imageCache,
  final VoidCallback? clearSvgCache,
  final List<VoidCallback> extraTrimmers = const [],
}) with WidgetsBindingObserver {
  /// Releases every rebuildable cache. Safe to call at any time.
  void trim() {
    (imageCache ?? PaintingBinding.instance.imageCache).clear();
    _clearSvg();
    for (final release in extraTrimmers) {
      release();
    }
  }

  void _clearSvg() => (clearSvgCache ?? svg.cache.clear)();

  @override
  void didHaveMemoryPressure() {
    _clearSvg();
    for (final release in extraTrimmers) {
      release();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.hidden ||
        state == AppLifecycleState.paused) {
      trim();
    }
  }
}
