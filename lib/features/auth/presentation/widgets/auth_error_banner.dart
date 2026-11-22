import 'dart:async';
import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../l10n/app_localizations.dart';
import '../cubit/auth_error.dart';
import 'auth_banner.dart';
import 'auth_error_text.dart';

class const AuthErrorBanner(
  final AuthError error, {
  final VoidCallback? onRetry,
  final String? serverMessage,
  final DateTime? retryAt,
  final VoidCallback? onRetryAvailable,
  super.key,
}) extends StatefulWidget {
  @override
  State<AuthErrorBanner> createState() => _AuthErrorBannerState();
}

class _AuthErrorBannerState() extends State<AuthErrorBanner> {
  Timer? _timer;
  Duration _left = Duration.zero;
  Duration _total = Duration.zero;

  @override
  void initState() {
    super.initState();
    _sync();
  }

  @override
  void didUpdateWidget(AuthErrorBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.retryAt != widget.retryAt) {
      _sync();
    }
  }

  void _sync() {
    _timer?.cancel();
    final target = widget.retryAt;
    _left = target == null
        ? Duration.zero
        : target.difference(DateTime.now());
    if (_left.isNegative) {
      _left = Duration.zero;
    }
    if (_left > Duration.zero) {
      _total = _left;
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    }
  }

  void _tick() {
    final target = widget.retryAt;
    if (!mounted || target == null) {
      return;
    }
    final left = target.difference(DateTime.now());
    setState(() {
      _left = left.isNegative ? Duration.zero : left;
    });
    if (_left == Duration.zero) {
      _timer?.cancel();
      widget.onRetryAvailable?.call();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final neutral =
        widget.error == AuthError.offline || widget.error == AuthError.timeout;
    final seconds = _left.inSeconds + (_left.inMilliseconds % 1000 > 0 ? 1 : 0);
    final time = seconds >= 3600
        ? '${seconds ~/ 3600}:${((seconds % 3600) ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}'
        : '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
    return AuthBanner(
      widget.serverMessage ?? widget.error.message(l10n),
      kind: neutral ? AuthBannerKind.info : AuthBannerKind.danger,
      actionLabel: _left == Duration.zero &&
              neutral &&
              widget.onRetry != null
          ? l10n.authTryAgain
          : null,
      onAction: neutral ? widget.onRetry : null,
      trailing: _left > Duration.zero
          ? Semantics(
              label: l10n.authRetryCountdown(time),
              child: _AnalogCountdownClock(
                time,
                progress: _progress,
              ),
            )
          : null,
    );
  }

  double get _progress {
    if (_total == Duration.zero || _left == Duration.zero) {
      return 0;
    }
    return (_left.inMilliseconds / _total.inMilliseconds).clamp(0, 1);
  }
}

class const _AnalogCountdownClock(
  final String time, {
  required final double progress,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    final text = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          dimension: 44,
          child: CustomPaint(
            painter: _AnalogClockPainter(
              progress: progress,
              track: c.dangerTint,
              arc: c.danger,
              tick: c.danger,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          time,
          style: text.labelMedium?.copyWith(
            color: c.danger,
          ),
        ),
      ],
    );
  }
}

class const _AnalogClockPainter({
  required final double progress,
  required final Color track,
  required final Color arc,
  required final Color tick,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 3;
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = track;
    canvas.drawCircle(center, radius, trackPaint);

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = arc;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      arcPaint,
    );

    final tickPaint = Paint()
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..color = tick.withValues(alpha: 0.55);
    for (var i = 0; i < 12; i++) {
      final angle = i * math.pi / 6;
      final outer = Offset(
        center.dx + math.cos(angle) * (radius - 5),
        center.dy + math.sin(angle) * (radius - 5),
      );
      final inner = Offset(
        center.dx + math.cos(angle) * (radius - 8),
        center.dy + math.sin(angle) * (radius - 8),
      );
      canvas.drawLine(inner, outer, tickPaint);
    }

    final handAngle = -math.pi / 2 + math.pi * 2 * (1 - progress);
    final handEnd = Offset(
      center.dx + math.cos(handAngle) * (radius - 12),
      center.dy + math.sin(handAngle) * (radius - 12),
    );
    canvas.drawLine(
      center,
      handEnd,
      Paint()
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..color = tick,
    );
    canvas.drawCircle(center, 2.5, Paint()..color = tick);
  }

  @override
  bool shouldRepaint(_AnalogClockPainter old) =>
      old.progress != progress ||
      old.track != track ||
      old.arc != arc ||
      old.tick != tick;
}
