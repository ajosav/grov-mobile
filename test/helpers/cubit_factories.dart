import 'package:app_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_mobile/features/auth/domain/usecases/complete_phone.dart';
import 'package:app_mobile/features/auth/domain/usecases/complete_profile.dart';
import 'package:app_mobile/features/auth/domain/usecases/get_terms_version.dart';
import 'package:app_mobile/features/auth/domain/usecases/request_sign_in_code.dart';
import 'package:app_mobile/features/auth/domain/usecases/verify_sign_in_code.dart';
import 'package:app_mobile/features/auth/presentation/cubit/email_code_cubit.dart';
import 'package:app_mobile/features/auth/presentation/cubit/phone_cubit.dart';
import 'package:app_mobile/features/auth/presentation/cubit/sign_on_cubit.dart';
import 'package:app_mobile/core/platform/clock.dart';
import 'package:app_mobile/features/home/data/repositories/fixture_home_repository.dart';
import 'package:app_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:app_mobile/features/home/domain/usecases/watch_home.dart';
import 'package:app_mobile/features/home/presentation/cubit/home_cubit.dart';
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
  requestCode: RequestSignInCode(repo),
  completeProfile: CompleteProfile(repo),
  getTermsVersion: GetTermsVersion(repo),
);

EmailCodeCubit emailCodeCubitFor(
  AuthRepository repo, {
  String email = 'ngozi@example.com',
  DateTime? nextSendAt,
}) => EmailCodeCubit(
  verifyCode: VerifySignInCode(repo),
  requestCode: RequestSignInCode(repo),
  email: email,
  nextSendAt: nextSendAt,
);

PhoneCubit phoneCubitFor(AuthRepository repo) =>
    PhoneCubit(CompletePhone(repo));

class const FixedClock(final DateTime _now) implements Clock {
  @override
  DateTime now() => _now;
}

/// Home over the fixture repository unless a test supplies its own.
HomeCubit homeCubitFor([HomeRepository? repo, Clock? clock]) => HomeCubit(
  watchHome: WatchHome(repo ?? const FixtureHomeRepository()),
  clock: clock ?? FixedClock(DateTime(2026, 11, 21, 9)),
);
