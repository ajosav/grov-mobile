import 'dart:ui';

import 'package:material_ui/material_ui.dart';

import '../theme/app_performance.dart';
import '../theme/app_tokens.dart' hide formatNaira;

class const GlassCard({
  required final Widget child,
  final bool blur = false,
  final EdgeInsetsGeometry padding = const EdgeInsets.all(18),
  final double radius = AppRadius.lg,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    final performance = AppPerformance.of(context);
    final canBlur = blur && performance.allowsBlur(context);
    final shape = BorderRadius.circular(radius);

    final surface = DecoratedBox(
      decoration: BoxDecoration(
        color: (blur && !canBlur) ? c.glassStrong : c.glass,
        borderRadius: shape,
      ),
      child: CustomPaint(
        // Behind the content: the light and the inner highlight and edge.
        painter: _GlassLightPainter(
          radius: radius,
          highlight: c.glassStroke,
          edge: c.glassEdge,
        ),
        foregroundPainter: _GlassRimPainter(
          radius: radius,
          highlight: c.glassStroke,
        ),
        child: Padding(padding: padding, child: child),
      ),
    );

    final body = canBlur
        ? ClipRRect(
            borderRadius: shape,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: surface,
            ),
          )
        : surface;

    return RepaintBoundary(
      child: CustomPaint(
        painter: _GlassShadowPainter(
          radius: radius,
          color: c.glassEdge,
          soft: !performance.lowEnd,
        ),
        child: body,
      ),
    );
  }
}

Color _scale(Color color, double factor) =>
    color.withValues(alpha: (color.a * factor).clamp(0.0, 1.0));

class const _GlassShadowPainter({
  required final double radius,
  required final Color color,
  required final bool soft,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final outside = Path.combine(
      PathOperation.difference,
      Path()..addRect((Offset.zero & size).inflate(120)),
      Path()..addRRect(rrect),
    );
    canvas
      ..save()
      ..clipPath(outside);
    if (soft) {
      canvas.drawRRect(
        rrect.shift(const Offset(0, 8)),
        Paint()
          ..color = color
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16),
      );
    }
    canvas
      ..drawRRect(
        rrect.shift(const Offset(0, 1)),
        Paint()
          ..color = _scale(color, 0.66)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
      )
      ..restore();
  }

  @override
  bool shouldRepaint(_GlassShadowPainter old) =>
      old.radius != radius || old.color != color || old.soft != soft;
}

class const _GlassLightPainter({
  required final double radius,
  required final Color highlight,
  required final Color edge,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas
      ..save()
      ..clipRRect(rrect);

    // Light from above: Figma fades `glass-stroke` at half strength to nothing
    // over the top 43% of the card.
    canvas.drawRRect(
      rrect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_scale(highlight, 0.5), _scale(highlight, 0)],
          stops: const [0, 0.4286],
        ).createShader(rect),
    );

    // A soft sheen where the light hits, the top-left corner.
    canvas.drawRRect(
      rrect,
      Paint()
        ..shader = RadialGradient(
          center: Alignment.topLeft,
          radius: 1.15,
          colors: [_scale(highlight, 0.45), _scale(highlight, 0)],
        ).createShader(rect),
    );

    // Inner shadows (Figma): light 1/1 blur 1, dark -1/-1 blur 2. An inner
    // shadow is the card's outline, shifted, with the card cut out.
    void inner(Color color, Offset offset, double blur) {
      final path = Path()
        ..fillType = PathFillType.evenOdd
        ..addRect(rect.inflate(40))
        ..addRRect(rrect.shift(offset));
      canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur / 2),
      );
    }

    inner(highlight, const Offset(1, 1), 1);
    inner(edge, const Offset(-1, -1), 2);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_GlassLightPainter old) =>
      old.radius != radius || old.highlight != highlight || old.edge != edge;
}

class const _GlassRimPainter({
  required final double radius,
  required final Color highlight,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const width = 1.25;
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect.deflate(width / 2),
      Radius.circular(radius - width / 2),
    );
    // A faint line all the way round, so the edge never vanishes.
    canvas
      ..drawRRect(
        rrect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = width
          ..color = _scale(highlight, 0.4),
      )
      // The catch-light on top.
      ..drawRRect(
        rrect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = width
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              highlight,
              _scale(highlight, 0),
              _scale(highlight, 0),
              _scale(highlight, 0.7),
            ],
            stops: const [0, 0.3, 0.7, 1],
          ).createShader(rect),
      );
  }

  @override
  bool shouldRepaint(_GlassRimPainter old) =>
      old.radius != radius || old.highlight != highlight;
}
