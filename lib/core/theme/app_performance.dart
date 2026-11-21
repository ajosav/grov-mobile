import 'package:flutter/widgets.dart';

/// What this phone can afford. Blur, theme animation and the image cache all
/// read it. Provided above the router by the app shell.
@immutable
class const AppPerformance({final bool lowEnd = false}) {
  /// Image cache cap in bytes: tighter on 2 GB phones.
  int get imageCacheBytes => lowEnd ? 40 * 1024 * 1024 : 100 * 1024 * 1024;

  /// Blur only on capable devices, with high contrast off.
  bool allowsBlur(BuildContext context) =>
      !lowEnd && !MediaQuery.highContrastOf(context);

  /// Zero when the OS asks to reduce motion, or on low-end devices.
  Duration themeAnimation(BuildContext context) =>
      lowEnd || MediaQuery.disableAnimationsOf(context)
      ? Duration.zero
      : const Duration(milliseconds: 300);

  static AppPerformance of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<_PerformanceScope>()
          ?.performance ??
      const AppPerformance();

  @override
  bool operator ==(Object other) =>
      other is AppPerformance && other.lowEnd == lowEnd;

  @override
  int get hashCode => lowEnd.hashCode;
}

class const AppPerformanceScope({
  required final AppPerformance performance,
  required final Widget child,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      _PerformanceScope(performance: performance, child: child);
}

class const _PerformanceScope({
  required final AppPerformance performance,
  required super.child,
}) extends InheritedWidget {
  @override
  bool updateShouldNotify(_PerformanceScope old) =>
      old.performance != performance;
}
