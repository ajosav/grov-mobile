import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/features/auth/domain/entities/account_lookup.dart';
import 'package:app_mobile/features/auth/domain/entities/auth_outcome.dart';
import 'package:app_mobile/features/auth/domain/entities/new_account.dart';
import 'package:app_mobile/features/auth/domain/entities/otp_challenge.dart';
import 'package:app_mobile/features/auth/domain/entities/password_check.dart';
import 'package:app_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_mobile/features/session/domain/entities/auth_gate.dart';
import 'package:app_mobile/features/session/domain/entities/session.dart';

/// A scriptable [AuthRepository]. Set the field for the call under test; an
/// unset call answers with an unknown failure so a forgotten stub is loud.
class FakeAuthRepository() implements AuthRepository {
  Result<AccountLookup> lookupResult = const Result.err(UnknownFailure());
  Result<PasswordCheck> checkResult = const Result.ok(PasswordCheck(ok: true));
  Result<AuthOutcome> signUpResult = const Result.err(UnknownFailure());
  Result<AuthOutcome> logInResult = const Result.err(UnknownFailure());
  Result<AuthOutcome> verifyResult = const Result.err(UnknownFailure());
  Result<OtpChallenge> resendResult = const Result.err(UnknownFailure());
  Result<OtpChallenge> changeEmailResult = const Result.err(UnknownFailure());
  Result<DateTime> forgotResult = const Result.err(UnknownFailure());
  Result<bool> resetCheckResult = const Result.ok(true);
  Result<AuthOutcome> resetResult = const Result.err(UnknownFailure());
  Result<AuthOutcome> phoneResult = const Result.err(UnknownFailure());

  final calls = <String>[];

  @override
  Future<Result<AccountLookup>> lookup(String email) async {
    calls.add('lookup:$email');
    return lookupResult;
  }

  @override
  Future<Result<PasswordCheck>> checkPassword(
    String password, {
    String? email,
  }) async {
    calls.add('checkPassword');
    return checkResult;
  }

  @override
  Future<Result<AuthOutcome>> signUp(NewAccount account) async {
    calls.add('signUp:${account.phone}');
    return signUpResult;
  }

  @override
  Future<Result<AuthOutcome>> logIn(String email, String password) async {
    calls.add('logIn:$email');
    return logInResult;
  }

  @override
  Future<Result<AuthOutcome>> verifyEmail(String code) async {
    calls.add('verifyEmail:$code');
    return verifyResult;
  }

  @override
  Future<Result<OtpChallenge>> resendEmailCode() async {
    calls.add('resend');
    return resendResult;
  }

  @override
  Future<Result<OtpChallenge>> changeEmailAddress(String newEmail) async {
    calls.add('changeEmail:$newEmail');
    return changeEmailResult;
  }

  @override
  Future<Result<DateTime>> requestPasswordReset(String email) async {
    calls.add('forgot:$email');
    return forgotResult;
  }

  @override
  Future<Result<bool>> checkResetLink(String token) async {
    calls.add('resetCheck');
    return resetCheckResult;
  }

  @override
  Future<Result<AuthOutcome>> resetPassword(
    String token,
    String password,
  ) async {
    calls.add('reset');
    return resetResult;
  }

  @override
  Future<Result<AuthOutcome>> completePhone(String phone) async {
    calls.add('phone:$phone');
    return phoneResult;
  }
}

Session sessionWith(AuthGate gate, {String email = 'ngozi@example.com'}) =>
    Session(
      accessToken: 'a',
      refreshToken: 'r',
      expiresAt: DateTime.utc(2030),
      gate: gate,
      email: email,
    );

AuthOutcome outcomeWith(AuthGate gate, {OtpChallenge? challenge}) =>
    AuthOutcome(session: sessionWith(gate), challenge: challenge);

/// An answer with no session: the server wants a step the app cannot do.
const outcomeNoSession = AuthOutcome();
