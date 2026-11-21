import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import 'auth_helper.dart';

/// Label row + 52px input (Figma "Field"). Border: 1px line-strong at rest,
/// 2px ink when focused, 2px danger on error.
class const AuthField({
  required final String label,
  required final TextEditingController controller,
  final FocusNode? focusNode,
  final String? hint,
  final bool obscure = false,
  final bool readOnly = false,
  final bool hasError = false,
  final bool autofocus = false,
  final Widget? prefix,
  final Widget? suffix,
  final TextInputType? keyboardType,
  final TextInputAction? textInputAction,
  final TextCapitalization textCapitalization = TextCapitalization.none,
  final Iterable<String>? autofillHints,
  final ValueChanged<String>? onChanged,
  final ValueChanged<String>? onSubmitted,
  final String? helper,
  final String? errorText,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    final text = Theme.of(context).textTheme;
    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: color, width: width),
    );
    final rest = hasError ? border(c.danger, 2) : border(c.lineStrong, 1);
    final focused = hasError ? border(c.danger, 2) : border(c.focus, 2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: text.titleSmall),
        const SizedBox(height: AppSpace.s2),
        TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: autofocus,
          obscureText: obscure,
          readOnly: readOnly,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          autofillHints: autofillHints,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: text.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: text.bodyLarge?.copyWith(color: c.inkMuted),
            filled: true,
            fillColor: c.surface,
            contentPadding: EdgeInsets.fromLTRB(
              prefix == null ? AppSpace.s4 : 0,
              AppSpace.s3 + 2,
              suffix == null ? AppSpace.s4 : 0,
              AppSpace.s3 + 2,
            ),
            border: rest,
            enabledBorder: rest,
            focusedBorder: focused,
            prefixIcon: prefix == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(
                      left: AppSpace.s4,
                      right: AppSpace.s3,
                    ),
                    child: prefix,
                  ),
            prefixIconConstraints: const BoxConstraints(),
            suffixIcon: suffix == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(right: AppSpace.s2),
                    child: suffix,
                  ),
            suffixIconConstraints: const BoxConstraints(),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpace.s2),
          AuthHelper(errorText!, error: true),
        ] else if (helper != null) ...[
          const SizedBox(height: AppSpace.s2),
          AuthHelper(helper!),
        ],
      ],
    );
  }
}
