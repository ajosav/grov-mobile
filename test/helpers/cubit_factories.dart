import 'package:app_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_mobile/features/auth/domain/usecases/change_email_address.dart';
import 'package:app_mobile/features/auth/domain/usecases/check_password.dart';
import 'package:app_mobile/features/auth/domain/usecases/check_reset_link.dart';
import 'package:app_mobile/features/auth/domain/usecases/complete_phone.dart';
import 'package:app_mobile/features/auth/domain/usecases/log_in.dart';
import 'package:app_mobile/features/auth/domain/usecases/lookup_account.dart';
import 'package:app_mobile/features/auth/domain/usecases/request_password_reset.dart';
import 'package:app_mobile/features/auth/domain/usecases/resend_email_code.dart';
import 'package:app_mobile/features/auth/domain/usecases/reset_password.dart';
import 'package:app_mobile/features/auth/domain/usecases/sign_up.dart';
import 'package:app_mobile/features/auth/domain/usecases/verify_email.dart';
import 'package:app_mobile/features/auth/presentation/cubit/email_code_cubit.dart';
import 'package:app_mobile/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:app_mobile/features/auth/presentation/cubit/phone_cubit.dart';
import 'package:app_mobile/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:app_mobile/features/auth/presentation/cubit/sign_on_cubit.dart';
import 'package:app_mobile/features/session/domain/repositories/session_repository.dart';
import 'package:app_mobile/features/session/domain/usecases/refresh_session.dart';
import 'package:app_mobile/features/session/domain/usecases/restore_session.dart';
import 'package:app_mobile/features/session/domain/usecases/save_session.dart';
import 'package:app_mobile/features/session/domain/usecases/sign_out.dart';
import 'package:app_mobile/features/session/presentation/cubit/session_cubit.dart';
import 'package:app_mobile/features/settings/domain/repositories/device_settings_repository.dart';
import 'package:app_mobile/features/settings/domain/usecases/detect_low_ram_device.dart';
import 'package:app_mobile/features/settings/domain/usecases/set_appearance.dart';
import 'package:app_mobile/features/settings/domain/usecases/set_low_end.dart';
import 'package:app_mobile/features/settings/domain/usecases/watch_device_settings.dart';
import 'package:app_mobile/features/settings/presentation/cubit/device_settings_cubit.dart';
import 'package:app_mobile/features/sync/domain/repositories/sync_repository.dart';
import 'package:app_mobile/features/sync/domain/usecases/get_is_online.dart';
import 'package:app_mobile/features/sync/domain/usecases/watch_last_synced_at.dart';
import 'package:app_mobile/features/sync/domain/usecases/watch_online.dart';
import 'package:app_mobile/features/sync/presentation/cubit/sync_status_cubit.dart';

/// Real use cases over a fake repository: tests exercise the whole
/// presentation + domain path and fake only the data boundary.
SessionCubit sessionCubitFor(SessionRepository repo) => SessionCubit(
  restoreSession: RestoreSession(repo),
  saveSession: SaveSession(repo),
  signOut: SignOut(repo),
  refreshSession: RefreshSession(repo),
);

DeviceSettingsCubit deviceSettingsCubitFor(DeviceSettingsRepository repo) =>
    DeviceSettingsCubit(
      watchDeviceSettings: WatchDeviceSettings(repo),
      setAppearance: SetAppearance(repo),
      setLowEnd: SetLowEnd(repo),
      detectLowRamDevice: DetectLowRamDevice(repo),
    );

SyncStatusCubit syncStatusCubitFor(SyncRepository repo) => SyncStatusCubit(
  getIsOnline: GetIsOnline(repo),
  watchOnline: WatchOnline(repo),
  watchLastSyncedAt: WatchLastSyncedAt(repo),
);

SignOnCubit signOnCubitFor(AuthRepository repo) => SignOnCubit(
  lookupAccount: LookupAccount(repo),
  logIn: LogIn(repo),
  signUp: SignUp(repo),
  checkPassword: CheckPassword(repo),
);

EmailCodeCubit emailCodeCubitFor(
  AuthRepository repo, {
  String email = 'ngozi@example.com',
  DateTime? nextSendAt,
}) => EmailCodeCubit(
  verifyEmail: VerifyEmail(repo),
  resendEmailCode: ResendEmailCode(repo),
  changeEmailAddress: ChangeEmailAddress(repo),
  email: email,
  nextSendAt: nextSendAt,
);

ForgotPasswordCubit forgotPasswordCubitFor(
  AuthRepository repo, {
  String email = '',
}) => ForgotPasswordCubit(RequestPasswordReset(repo), email: email);

ResetPasswordCubit resetPasswordCubitFor(
  AuthRepository repo, {
  String token = 'a-reset-token-of-at-least-20-chars',
}) => ResetPasswordCubit(
  checkResetLink: CheckResetLink(repo),
  resetPassword: ResetPassword(repo),
  checkPassword: CheckPassword(repo),
  token: token,
);

PhoneCubit phoneCubitFor(AuthRepository repo) =>
    PhoneCubit(CompletePhone(repo));
