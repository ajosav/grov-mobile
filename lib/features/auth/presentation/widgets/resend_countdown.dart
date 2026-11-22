import 'dart:async';
import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import 'auth_link.dart';

class const ResendCountdown({
  required final DateTime? nextSendAt,
  required final String Function(String time) waitLabel,
  required final String resendLabel,
  required final VoidCallback onResend,
  final bool busy = false,
  final DateTime Function() now = DateTime.now,
  super.key,
}) extends StatefulWidget {
  @override
  State<ResendCountdown> createState() => _ResendCountdownState();
}

class _ResendCountdownState() extends State<ResendCountdown> {
  Timer? _timer;
  Duration _total = const Duration(seconds: 30);
  Duration _left = Duration.zero;

  @override
  void initState() {
    super.initState();
    _sync();
  }

  @override
  void didUpdateWidget(ResendCountdown old) {
    super.didUpdateWidget(old);
    if (old.nextSendAt != widget.nextSendAt) {
      _sync();
    }
  }

  void _sync() {
    _timer?.cancel();
    final target = widget.nextSendAt;
    _left = target == null
        ? Duration.zero
        : _positive(target.difference(widget.now()));
    if (_left > Duration.zero) {
      _total = _left;
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    }
  }

  void _tick() {
    final target = widget.nextSendAt;
    if (!mounted || target == null) {
      return;
    }
    setState(() => _left = _positive(target.difference(widget.now())));
    if (_left == Duration.zero) {
      _timer?.cancel();
    }
  }

  Duration _positive(Duration d) => d.isNegative ? Duration.zero : d;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_left == Duration.zero) {
      return AuthLink(
        widget.resendLabel,
        onTap: widget.busy ? null : widget.onResend,
      );
    }
    final c = context.tokens;
    final seconds = _left.inSeconds + (_left.inMilliseconds % 1000 > 0 ? 1 : 0);
    final time =
        '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            widget.waitLabel(time),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 10),
        ExcludeSemantics(
          child: SizedBox.square(
            dimension: 22,
            child: CustomPaint(
              painter: _RingPainter(
                progress: _left.inMilliseconds / _total.inMilliseconds,
                track: c.flameTint,
                arc: c.flame,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class const _RingPainter({
  required final double progress,
  required final Color track,
  required final Color arc,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 3.0;
    final rect = Offset.zero & size;
    final inner = rect.deflate(stroke / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(inner, 0, math.pi * 2, false, paint..color = track);
    canvas.drawArc(
      inner,
      -math.pi / 2,
      math.pi * 2 * progress.clamp(0, 1),
      false,
      paint..color = arc,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.track != track || old.arc != arc;
}
