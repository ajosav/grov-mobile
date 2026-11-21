import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get navShop;

  /// No description provided for @navPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get navPlan;

  /// No description provided for @navOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get navOrders;

  /// No description provided for @navSavings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get navSavings;

  /// No description provided for @homeNoPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'No plan yet'**
  String get homeNoPlanTitle;

  /// No description provided for @homeNoPlanBody.
  ///
  /// In en, this message translates to:
  /// **'Set up your household and {brand} builds a food plan you can edit.'**
  String homeNoPlanBody(String brand);

  /// No description provided for @comingSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoonTitle;

  /// No description provided for @comingSoonBody.
  ///
  /// In en, this message translates to:
  /// **'This part of {brand} is not built yet.'**
  String comingSoonBody(String brand);

  /// No description provided for @syncedAt.
  ///
  /// In en, this message translates to:
  /// **'Synced {time}'**
  String syncedAt(String time);

  /// No description provided for @offlineLastSynced.
  ///
  /// In en, this message translates to:
  /// **'Offline · last synced {time}'**
  String offlineLastSynced(String time);

  /// No description provided for @offlineNeverSynced.
  ///
  /// In en, this message translates to:
  /// **'Offline · not synced yet'**
  String get offlineNeverSynced;

  /// No description provided for @neverSynced.
  ///
  /// In en, this message translates to:
  /// **'Not synced yet'**
  String get neverSynced;

  /// No description provided for @offlineBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline'**
  String get offlineBannerTitle;

  /// No description provided for @offlineBannerBody.
  ///
  /// In en, this message translates to:
  /// **'Your plan and lists still work. Checkout and adding money need a connection.'**
  String get offlineBannerBody;

  /// No description provided for @accountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountTitle;

  /// No description provided for @accountOpenLabel.
  ///
  /// In en, this message translates to:
  /// **'Open account'**
  String get accountOpenLabel;

  /// No description provided for @appearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceTitle;

  /// No description provided for @appearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get appearanceSystem;

  /// No description provided for @appearanceLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get appearanceLight;

  /// No description provided for @appearanceDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get appearanceDark;

  /// No description provided for @lowEndTitle.
  ///
  /// In en, this message translates to:
  /// **'Low-end mode'**
  String get lowEndTitle;

  /// No description provided for @lowEndHelp.
  ///
  /// In en, this message translates to:
  /// **'Turns off blur and animation to keep {brand} fast on older phones.'**
  String lowEndHelp(String brand);

  /// No description provided for @lowEndAuto.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get lowEndAuto;

  /// No description provided for @lowEndOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get lowEndOn;

  /// No description provided for @lowEndOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get lowEndOff;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @backLabel.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backLabel;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get authEmailHint;

  /// No description provided for @authContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get authContinue;

  /// No description provided for @authOr.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get authOr;

  /// No description provided for @authChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get authChange;

  /// No description provided for @authLogIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get authLogIn;

  /// No description provided for @authPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// No description provided for @authPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get authPasswordHint;

  /// No description provided for @authShowPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get authShowPassword;

  /// No description provided for @authHidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get authHidePassword;

  /// No description provided for @authTermsNotice.
  ///
  /// In en, this message translates to:
  /// **'By continuing you agree to the {terms} and {privacy}.'**
  String authTermsNotice(String terms, String privacy);

  /// No description provided for @authTermsLink.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get authTermsLink;

  /// No description provided for @authPrivacyLink.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get authPrivacyLink;

  /// No description provided for @authTermsAcceptance.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms and Conditions.'**
  String get authTermsAcceptance;

  /// No description provided for @authTermsLoading.
  ///
  /// In en, this message translates to:
  /// **'Checking the current terms…'**
  String get authTermsLoading;

  /// No description provided for @authGoogleLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authGoogleLabel;

  /// No description provided for @authAppleLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get authAppleLabel;

  /// No description provided for @authSocialSoon.
  ///
  /// In en, this message translates to:
  /// **'Signing in with Google or Apple is coming soon. Use your email for now.'**
  String get authSocialSoon;

  /// No description provided for @authOfflineBanner.
  ///
  /// In en, this message translates to:
  /// **'Sign-on needs a connection. Check your network and try again.'**
  String get authOfflineBanner;

  /// No description provided for @authTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get authTryAgain;

  /// No description provided for @passwordTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get passwordTitle;

  /// No description provided for @passwordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your password to log in.'**
  String get passwordSubtitle;

  /// No description provided for @authForgotLink.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotLink;

  /// No description provided for @errorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'That password isn’t right. Try again, or reset it.'**
  String get errorWrongPassword;

  /// No description provided for @errorAccountLocked.
  ///
  /// In en, this message translates to:
  /// **'Too many tries. Try again later, or reset your password.'**
  String get errorAccountLocked;

  /// No description provided for @errorSocialOnly.
  ///
  /// In en, this message translates to:
  /// **'This email signs in with Google or Apple.'**
  String get errorSocialOnly;

  /// No description provided for @joinTitle.
  ///
  /// In en, this message translates to:
  /// **'Let’s set you up'**
  String get joinTitle;

  /// No description provided for @joinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A few details and you are in.'**
  String get joinSubtitle;

  /// No description provided for @authFirstNameLabel.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get authFirstNameLabel;

  /// No description provided for @authLastNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get authLastNameLabel;

  /// No description provided for @authPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get authPhoneLabel;

  /// No description provided for @authPhoneHelper.
  ///
  /// In en, this message translates to:
  /// **'Type 0803… or 803…'**
  String get authPhoneHelper;

  /// No description provided for @authCheckLength.
  ///
  /// In en, this message translates to:
  /// **'8 or more characters'**
  String get authCheckLength;

  /// No description provided for @authCheckSymbol.
  ///
  /// In en, this message translates to:
  /// **'Includes a symbol, like ! or #'**
  String get authCheckSymbol;

  /// No description provided for @authCheckCommon.
  ///
  /// In en, this message translates to:
  /// **'Not a common password'**
  String get authCheckCommon;

  /// No description provided for @authCheckCommonFailed.
  ///
  /// In en, this message translates to:
  /// **'Not a common password. Try another.'**
  String get authCheckCommonFailed;

  /// No description provided for @authCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authCreateAccount;

  /// No description provided for @errorEmailTaken.
  ///
  /// In en, this message translates to:
  /// **'That email already has a {brand} account.'**
  String errorEmailTaken(String brand);

  /// No description provided for @errorPhoneTaken.
  ///
  /// In en, this message translates to:
  /// **'This number is already on an account. Log in with that email, or use a different number.'**
  String get errorPhoneTaken;

  /// No description provided for @errorPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid Nigerian mobile number.'**
  String get errorPhoneInvalid;

  /// No description provided for @errorPasswordWeak.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters with a symbol.'**
  String get errorPasswordWeak;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get errorInvalidEmail;

  /// No description provided for @codeTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get codeTitle;

  /// No description provided for @codeSentTo.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to'**
  String get codeSentTo;

  /// No description provided for @codeChangeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get codeChangeEmail;

  /// No description provided for @codeResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in {time}'**
  String codeResendIn(String time);

  /// No description provided for @codeResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get codeResend;

  /// No description provided for @codeNote.
  ///
  /// In en, this message translates to:
  /// **'Enter the code we sent to {email} so only you can open your account.'**
  String codeNote(String email);

  /// No description provided for @codeFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'6-digit code'**
  String get codeFieldLabel;

  /// No description provided for @errorCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'That code isn’t right. Check it and try again.'**
  String get errorCodeInvalid;

  /// No description provided for @errorCodeExpired.
  ///
  /// In en, this message translates to:
  /// **'That code has expired. Ask for a new one.'**
  String get errorCodeExpired;

  /// No description provided for @errorCodeLocked.
  ///
  /// In en, this message translates to:
  /// **'Too many tries. Try again in 15 minutes, or ask for a new code.'**
  String get errorCodeLocked;

  /// No description provided for @codeSendNew.
  ///
  /// In en, this message translates to:
  /// **'Send a new code'**
  String get codeSendNew;

  /// No description provided for @codeAcceptedTitle.
  ///
  /// In en, this message translates to:
  /// **'Email verified'**
  String get codeAcceptedTitle;

  /// No description provided for @codeAcceptedSub.
  ///
  /// In en, this message translates to:
  /// **'Thanks. That is the code we sent to'**
  String get codeAcceptedSub;

  /// No description provided for @codeTakingYouIn.
  ///
  /// In en, this message translates to:
  /// **'Taking you in…'**
  String get codeTakingYouIn;

  /// No description provided for @changeEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Change your email'**
  String get changeEmailTitle;

  /// No description provided for @changeEmailSave.
  ///
  /// In en, this message translates to:
  /// **'Send a new code'**
  String get changeEmailSave;

  /// No description provided for @changeEmailCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get changeEmailCancel;

  /// No description provided for @forgotTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get forgotTitle;

  /// No description provided for @forgotSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we’ll send you a link.'**
  String get forgotSubtitle;

  /// No description provided for @forgotSend.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get forgotSend;

  /// No description provided for @forgotBack.
  ///
  /// In en, this message translates to:
  /// **'Back to log in'**
  String get forgotBack;

  /// No description provided for @forgotSentBody.
  ///
  /// In en, this message translates to:
  /// **'We sent a reset link to {email}. It works for 30 minutes.'**
  String forgotSentBody(String email);

  /// No description provided for @forgotResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend link in {time}'**
  String forgotResendIn(String time);

  /// No description provided for @forgotOpenMail.
  ///
  /// In en, this message translates to:
  /// **'Open email app'**
  String get forgotOpenMail;

  /// No description provided for @forgotOpenMailHint.
  ///
  /// In en, this message translates to:
  /// **'Open your email app and look for our message.'**
  String get forgotOpenMailHint;

  /// No description provided for @forgotDidntGet.
  ///
  /// In en, this message translates to:
  /// **'I didn’t get it'**
  String get forgotDidntGet;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Didn’t get the email?'**
  String get helpTitle;

  /// No description provided for @helpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Try these, then send the link again.'**
  String get helpSubtitle;

  /// No description provided for @helpTipSpam.
  ///
  /// In en, this message translates to:
  /// **'Look in spam or promotions.'**
  String get helpTipSpam;

  /// No description provided for @helpTipAddress.
  ///
  /// In en, this message translates to:
  /// **'Check the address is right: {email}'**
  String helpTipAddress(String email);

  /// No description provided for @helpTipNetwork.
  ///
  /// In en, this message translates to:
  /// **'On a weak network it can take a few minutes.'**
  String get helpTipNetwork;

  /// No description provided for @helpSendAgain.
  ///
  /// In en, this message translates to:
  /// **'Send the link again'**
  String get helpSendAgain;

  /// No description provided for @helpDifferentEmail.
  ///
  /// In en, this message translates to:
  /// **'Use a different email'**
  String get helpDifferentEmail;

  /// No description provided for @helpContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get helpContactSupport;

  /// No description provided for @helpContactSoon.
  ///
  /// In en, this message translates to:
  /// **'Support contact is not set up yet.'**
  String get helpContactSoon;

  /// No description provided for @resetTitle.
  ///
  /// In en, this message translates to:
  /// **'Set a new password'**
  String get resetTitle;

  /// No description provided for @resetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose one you have not used on {brand} before.'**
  String resetSubtitle(String brand);

  /// No description provided for @resetNewPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get resetNewPasswordLabel;

  /// No description provided for @resetSave.
  ///
  /// In en, this message translates to:
  /// **'Save password'**
  String get resetSave;

  /// No description provided for @linkExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'This link has expired'**
  String get linkExpiredTitle;

  /// No description provided for @linkExpiredBody.
  ///
  /// In en, this message translates to:
  /// **'Reset links work once and last 30 minutes. Send a new one to carry on.'**
  String get linkExpiredBody;

  /// No description provided for @linkSendNew.
  ///
  /// In en, this message translates to:
  /// **'Send a new link'**
  String get linkSendNew;

  /// No description provided for @phoneTitle.
  ///
  /// In en, this message translates to:
  /// **'One more step'**
  String get phoneTitle;

  /// No description provided for @phoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a phone number for your account and your rider.'**
  String get phoneSubtitle;

  /// No description provided for @doneTitle.
  ///
  /// In en, this message translates to:
  /// **'You’re in'**
  String get doneTitle;

  /// No description provided for @doneBody.
  ///
  /// In en, this message translates to:
  /// **'Your account is ready. Set up your plan now, or look around first.'**
  String get doneBody;

  /// No description provided for @doneSetup.
  ///
  /// In en, this message translates to:
  /// **'Set up my plan'**
  String get doneSetup;

  /// No description provided for @doneNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get doneNotNow;

  /// No description provided for @errorOffline.
  ///
  /// In en, this message translates to:
  /// **'We couldn’t connect. Check your connection and try again.'**
  String get errorOffline;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'That took too long. Try again.'**
  String get errorTimeout;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong on our side. Try again.'**
  String get errorServer;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get errorUnknown;

  /// No description provided for @errorUnsupportedStep.
  ///
  /// In en, this message translates to:
  /// **'This sign-in needs a step this version of the app can’t do yet.'**
  String get errorUnsupportedStep;

  /// No description provided for @errorTermsStale.
  ///
  /// In en, this message translates to:
  /// **'The terms have changed. Refresh them and agree to continue.'**
  String get errorTermsStale;

  /// No description provided for @errorPhoneAlreadySet.
  ///
  /// In en, this message translates to:
  /// **'This account already has a phone number. You can change it in settings.'**
  String get errorPhoneAlreadySet;

  /// No description provided for @errorEmailAlreadyVerified.
  ///
  /// In en, this message translates to:
  /// **'Your email is already confirmed. Sign in again to carry on.'**
  String get errorEmailAlreadyVerified;

  /// No description provided for @errorEmailChangeNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Ask for a code to your new email first.'**
  String get errorEmailChangeNotStarted;

  /// No description provided for @homeGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name}'**
  String homeGreetingMorning(String name);

  /// No description provided for @homeGreetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon, {name}'**
  String homeGreetingAfternoon(String name);

  /// No description provided for @homeGreetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening, {name}'**
  String homeGreetingEvening(String name);

  /// No description provided for @homeEncouragement.
  ///
  /// In en, this message translates to:
  /// **'You’re making great progress!'**
  String get homeEncouragement;

  /// No description provided for @homeNotificationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get homeNotificationsLabel;

  /// No description provided for @homeWeekProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'This week’s progress'**
  String get homeWeekProgressTitle;

  /// No description provided for @homeBudgetUsed.
  ///
  /// In en, this message translates to:
  /// **'Budget used'**
  String get homeBudgetUsed;

  /// No description provided for @homeBudgetPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String homeBudgetPercent(int percent);

  /// No description provided for @homeMealsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Meals completed'**
  String get homeMealsCompleted;

  /// No description provided for @homeMealsCount.
  ///
  /// In en, this message translates to:
  /// **'{done} / {total}'**
  String homeMealsCount(int done, int total);

  /// No description provided for @homeMealIdeasTitle.
  ///
  /// In en, this message translates to:
  /// **'Today’s meal ideas'**
  String get homeMealIdeasTitle;

  /// No description provided for @homeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get homeViewAll;

  /// No description provided for @mealTimeBreakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get mealTimeBreakfast;

  /// No description provided for @mealTimeLunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get mealTimeLunch;

  /// No description provided for @mealTimeDinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get mealTimeDinner;

  /// No description provided for @mealTimeSnack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get mealTimeSnack;

  /// No description provided for @homeMealSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{mealTime} · meal idea'**
  String homeMealSubtitle(String mealTime);

  /// No description provided for @homeCooked.
  ///
  /// In en, this message translates to:
  /// **'Cooked'**
  String get homeCooked;

  /// No description provided for @homeStockListTitle.
  ///
  /// In en, this message translates to:
  /// **'Stock list'**
  String get homeStockListTitle;

  /// No description provided for @homeStockListSummary.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item still to buy} other{{count} items still to buy}} · {amount}'**
  String homeStockListSummary(int count, String amount);

  /// No description provided for @homeQuickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get homeQuickActionsTitle;

  /// No description provided for @homeActionViewPlan.
  ///
  /// In en, this message translates to:
  /// **'View plan'**
  String get homeActionViewPlan;

  /// No description provided for @homeActionBulkCooked.
  ///
  /// In en, this message translates to:
  /// **'Bulk cooked food'**
  String get homeActionBulkCooked;

  /// No description provided for @homeActionSharingSlot.
  ///
  /// In en, this message translates to:
  /// **'Book a sharing slot'**
  String get homeActionSharingSlot;

  /// No description provided for @homeActionAdjustBudget.
  ///
  /// In en, this message translates to:
  /// **'Adjust budget'**
  String get homeActionAdjustBudget;

  /// No description provided for @homeLoadFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Home did not load'**
  String get homeLoadFailedTitle;

  /// No description provided for @homeLoadFailedBody.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again.'**
  String get homeLoadFailedBody;

  /// No description provided for @homeRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get homeRetry;

  /// No description provided for @loadingLabel.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loadingLabel;

  /// No description provided for @homeLoadingLabel.
  ///
  /// In en, this message translates to:
  /// **'Loading your home'**
  String get homeLoadingLabel;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get commonRetry;

  /// No description provided for @pagedLoadFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'This did not load'**
  String get pagedLoadFailedTitle;

  /// No description provided for @pagedLoadFailedBody.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again.'**
  String get pagedLoadFailedBody;

  /// No description provided for @pagedLoadMoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load more.'**
  String get pagedLoadMoreFailed;

  /// No description provided for @authBusyChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking…'**
  String get authBusyChecking;

  /// No description provided for @authBusySigningIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in…'**
  String get authBusySigningIn;

  /// No description provided for @authBusyCreating.
  ///
  /// In en, this message translates to:
  /// **'Creating your account…'**
  String get authBusyCreating;

  /// No description provided for @authBusyVerifying.
  ///
  /// In en, this message translates to:
  /// **'Verifying…'**
  String get authBusyVerifying;

  /// No description provided for @authBusySaving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get authBusySaving;

  /// No description provided for @authBusySending.
  ///
  /// In en, this message translates to:
  /// **'Sending…'**
  String get authBusySending;

  /// No description provided for @authLoadingLink.
  ///
  /// In en, this message translates to:
  /// **'Checking your link'**
  String get authLoadingLink;

  /// No description provided for @startingUp.
  ///
  /// In en, this message translates to:
  /// **'Starting up'**
  String get startingUp;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
