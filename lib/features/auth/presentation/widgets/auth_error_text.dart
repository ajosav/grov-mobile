import '../../../../core/config/brand_config.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/auth_error.dart';

extension AuthErrorText on AuthError {
  /// The sentence shown for this error. All copy is in the ARB.
  String message(AppLocalizations l10n) => switch (this) {
    AuthError.offline => l10n.errorOffline,
    AuthError.timeout => l10n.errorTimeout,
    AuthError.server => l10n.errorServer,
    AuthError.invalidEmail => l10n.errorInvalidEmail,
    AuthError.socialOnly => l10n.errorSocialOnly,
    AuthError.wrongPassword => l10n.errorWrongPassword,
    AuthError.accountLocked => l10n.errorAccountLocked,
    AuthError.emailTaken => l10n.errorEmailTaken(BrandConfig.name),
    AuthError.phoneTaken => l10n.errorPhoneTaken,
    AuthError.phoneInvalid => l10n.errorPhoneInvalid,
    AuthError.passwordCommon => l10n.authCheckCommonFailed,
    AuthError.passwordWeak => l10n.errorPasswordWeak,
    AuthError.codeInvalid => l10n.errorCodeInvalid,
    AuthError.codeExpired => l10n.errorCodeExpired,
    AuthError.codeLocked => l10n.errorCodeLocked,
    AuthError.resendTooSoon => l10n.errorServer,
    AuthError.linkExpired || AuthError.linkUsed => l10n.linkExpiredBody,
    AuthError.termsStale => l10n.errorTermsStale,
    AuthError.unsupportedStep => l10n.errorUnsupportedStep,
    AuthError.unknown => l10n.errorUnknown,
  };
}
