import 'package:material_ui/material_ui.dart';

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
          const SizedBox.square(
            dimension: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        else if (icon != null)
          Icon(icon, size: 20),
        if (loading || icon != null) const SizedBox(width: 8),
        Flexible(child: Text(label, textAlign: TextAlign.center)),
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
