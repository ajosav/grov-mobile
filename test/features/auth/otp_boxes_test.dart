import 'package:app_mobile/core/theme/app_theme.dart';
import 'package:app_mobile/features/auth/presentation/widgets/otp_boxes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('the code field is private to the keyboard but still autofills', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: OtpBoxes(
            code: '',
            state: OtpBoxesState.entering,
            semanticLabel: 'Code',
            onChanged: (_) {},
          ),
        ),
      ),
    );
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.enableSuggestions, isFalse);
    expect(field.autocorrect, isFalse);
    expect(field.enableIMEPersonalizedLearning, isFalse);
    // Not masked, and the emailed code can still be offered by the keyboard.
    expect(field.obscureText, isFalse);
    expect(field.autofillHints, contains(AutofillHints.oneTimeCode));
    expect(field.keyboardType, TextInputType.number);
  });
}
