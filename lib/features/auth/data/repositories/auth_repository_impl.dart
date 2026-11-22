import '../../../../core/error/result.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/auth_outcome.dart';
import '../../domain/entities/code_verification.dart';
import '../../domain/entities/new_profile.dart';
import '../../domain/entities/otp_challenge.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class const AuthRepositoryImpl(final AuthRemoteDataSource _remote)
    implements AuthRepository {
  @override
  Future<Result<String>> getTermsVersion() =>
      _map(() => _remote.getConfig(), (config) => config.termsVersion);

  @override
  Future<Result<OtpChallenge>> requestCode(String email) =>
      _map(() => _remote.requestCode(email), (m) => m.toEntity());

  @override
  Future<Result<CodeVerification>> verifyCode(String email, String code) =>
      _map(() => _remote.verifyCode(email, code), (m) => m.toEntity());

  @override
  Future<Result<AuthOutcome>> completeProfile(NewProfile profile) =>
      _map(() => _remote.completeProfile(profile), (m) => m.toEntity());

  @override
  Future<Result<AuthOutcome>> completePhone(String phone) =>
      _map(() => _remote.completePhone(phone), (m) => m.toEntity());

  Future<Result<T>> _map<M, T>(
    Future<M> Function() call,
    T Function(M model) toEntity,
  ) async => switch (await guardApi(call)) {
    Ok(:final value) => Result.ok(toEntity(value)),
    Err(:final failure) => Result.err(failure),
  };
}
