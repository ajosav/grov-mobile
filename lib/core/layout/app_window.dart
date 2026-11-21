import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:flutter/widgets.dart';

enum WindowClass() {
  compact,
  medium,
  expanded;

  static WindowClass fromWidth(double width) =>
      width >= 840 ? expanded : (width >= 600 ? medium : compact);
}

@immutable
class const AppWindow({
  required final Size size,
  required final WindowClass windowClass,
  final Rect? hinge,
}) {
  factory AppWindow.of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final features = MediaQuery.displayFeaturesOf(context);
    return AppWindow(
      size: size,
      windowClass: WindowClass.fromWidth(size.width),
      hinge: _separatingHinge(features),
    );
  }

  /// Test seam.
  factory AppWindow.fromSize(Size size, {Rect? hinge}) => AppWindow(
    size: size,
    windowClass: WindowClass.fromWidth(size.width),
    hinge: hinge,
  );

  bool get isCompact => windowClass == WindowClass.compact;
  bool get isExpanded => windowClass == WindowClass.expanded;
  bool get canShowTwoPanes =>
      hinge != null || windowClass != WindowClass.compact;

  bool get isSpannedHorizontally =>
      hinge != null && hinge!.height > hinge!.width;

  static Rect? _separatingHinge(List<DisplayFeature> features) {
    for (final f in features) {
      if (f.bounds.isEmpty) continue;
      final separates = switch (f.type) {
        DisplayFeatureType.hinge => true,
        DisplayFeatureType.fold => f.state != DisplayFeatureState.postureFlat,
        _ => false,
      };
      if (separates) return f.bounds;
    }
    return null;
  }

  @override
  bool operator ==(Object other) =>
      other is AppWindow && other.size == size && other.hinge == hinge;

  @override
  int get hashCode => Object.hash(size, hinge);
}
