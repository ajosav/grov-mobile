// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_on_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignOnState {

 String get email; AccountLookup? get lookup; bool get busy;/// A sign-in succeeded and the app is moving on: the full-screen transition.
 bool get signingIn; String? get termsVersion; bool get termsLoading; bool get termsAccepted; Set<PasswordProblem> get passwordProblems;/// True once the server has confirmed the checklist (not just local rules).
 bool get passwordServerChecked; AuthError? get error; String? get serverErrorMessage; DateTime? get retryAt;/// The code sent by sign-up, so the code screen can start its countdown.
 OtpChallenge? get challenge; SignOnEffect? get effect;
/// Create a copy of SignOnState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignOnStateCopyWith<SignOnState> get copyWith => _$SignOnStateCopyWithImpl<SignOnState>(this as SignOnState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SignOnState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignOnState&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.lookup, _this.lookup) || other.lookup == _this.lookup)&&(identical(other.busy, _this.busy) || other.busy == _this.busy)&&(identical(other.signingIn, _this.signingIn) || other.signingIn == _this.signingIn)&&(identical(other.termsVersion, _this.termsVersion) || other.termsVersion == _this.termsVersion)&&(identical(other.termsLoading, _this.termsLoading) || other.termsLoading == _this.termsLoading)&&(identical(other.termsAccepted, _this.termsAccepted) || other.termsAccepted == _this.termsAccepted)&&const DeepCollectionEquality().equals(other.passwordProblems, _this.passwordProblems)&&(identical(other.passwordServerChecked, _this.passwordServerChecked) || other.passwordServerChecked == _this.passwordServerChecked)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.serverErrorMessage, _this.serverErrorMessage) || other.serverErrorMessage == _this.serverErrorMessage)&&(identical(other.retryAt, _this.retryAt) || other.retryAt == _this.retryAt)&&(identical(other.challenge, _this.challenge) || other.challenge == _this.challenge)&&(identical(other.effect, _this.effect) || other.effect == _this.effect));
}


@override
int get hashCode {
  final _this = this as SignOnState;
  return Object.hash(runtimeType,_this.email,_this.lookup,_this.busy,_this.signingIn,_this.termsVersion,_this.termsLoading,_this.termsAccepted,const DeepCollectionEquality().hash(_this.passwordProblems),_this.passwordServerChecked,_this.error,_this.serverErrorMessage,_this.retryAt,_this.challenge,_this.effect);
}

@override
String toString() {
  final _this = this as SignOnState;
  return 'SignOnState(email: ${_this.email}, lookup: ${_this.lookup}, busy: ${_this.busy}, signingIn: ${_this.signingIn}, termsVersion: ${_this.termsVersion}, termsLoading: ${_this.termsLoading}, termsAccepted: ${_this.termsAccepted}, passwordProblems: ${_this.passwordProblems}, passwordServerChecked: ${_this.passwordServerChecked}, error: ${_this.error}, serverErrorMessage: ${_this.serverErrorMessage}, retryAt: ${_this.retryAt}, challenge: ${_this.challenge}, effect: ${_this.effect})';
}


}

