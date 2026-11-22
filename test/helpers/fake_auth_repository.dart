import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/features/auth/domain/entities/auth_outcome.dart';
import 'package:app_mobile/features/auth/domain/entities/code_verification.dart';
import 'package:app_mobile/features/auth/domain/entities/new_profile.dart';
import 'package:app_mobile/features/auth/domain/entities/otp_challenge.dart';
import 'package:app_mobile/features/auth/domain/entities/registration_ticket.dart';
import 'package:app_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_mobile/features/session/domain/entities/auth_gate.dart';
import 'package:app_mobile/features/session/domain/entities/session.dart';

/// A scriptable [AuthRepository]. Set the field for the call under test; an
/// unset call answers with an unknown failure so a forgotten stub is loud.
class FakeAuthRepository() implements AuthRepository {
  Result<String> termsVersionResult = const Result.ok('terms-test');
  Result<OtpChallenge> requestCodeResult = const Result.err(UnknownFailure());
  Result<CodeVerification> verifyResult = const Result.err(UnknownFailure());
  Result<AuthOutcome> completeProfileResult = const Result.err(
    UnknownFailure(),
  );
  NewProfile? lastProfile;
  Result<AuthOutcome> phoneResult = const Result.err(UnknownFailure());

  final calls = <String>[];

  @override
  Future<Result<String>> getTermsVersion() async {
    calls.add('getTermsVersion');
    return termsVersionResult;
  }

  @override
  Future<Result<OtpChallenge>> requestCode(String email) async {
    calls.add('requestCode:$email');
    return requestCodeResult;
  }

  @override
  Future<Result<CodeVerification>> verifyCode(
    String email,
    String code,
  ) async {
    calls.add('verifyCode:$email:$code');
    return verifyResult;
  }

  @override
  Future<Result<AuthOutcome>> completeProfile(NewProfile profile) async {
    calls.add('completeProfile:${profile.phone}');
    lastProfile = profile;
    return completeProfileResult;
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

/// A right code for an existing account.
CodeVerification signedInWith(AuthGate gate) =>
    CodeVerification.signedIn(outcomeWith(gate));

/// A right code for a new address.
CodeVerification profileRequired() => CodeVerification.profileRequired(
  RegistrationTicket(
    ticket: 'ticket-of-a-new-address',
    expiresAt: DateTime.utc(2030),
  ),
);

OtpChallenge challengeAt(DateTime next) => OtpChallenge(
  expiresAt: next.add(const Duration(minutes: 9)),
  nextSendAt: next,
);
