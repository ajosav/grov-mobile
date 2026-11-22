// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navShop => 'Shop';

  @override
  String get navPlan => 'Plan';

  @override
  String get navOrders => 'Orders';

  @override
  String get navSavings => 'Savings';

  @override
  String get homeNoPlanTitle => 'No plan yet';

  @override
  String homeNoPlanBody(String brand) {
    return 'Set up your household and $brand builds a food plan you can edit.';
  }

  @override
  String get comingSoonTitle => 'Coming soon';

  @override
  String comingSoonBody(String brand) {
    return 'This part of $brand is not built yet.';
  }

  @override
  String syncedAt(String time) {
    return 'Synced $time';
  }

  @override
  String offlineLastSynced(String time) {
    return 'Offline · last synced $time';
  }

  @override
  String get offlineNeverSynced => 'Offline · not synced yet';

  @override
  String get neverSynced => 'Not synced yet';

  @override
  String get offlineBannerTitle => 'You\'re offline';

  @override
  String get offlineBannerBody =>
      'Your plan and lists still work. Checkout and adding money need a connection.';

  @override
  String get accountTitle => 'Account';

  @override
  String get accountOpenLabel => 'Open account';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get appearanceSystem => 'System';

  @override
  String get appearanceLight => 'Light';

  @override
  String get appearanceDark => 'Dark';

  @override
  String get lowEndTitle => 'Low-end mode';

  @override
  String lowEndHelp(String brand) {
    return 'Turns off blur and animation to keep $brand fast on older phones.';
  }

  @override
  String get lowEndAuto => 'Automatic';

  @override
  String get lowEndOn => 'On';

  @override
  String get lowEndOff => 'Off';

  @override
  String get signOut => 'Sign out';

  @override
  String get backLabel => 'Back';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailHint => 'you@example.com';

  @override
  String get authContinue => 'Continue';

  @override
  String get authOr => 'or';

  @override
  String get authChange => 'Change';

  @override
  String get authLogIn => 'Log in';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authPasswordHint => 'Your password';

  @override
  String get authShowPassword => 'Show password';

  @override
  String get authHidePassword => 'Hide password';

  @override
  String authTermsNotice(String terms, String privacy) {
    return 'By continuing you agree to the $terms and $privacy.';
  }

  @override
  String get authTermsLink => 'Terms';

  @override
  String get authPrivacyLink => 'Privacy Policy';

  @override
  String get authTermsAcceptance => 'I agree to the Terms and Conditions.';

  @override
  String get authTermsLoading => 'Checking the current terms…';

  @override
  String get authGoogleLabel => 'Continue with Google';

  @override
  String get authAppleLabel => 'Continue with Apple';

  @override
  String get authSocialSoon =>
      'Signing in with Google or Apple is coming soon. Use your email for now.';

  @override
  String get authOfflineBanner =>
      'Sign-on needs a connection. Check your network and try again.';

  @override
  String get authTryAgain => 'Try again';

  @override
  String authRetryCountdown(Object time) {
    return 'Try again in $time';
  }

  @override
  String get passwordTitle => 'Welcome back';

  @override
  String get passwordSubtitle => 'Enter your password to log in.';

  @override
  String get authForgotLink => 'Forgot password?';

  @override
  String get errorAccountLocked =>
      'Too many tries. Try again later, or reset your password.';

  @override
  String get errorSocialOnly => 'This email signs in with Google or Apple.';

  @override
  String get joinTitle => 'Let’s set you up';

  @override
  String get joinSubtitle => 'A few details and you are in.';

  @override
  String get authFirstNameLabel => 'First name';

  @override
  String get authLastNameLabel => 'Last name';

  @override
  String get authPhoneLabel => 'Phone number';

  @override
  String get authPhoneHelper => 'Type 0803… or 803…';

  @override
  String get authCheckLength => '8 or more characters';

  @override
  String get authCheckSymbol => 'Includes a symbol, like ! or #';

  @override
  String get authCheckCommon => 'Not a common password';

  @override
  String get authCheckCommonFailed => 'Not a common password. Try another.';

  @override
  String get authCreateAccount => 'Create account';

  @override
  String errorEmailTaken(String brand) {
    return 'That email already has a $brand account.';
  }

  @override
  String get errorPhoneTaken =>
      'This number is already on an account. Log in with that email, or use a different number.';

  @override
  String get errorPhoneInvalid => 'Enter a valid Nigerian mobile number.';

  @override
  String get errorPasswordWeak => 'Use at least 8 characters with a symbol.';

  @override
  String get errorInvalidEmail => 'Enter a valid email address.';

  @override
  String get codeTitle => 'Check your email';

  @override
  String get codeSentTo => 'We sent a 6-digit code to';

  @override
  String get codeChangeEmail => 'Change email';

  @override
  String codeResendIn(String time) {
    return 'Resend code in $time';
  }

  @override
  String get codeResend => 'Resend code';

  @override
  String codeNote(String email) {
    return 'Enter the code we sent to $email so only you can open your account.';
  }

  @override
  String get codeFieldLabel => '6-digit code';

  @override
  String get errorCodeInvalid =>
      'That code isn’t right. Check it and try again.';

  @override
  String get errorCodeExpired => 'That code has expired. Ask for a new one.';

  @override
  String get errorCodeLocked =>
      'Too many tries. Try again in 15 minutes, or ask for a new code.';

  @override
  String get codeSendNew => 'Send a new code';

  @override
  String get codeAcceptedTitle => 'Email verified';

  @override
  String get codeAcceptedSub => 'Thanks. That is the code we sent to';

  @override
  String get codeTakingYouIn => 'Taking you in…';

  @override
  String get changeEmailTitle => 'Change your email';

  @override
  String get changeEmailSave => 'Send a new code';

  @override
  String get changeEmailCancel => 'Cancel';

  @override
  String get forgotTitle => 'Reset your password';

  @override
  String get forgotSubtitle => 'Enter your email and we’ll send you a link.';

  @override
  String get forgotSend => 'Send reset link';

  @override
  String get forgotBack => 'Back to log in';

  @override
  String forgotSentBody(String email) {
    return 'We sent a reset link to $email. It works for 30 minutes.';
  }

  @override
  String forgotResendIn(String time) {
    return 'Resend link in $time';
  }

  @override
  String get forgotOpenMail => 'Open email app';

  @override
  String get forgotOpenMailHint =>
      'Open your email app and look for our message.';

  @override
  String get forgotDidntGet => 'I didn’t get it';

  @override
  String get helpTitle => 'Didn’t get the email?';

  @override
  String get helpSubtitle => 'Try these, then send the link again.';

  @override
  String get helpTipSpam => 'Look in spam or promotions.';

  @override
  String helpTipAddress(String email) {
    return 'Check the address is right: $email';
  }

  @override
  String get helpTipNetwork => 'On a weak network it can take a few minutes.';

  @override
  String get helpSendAgain => 'Send the link again';

  @override
  String get helpDifferentEmail => 'Use a different email';

  @override
  String get helpContactSupport => 'Contact support';

  @override
  String get helpContactSoon => 'Support contact is not set up yet.';

  @override
  String get resetTitle => 'Set a new password';

  @override
  String resetSubtitle(String brand) {
    return 'Choose one you have not used on $brand before.';
  }

  @override
  String get resetNewPasswordLabel => 'New password';

  @override
  String get resetSave => 'Save password';

  @override
  String get linkExpiredTitle => 'This link has expired';

  @override
  String get linkExpiredBody =>
      'Reset links work once and last 30 minutes. Send a new one to carry on.';

  @override
  String get linkSendNew => 'Send a new link';

  @override
  String get phoneTitle => 'One more step';

  @override
  String get phoneSubtitle =>
      'Add a phone number for your account and your rider.';

  @override
  String get doneTitle => 'You’re in';

  @override
  String get doneBody =>
      'Your account is ready. Set up your plan now, or look around first.';

  @override
  String get doneSetup => 'Set up my plan';

  @override
  String get doneNotNow => 'Not now';

  @override
  String get errorOffline =>
      'We couldn’t connect. Check your connection and try again.';

  @override
  String get errorTimeout => 'That took too long. Try again.';

  @override
  String get errorServer => 'Something went wrong on our side. Try again.';

  @override
  String get errorUnknown => 'Something went wrong. Try again.';

  @override
  String get errorUnsupportedStep =>
      'This sign-in needs a step this version of the app can’t do yet.';

  @override
  String get errorTermsStale =>
      'The terms have changed. Refresh them and agree to continue.';

  @override
  String get errorPhoneAlreadySet =>
      'This account already has a phone number. You can change it in settings.';

  @override
  String get errorEmailAlreadyVerified =>
      'Your email is already confirmed. Sign in again to carry on.';

  @override
  String get errorEmailChangeNotStarted =>
      'Ask for a code to your new email first.';

  @override
  String homeGreetingMorning(String name) {
    return 'Good morning, $name';
  }

  @override
  String homeGreetingAfternoon(String name) {
    return 'Good afternoon, $name';
  }

  @override
  String homeGreetingEvening(String name) {
    return 'Good evening, $name';
  }

  @override
  String get homeEncouragement => 'You’re making great progress!';

  @override
  String get homeNotificationsLabel => 'Notifications';

  @override
  String get homeWeekProgressTitle => 'This week’s progress';

  @override
  String get homeBudgetUsed => 'Budget used';

  @override
  String homeBudgetPercent(int percent) {
    return '$percent%';
  }

  @override
  String get homeMealsCompleted => 'Meals completed';

  @override
  String homeMealsCount(int done, int total) {
    return '$done / $total';
  }

  @override
  String get homeMealIdeasTitle => 'Today’s meal ideas';

  @override
  String get homeViewAll => 'View all';

  @override
  String get mealTimeBreakfast => 'Breakfast';

  @override
  String get mealTimeLunch => 'Lunch';

  @override
  String get mealTimeDinner => 'Dinner';

  @override
  String get mealTimeSnack => 'Snack';

  @override
  String homeMealSubtitle(String mealTime) {
    return '$mealTime · meal idea';
  }

  @override
  String get homeCooked => 'Cooked';

  @override
  String get homeStockListTitle => 'Stock list';

  @override
  String homeStockListSummary(int count, String amount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items still to buy',
      one: '1 item still to buy',
    );
    return '$_temp0 · $amount';
  }

  @override
  String get homeQuickActionsTitle => 'Quick actions';

  @override
  String get homeActionViewPlan => 'View plan';

  @override
  String get homeActionBulkCooked => 'Bulk cooked food';

  @override
  String get homeActionSharingSlot => 'Book a sharing slot';

  @override
  String get homeActionAdjustBudget => 'Adjust budget';

  @override
  String get homeLoadFailedTitle => 'Home did not load';

  @override
  String get homeLoadFailedBody => 'Check your connection and try again.';

  @override
  String get homeRetry => 'Try again';

  @override
  String get loadingLabel => 'Loading';

  @override
  String get homeLoadingLabel => 'Loading your home';

  @override
  String get commonRetry => 'Try again';

  @override
  String get pagedLoadFailedTitle => 'This did not load';

  @override
  String get pagedLoadFailedBody => 'Check your connection and try again.';

  @override
  String get pagedLoadMoreFailed => 'Could not load more.';

  @override
  String get authBusyChecking => 'Checking…';

  @override
  String get authBusySigningIn => 'Signing in…';

  @override
  String get authBusyCreating => 'Creating your account…';

  @override
  String get authBusyVerifying => 'Verifying…';

  @override
  String get authBusySaving => 'Saving…';

  @override
  String get authBusySending => 'Sending…';

  @override
  String get authLoadingLink => 'Checking your link';

  @override
  String get startingUp => 'Starting up';
}