/// @nodoc
abstract mixin class $SignOnStateCopyWith<$Res>  {
  factory $SignOnStateCopyWith(SignOnState value, $Res Function(SignOnState) _then) = _$SignOnStateCopyWithImpl;
@useResult
$Res call({
 String email, AccountLookup? lookup, bool busy, bool signingIn, String? termsVersion, bool termsLoading, bool termsAccepted, Set<PasswordProblem> passwordProblems, bool passwordServerChecked, AuthError? error, String? serverErrorMessage, DateTime? retryAt, OtpChallenge? challenge, SignOnEffect? effect
});


$AccountLookupCopyWith<$Res>? get lookup;$OtpChallengeCopyWith<$Res>? get challenge;$SignOnEffectCopyWith<$Res>? get effect;

}
/// @nodoc
class _$SignOnStateCopyWithImpl<$Res>
    implements $SignOnStateCopyWith<$Res> {
  _$SignOnStateCopyWithImpl(this._self, this._then);

  final SignOnState _self;
  final $Res Function(SignOnState) _then;

/// Create a copy of SignOnState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? lookup = freezed,Object? busy = null,Object? signingIn = null,Object? termsVersion = freezed,Object? termsLoading = null,Object? termsAccepted = null,Object? passwordProblems = null,Object? passwordServerChecked = null,Object? error = freezed,Object? serverErrorMessage = freezed,Object? retryAt = freezed,Object? challenge = freezed,Object? effect = freezed,}) {
  return _then(SignOnState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,lookup: freezed == lookup ? _self.lookup : lookup // ignore: cast_nullable_to_non_nullable
as AccountLookup?,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,signingIn: null == signingIn ? _self.signingIn : signingIn // ignore: cast_nullable_to_non_nullable
as bool,termsVersion: freezed == termsVersion ? _self.termsVersion : termsVersion // ignore: cast_nullable_to_non_nullable
as String?,termsLoading: null == termsLoading ? _self.termsLoading : termsLoading // ignore: cast_nullable_to_non_nullable
as bool,termsAccepted: null == termsAccepted ? _self.termsAccepted : termsAccepted // ignore: cast_nullable_to_non_nullable
as bool,passwordProblems: null == passwordProblems ? _self.passwordProblems : passwordProblems // ignore: cast_nullable_to_non_nullable
as Set<PasswordProblem>,passwordServerChecked: null == passwordServerChecked ? _self.passwordServerChecked : passwordServerChecked // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AuthError?,serverErrorMessage: freezed == serverErrorMessage ? _self.serverErrorMessage : serverErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,retryAt: freezed == retryAt ? _self.retryAt : retryAt // ignore: cast_nullable_to_non_nullable
as DateTime?,challenge: freezed == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as OtpChallenge?,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as SignOnEffect?,
  ));
}
/// Create a copy of SignOnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountLookupCopyWith<$Res>? get lookup {
    if (_self.lookup == null) {
    return null;
  }

  return $AccountLookupCopyWith<$Res>(_self.lookup!, (value) {
    return _then(_self.copyWith(lookup: value));
  });
}/// Create a copy of SignOnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OtpChallengeCopyWith<$Res>? get challenge {
    if (_self.challenge == null) {
    return null;
  }

  return $OtpChallengeCopyWith<$Res>(_self.challenge!, (value) {
    return _then(_self.copyWith(challenge: value));
  });
}/// Create a copy of SignOnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignOnEffectCopyWith<$Res>? get effect {
    if (_self.effect == null) {
    return null;
  }

  return $SignOnEffectCopyWith<$Res>(_self.effect!, (value) {
    return _then(_self.copyWith(effect: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignOnState].
extension SignOnStatePatterns on SignOnState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignOnState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignOnState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignOnState value)  $default,){
final _that = this;
switch (_that) {
case _SignOnState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignOnState value)?  $default,){
final _that = this;
switch (_that) {
case _SignOnState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  AccountLookup? lookup,  bool busy,  bool signingIn,  String? termsVersion,  bool termsLoading,  bool termsAccepted,  Set<PasswordProblem> passwordProblems,  bool passwordServerChecked,  AuthError? error,  String? serverErrorMessage,  DateTime? retryAt,  OtpChallenge? challenge,  SignOnEffect? effect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignOnState() when $default != null:
return $default(_that.email,_that.lookup,_that.busy,_that.signingIn,_that.termsVersion,_that.termsLoading,_that.termsAccepted,_that.passwordProblems,_that.passwordServerChecked,_that.error,_that.serverErrorMessage,_that.retryAt,_that.challenge,_that.effect);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  AccountLookup? lookup,  bool busy,  bool signingIn,  String? termsVersion,  bool termsLoading,  bool termsAccepted,  Set<PasswordProblem> passwordProblems,  bool passwordServerChecked,  AuthError? error,  String? serverErrorMessage,  DateTime? retryAt,  OtpChallenge? challenge,  SignOnEffect? effect)  $default,) {final _that = this;
switch (_that) {
case _SignOnState():
return $default(_that.email,_that.lookup,_that.busy,_that.signingIn,_that.termsVersion,_that.termsLoading,_that.termsAccepted,_that.passwordProblems,_that.passwordServerChecked,_that.error,_that.serverErrorMessage,_that.retryAt,_that.challenge,_that.effect);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  AccountLookup? lookup,  bool busy,  bool signingIn,  String? termsVersion,  bool termsLoading,  bool termsAccepted,  Set<PasswordProblem> passwordProblems,  bool passwordServerChecked,  AuthError? error,  String? serverErrorMessage,  DateTime? retryAt,  OtpChallenge? challenge,  SignOnEffect? effect)?  $default,) {final _that = this;
switch (_that) {
case _SignOnState() when $default != null:
return $default(_that.email,_that.lookup,_that.busy,_that.signingIn,_that.termsVersion,_that.termsLoading,_that.termsAccepted,_that.passwordProblems,_that.passwordServerChecked,_that.error,_that.serverErrorMessage,_that.retryAt,_that.challenge,_that.effect);case _:
  return null;

}
}

}

