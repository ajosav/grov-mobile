import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../l10n/app_localizations.dart';

/// "By continuing you agree to the Terms and Privacy Policy." The two names are
/// underlined as in the design. They are not tappable yet: opening a page
/// needs a link launcher and the real URLs.
class const TermsNotice({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final base = Theme.of(context).textTheme.bodySmall
        ?.copyWith(color: context.tokens.inkMuted);
    final link = base?.copyWith(decoration: TextDecoration.underline);
    // Format with markers, then split on them, so the whole sentence stays one
    // translatable string whatever order a language puts the two names in.
    const termsMark = '\u0001';
    const privacyMark = '\u0002';
    final raw = l10n.authTermsNotice(termsMark, privacyMark);
    final spans = <InlineSpan>[];
    var rest = raw;
    while (rest.isNotEmpty) {
      final t = rest.indexOf(termsMark);
      final p = rest.indexOf(privacyMark);
      final next = [
        t,
        p,
      ].where((i) => i >= 0).fold<int>(-1, (a, b) => a < 0 || b < a ? b : a);
      if (next < 0) {
        spans.add(TextSpan(text: rest));
        break;
      }
      if (next > 0) {
        spans.add(TextSpan(text: rest.substring(0, next)));
      }
      final isTerms = next == t;
      spans.add(
        TextSpan(
          text: isTerms ? l10n.authTermsLink : l10n.authPrivacyLink,
          style: link,
        ),
      );
      rest = rest.substring(next + 1);
    }
    return Text.rich(
      TextSpan(style: base, children: spans),
      textAlign: TextAlign.center,
    );
  }
}
