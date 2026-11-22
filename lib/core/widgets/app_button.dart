import 'package:material_ui/material_ui.dart';

import 'app_progress.dart';

enum AppButtonKind() {
  primary,
  secondary,
  ghost,
}

class const AppButton({
  required final String label,
  required final VoidCallback? onPressed,
  final AppButtonKind kind = AppButtonKind.primary,
  final bool loading = false,
  final String? loadingLabel,
  final IconData? icon,

  final Widget? trailing,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onTap = loading ? null : onPressed;
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (loading)
          // The spinner takes the button's own text colour, so it shows on
          // the dark filled button as well as the outlined one.
          Builder(
            builder: (context) => AppProgress(
              size: 18,
              color: DefaultTextStyle.of(context).style.color,
            ),
          )
        else if (icon != null)
          Icon(icon, size: 20),
        if (loading || icon != null) const SizedBox(width: 8),
        Flexible(
          child: Text(
            loading ? (loadingLabel ?? label) : label,
            textAlign: TextAlign.center,
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ],
    );
    return switch (kind) {
      AppButtonKind.primary => FilledButton(
        onPressed: onTap ?? (loading ? () {} : null),
        child: child,
      ),
      AppButtonKind.secondary => OutlinedButton(onPressed: onTap, child: child),
      AppButtonKind.ghost => TextButton(onPressed: onTap, child: child),
    };
  }
}