/// @nodoc


class _SignOnState implements SignOnState {
  const _SignOnState({this.email = '', this.lookup, this.busy = false, this.signingIn = false, this.termsVersion, this.termsLoading = false, this.termsAccepted = false,  Set<PasswordProblem> passwordProblems = const <PasswordProblem>{}, this.passwordServerChecked = false, this.error, this.serverErrorMessage, this.retryAt, this.challenge, this.effect}): _passwordProblems = passwordProblems;
  

@override@JsonKey() final  String email;
@override final  AccountLookup? lookup;
@override@JsonKey() final  bool busy;
/// A sign-in succeeded and the app is moving on: the full-screen transition.
@override@JsonKey() final  bool signingIn;
@override final  String? termsVersion;
@override@JsonKey() final  bool termsLoading;
@override@JsonKey() final  bool termsAccepted;
 final  Set<PasswordProblem> _passwordProblems;
@override@JsonKey() Set<PasswordProblem> get passwordProblems {
  if (_passwordProblems is EqualUnmodifiableSetView) return _passwordProblems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_passwordProblems);
}

/// True once the server has confirmed the checklist (not just local rules).
@override@JsonKey() final  bool passwordServerChecked;
@override final  AuthError? error;
@override final  String? serverErrorMessage;
@override final  DateTime? retryAt;
/// The code sent by sign-up, so the code screen can start its countdown.
@override final  OtpChallenge? challenge;
@override final  SignOnEffect? effect;

/// Create a copy of SignOnState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignOnStateCopyWith<_SignOnState> get copyWith => __$SignOnStateCopyWithImpl<_SignOnState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignOnState&&(identical(other.email, email) || other.email == email)&&(identical(other.lookup, lookup) || other.lookup == lookup)&&(identical(other.busy, busy) || other.busy == busy)&&(identical(other.signingIn, signingIn) || other.signingIn == signingIn)&&(identical(other.termsVersion, termsVersion) || other.termsVersion == termsVersion)&&(identical(other.termsLoading, termsLoading) || other.termsLoading == termsLoading)&&(identical(other.termsAccepted, termsAccepted) || other.termsAccepted == termsAccepted)&&const DeepCollectionEquality().equals(other.passwordProblems, _passwordProblems)&&(identical(other.passwordServerChecked, passwordServerChecked) || other.passwordServerChecked == passwordServerChecked)&&(identical(other.error, error) || other.error == error)&&(identical(other.serverErrorMessage, serverErrorMessage) || other.serverErrorMessage == serverErrorMessage)&&(identical(other.retryAt, retryAt) || other.retryAt == retryAt)&&(identical(other.challenge, challenge) || other.challenge == challenge)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email,lookup,busy,signingIn,termsVersion,termsLoading,termsAccepted,const DeepCollectionEquality().hash(_passwordProblems),passwordServerChecked,error,serverErrorMessage,retryAt,challenge,effect);
}

