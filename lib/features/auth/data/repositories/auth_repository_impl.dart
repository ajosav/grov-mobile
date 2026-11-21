import '../../../../core/error/result.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/account_lookup.dart';
import '../../domain/entities/auth_outcome.dart';
import '../../domain/entities/new_account.dart';
import '../../domain/entities/otp_challenge.dart';
import '../../domain/entities/password_check.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class const AuthRepositoryImpl(
  final AuthRemoteDataSource _remote,
) implements AuthRepository {

  @override
  Future<Result<AccountLookup>> lookup(String email) =>
      _map(() => _remote.lookup(email), (m) => m.toEntity());

  @override
  Future<Result<PasswordCheck>> checkPassword(
    String password, {
    String? email,
  }) => _map(() => _remote.checkPassword(password, email), (m) => m.toEntity());

  @override
  Future<Result<String>> getTermsVersion() =>
      _map(() => _remote.getConfig(), (config) => config.termsVersion);

  @override
  Future<Result<AuthOutcome>> signUp(NewAccount account) => _map(
    () => _remote.signUp(
      email: account.email,
      firstName: account.firstName,
      lastName: account.lastName,
      phone: account.phone,
      password: account.password,
      termsVersion: account.termsVersion,
    ),
    (m) => m.toEntity(),
  );

  @override
  Future<Result<AuthOutcome>> logIn(String email, String password) =>
      _map(() => _remote.logIn(email, password), (m) => m.toEntity());

  @override
  Future<Result<AuthOutcome>> verifyEmail(String code) =>
      _map(() => _remote.verifyEmail(code), (m) => m.toEntity());

  @override
  Future<Result<OtpChallenge>> resendEmailCode() =>
      _map(_remote.resendEmailCode, (m) => m.toEntity());

  @override
  Future<Result<OtpChallenge>> changeEmailAddress(String newEmail) =>
      _map(() => _remote.changeEmailAddress(newEmail), (m) => m.toEntity());

  @override
  Future<Result<DateTime>> requestPasswordReset(String email) =>
      _map(() => _remote.forgotPassword(email), (m) => m.nextSendAt);

  @override
  Future<Result<bool>> checkResetLink(String token) =>
      _map(() => _remote.checkResetLink(token), (m) => m.valid);

  @override
  Future<Result<AuthOutcome>> resetPassword(String token, String password) =>
      _map(() => _remote.resetPassword(token, password), (m) => m.toEntity());

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
