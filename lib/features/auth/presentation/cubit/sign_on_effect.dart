import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../session/domain/entities/session.dart';

part 'sign_on_effect.freezed.dart';

@freezed
sealed class SignOnEffect with _$SignOnEffect {
  const factory SignOnEffect.toCode() = SignOnToCode;
  const factory SignOnEffect.signedIn(Session session) = SignOnSignedIn;
}