@override
String toString() {
    return 'SignOnState(email: $email, lookup: $lookup, busy: $busy, signingIn: $signingIn, termsVersion: $termsVersion, termsLoading: $termsLoading, termsAccepted: $termsAccepted, passwordProblems: $passwordProblems, passwordServerChecked: $passwordServerChecked, error: $error, serverErrorMessage: $serverErrorMessage, retryAt: $retryAt, challenge: $challenge, effect: $effect)';
}


}

/// @nodoc
abstract mixin class _$SignOnStateCopyWith<$Res> implements $SignOnStateCopyWith<$Res> {
  factory _$SignOnStateCopyWith(_SignOnState value, $Res Function(_SignOnState) _then) = __$SignOnStateCopyWithImpl;
@override @useResult
$Res call({
 String email, AccountLookup? lookup, bool busy, bool signingIn, String? termsVersion, bool termsLoading, bool termsAccepted, Set<PasswordProblem> passwordProblems, bool passwordServerChecked, AuthError? error, String? serverErrorMessage, DateTime? retryAt, OtpChallenge? challenge, SignOnEffect? effect
});


@override $AccountLookupCopyWith<$Res>? get lookup;@override $OtpChallengeCopyWith<$Res>? get challenge;@override $SignOnEffectCopyWith<$Res>? get effect;

}
/// @nodoc
class __$SignOnStateCopyWithImpl<$Res>
    implements _$SignOnStateCopyWith<$Res> {
  __$SignOnStateCopyWithImpl(this._self, this._then);

  final _SignOnState _self;
  final $Res Function(_SignOnState) _then;

/// Create a copy of SignOnState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? lookup = freezed,Object? busy = null,Object? signingIn = null,Object? termsVersion = freezed,Object? termsLoading = null,Object? termsAccepted = null,Object? passwordProblems = null,Object? passwordServerChecked = null,Object? error = freezed,Object? serverErrorMessage = freezed,Object? retryAt = freezed,Object? challenge = freezed,Object? effect = freezed,}) {
  return _then(_SignOnState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,lookup: freezed == lookup ? _self.lookup : lookup // ignore: cast_nullable_to_non_nullable
as AccountLookup?,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,signingIn: null == signingIn ? _self.signingIn : signingIn // ignore: cast_nullable_to_non_nullable
as bool,termsVersion: freezed == termsVersion ? _self.termsVersion : termsVersion // ignore: cast_nullable_to_non_nullable
as String?,termsLoading: null == termsLoading ? _self.termsLoading : termsLoading // ignore: cast_nullable_to_non_nullable
as bool,termsAccepted: null == termsAccepted ? _self.termsAccepted : termsAccepted // ignore: cast_nullable_to_non_nullable
as bool,passwordProblems: null == passwordProblems ? _self._passwordProblems : passwordProblems // ignore: cast_nullable_to_non_nullable
as Set<PasswordProblem>,passwordServerChecked: null == passwordServerChecked ? _self.passwordServerChecked : passwordServerChecked // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AuthError?,serverErrorMessage: freezed == serverErrorMessage ? _self.serverErrorMessage : serverErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,retryAt: freezed == retryAt ? _self.retryAt : retryAt // ignore: cast_nullable_to_non_nullable
as DateTime?,challenge: freezed == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as OtpChallenge?,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as SignOnEffect?,
  ));
}

/// Create a copy of SignOnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountLookupCopyWith<$Res>? get lookup {
    if (_self.lookup == null) {
    return null;
  }

  return $AccountLookupCopyWith<$Res>(_self.lookup!, (value) {
    return _then(_self.copyWith(lookup: value));
  });
}/// Create a copy of SignOnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OtpChallengeCopyWith<$Res>? get challenge {
    if (_self.challenge == null) {
    return null;
  }

  return $OtpChallengeCopyWith<$Res>(_self.challenge!, (value) {
    return _then(_self.copyWith(challenge: value));
  });
}/// Create a copy of SignOnState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignOnEffectCopyWith<$Res>? get effect {
    if (_self.effect == null) {
    return null;
  }

  return $SignOnEffectCopyWith<$Res>(_self.effect!, (value) {
    return _then(_self.copyWith(effect: value));
  });
}
}

// dart format on
