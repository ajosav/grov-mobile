import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;

enum OtpBoxesState() {
  entering,
  error,
  success,
  disabled,
}

/// Six boxes over one hidden text field, so the keyboard, paste, autofill of
/// an SMS or email code and screen readers all work on a single real field.
class const OtpBoxes({
  required final String code,
  required final ValueChanged<String> onChanged,
  required final String semanticLabel,
  final int length = 6,
  final OtpBoxesState state = OtpBoxesState.entering,
  super.key,
}) extends StatefulWidget {
  @override
  State<OtpBoxes> createState() => _OtpBoxesState();
}

class _OtpBoxesState() extends State<OtpBoxes> {
  late final _controller = TextEditingController(text: widget.code);
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(OtpBoxes old) {
    super.didUpdateWidget(old);
    if (widget.code != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.code,
        selection: TextSelection.collapsed(offset: widget.code.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    final text = Theme.of(context).textTheme;
    final disabled = widget.state == OtpBoxesState.disabled;
    final focusedIndex =
        _focus.hasFocus && widget.state == OtpBoxesState.entering
        ? widget.code.length.clamp(0, widget.length - 1)
        : -1;
    return Stack(
      children: [
        Opacity(
          opacity: disabled ? 0.5 : 1,
          child: ExcludeSemantics(
            child: Row(
              children: [
                for (var i = 0; i < widget.length; i++) ...[
                  if (i > 0) const SizedBox(width: 10),
                  Expanded(
                    child: _Box(
                      digit: i < widget.code.length ? widget.code[i] : '',
                      style: text.headlineSmall!,
                      border: switch (widget.state) {
                        OtpBoxesState.error => BorderSide(
                          color: c.danger,
                          width: 2,
                        ),
                        OtpBoxesState.success => BorderSide(
                          color: c.leafStrong,
                          width: 2,
                        ),
                        _ when i == focusedIndex => BorderSide(
                          color: c.focus,
                          width: 2,
                        ),
                        _ => BorderSide(color: c.lineStrong),
                      },
                      halo: i == focusedIndex ? c.flameTint : null,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        // The real field sits on top, invisible but present for semantics.
        Positioned.fill(
          child: Semantics(
            label: widget.semanticLabel,
            textField: true,
            child: TextField(
              controller: _controller,
              focusNode: _focus,
              autofocus: !disabled,
              enabled: !disabled,
              keyboardType: TextInputType.number,
              autofillHints: const [AutofillHints.oneTimeCode],
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.length),
              ],
              showCursor: false,
              enableInteractiveSelection: false,
              style: const TextStyle(color: Colors.transparent),
              cursorColor: Colors.transparent,
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                counterText: '',
              ),
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class const _Box({
  required final String digit,
  required final TextStyle style,
  required final BorderSide border,
  final Color? halo,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: context.tokens.surfaceRaised,
      borderRadius: BorderRadius.circular(14),
      border: Border.fromBorderSide(border),
      boxShadow: halo == null
          ? null
          : [BoxShadow(color: halo!, spreadRadius: 4)],
    ),
    child: SizedBox(
      height: 56,
      child: Center(child: Text(digit, style: style)),
    ),
  );
}
