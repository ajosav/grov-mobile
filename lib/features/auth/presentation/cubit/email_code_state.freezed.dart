// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_code_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmailCodeState {

 String get email; String get code; EmailCodeStatus get status; AuthError? get error; DateTime? get nextSendAt; bool get resending;/// Set when the code was accepted for an existing account; the page passes
/// it to the session.
 Session? get verifiedSession;/// Set when the code was accepted for a new address; the page opens the
/// profile screen with it.
 RegistrationTicket? get profileTicket;
/// Create a copy of EmailCodeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailCodeStateCopyWith<EmailCodeState> get copyWith => _$EmailCodeStateCopyWithImpl<EmailCodeState>(this as EmailCodeState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EmailCodeState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailCodeState&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.nextSendAt, _this.nextSendAt) || other.nextSendAt == _this.nextSendAt)&&(identical(other.resending, _this.resending) || other.resending == _this.resending)&&(identical(other.verifiedSession, _this.verifiedSession) || other.verifiedSession == _this.verifiedSession)&&(identical(other.profileTicket, _this.profileTicket) || other.profileTicket == _this.profileTicket));
}


@override
int get hashCode {
  final _this = this as EmailCodeState;
  return Object.hash(runtimeType,_this.email,_this.code,_this.status,_this.error,_this.nextSendAt,_this.resending,_this.verifiedSession,_this.profileTicket);
}

@override
String toString() {
  final _this = this as EmailCodeState;
  return 'EmailCodeState(email: ${_this.email}, code: ${_this.code}, status: ${_this.status}, error: ${_this.error}, nextSendAt: ${_this.nextSendAt}, resending: ${_this.resending}, verifiedSession: ${_this.verifiedSession}, profileTicket: ${_this.profileTicket})';
}


}

/// @nodoc
abstract mixin class $EmailCodeStateCopyWith<$Res>  {
  factory $EmailCodeStateCopyWith(EmailCodeState value, $Res Function(EmailCodeState) _then) = _$EmailCodeStateCopyWithImpl;
@useResult
$Res call({
 String email, String code, EmailCodeStatus status, AuthError? error, DateTime? nextSendAt, bool resending, Session? verifiedSession, RegistrationTicket? profileTicket
});


$SessionCopyWith<$Res>? get verifiedSession;$RegistrationTicketCopyWith<$Res>? get profileTicket;

}
/// @nodoc
class _$EmailCodeStateCopyWithImpl<$Res>
    implements $EmailCodeStateCopyWith<$Res> {
  _$EmailCodeStateCopyWithImpl(this._self, this._then);

  final EmailCodeState _self;
  final $Res Function(EmailCodeState) _then;

/// Create a copy of EmailCodeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? code = null,Object? status = null,Object? error = freezed,Object? nextSendAt = freezed,Object? resending = null,Object? verifiedSession = freezed,Object? profileTicket = freezed,}) {
  return _then(EmailCodeState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EmailCodeStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AuthError?,nextSendAt: freezed == nextSendAt ? _self.nextSendAt : nextSendAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resending: null == resending ? _self.resending : resending // ignore: cast_nullable_to_non_nullable
as bool,verifiedSession: freezed == verifiedSession ? _self.verifiedSession : verifiedSession // ignore: cast_nullable_to_non_nullable
as Session?,profileTicket: freezed == profileTicket ? _self.profileTicket : profileTicket // ignore: cast_nullable_to_non_nullable
as RegistrationTicket?,
  ));
}
/// Create a copy of EmailCodeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res>? get verifiedSession {
    if (_self.verifiedSession == null) {
    return null;
  }

  return $SessionCopyWith<$Res>(_self.verifiedSession!, (value) {
    return _then(_self.copyWith(verifiedSession: value));
  });
}/// Create a copy of EmailCodeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistrationTicketCopyWith<$Res>? get profileTicket {
    if (_self.profileTicket == null) {
    return null;
  }

  return $RegistrationTicketCopyWith<$Res>(_self.profileTicket!, (value) {
    return _then(_self.copyWith(profileTicket: value));
  });
}
}


/// Adds pattern-matching-related methods to [EmailCodeState].
extension EmailCodeStatePatterns on EmailCodeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailCodeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailCodeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailCodeState value)  $default,){
final _that = this;
switch (_that) {
case _EmailCodeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailCodeState value)?  $default,){
final _that = this;
switch (_that) {
case _EmailCodeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String code,  EmailCodeStatus status,  AuthError? error,  DateTime? nextSendAt,  bool resending,  Session? verifiedSession,  RegistrationTicket? profileTicket)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailCodeState() when $default != null:
return $default(_that.email,_that.code,_that.status,_that.error,_that.nextSendAt,_that.resending,_that.verifiedSession,_that.profileTicket);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String code,  EmailCodeStatus status,  AuthError? error,  DateTime? nextSendAt,  bool resending,  Session? verifiedSession,  RegistrationTicket? profileTicket)  $default,) {final _that = this;
switch (_that) {
case _EmailCodeState():
return $default(_that.email,_that.code,_that.status,_that.error,_that.nextSendAt,_that.resending,_that.verifiedSession,_that.profileTicket);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String code,  EmailCodeStatus status,  AuthError? error,  DateTime? nextSendAt,  bool resending,  Session? verifiedSession,  RegistrationTicket? profileTicket)?  $default,) {final _that = this;
switch (_that) {
case _EmailCodeState() when $default != null:
return $default(_that.email,_that.code,_that.status,_that.error,_that.nextSendAt,_that.resending,_that.verifiedSession,_that.profileTicket);case _:
  return null;

}
}

}

/// @nodoc


class _EmailCodeState implements EmailCodeState {
  const _EmailCodeState({required this.email, this.code = '', this.status = EmailCodeStatus.entering, this.error, this.nextSendAt, this.resending = false, this.verifiedSession, this.profileTicket});
  

@override final  String email;
@override@JsonKey() final  String code;
@override@JsonKey() final  EmailCodeStatus status;
@override final  AuthError? error;
@override final  DateTime? nextSendAt;
@override@JsonKey() final  bool resending;
/// Set when the code was accepted for an existing account; the page passes
/// it to the session.
@override final  Session? verifiedSession;
/// Set when the code was accepted for a new address; the page opens the
/// profile screen with it.
@override final  RegistrationTicket? profileTicket;

/// Create a copy of EmailCodeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailCodeStateCopyWith<_EmailCodeState> get copyWith => __$EmailCodeStateCopyWithImpl<_EmailCodeState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailCodeState&&(identical(other.email, email) || other.email == email)&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&(identical(other.nextSendAt, nextSendAt) || other.nextSendAt == nextSendAt)&&(identical(other.resending, resending) || other.resending == resending)&&(identical(other.verifiedSession, verifiedSession) || other.verifiedSession == verifiedSession)&&(identical(other.profileTicket, profileTicket) || other.profileTicket == profileTicket));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email,code,status,error,nextSendAt,resending,verifiedSession,profileTicket);
}

@override
String toString() {
    return 'EmailCodeState(email: $email, code: $code, status: $status, error: $error, nextSendAt: $nextSendAt, resending: $resending, verifiedSession: $verifiedSession, profileTicket: $profileTicket)';
}


}

/// @nodoc
abstract mixin class _$EmailCodeStateCopyWith<$Res> implements $EmailCodeStateCopyWith<$Res> {
  factory _$EmailCodeStateCopyWith(_EmailCodeState value, $Res Function(_EmailCodeState) _then) = __$EmailCodeStateCopyWithImpl;
@override @useResult
$Res call({
 String email, String code, EmailCodeStatus status, AuthError? error, DateTime? nextSendAt, bool resending, Session? verifiedSession, RegistrationTicket? profileTicket
});


@override $SessionCopyWith<$Res>? get verifiedSession;@override $RegistrationTicketCopyWith<$Res>? get profileTicket;

}
/// @nodoc
class __$EmailCodeStateCopyWithImpl<$Res>
    implements _$EmailCodeStateCopyWith<$Res> {
  __$EmailCodeStateCopyWithImpl(this._self, this._then);

  final _EmailCodeState _self;
  final $Res Function(_EmailCodeState) _then;

/// Create a copy of EmailCodeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? code = null,Object? status = null,Object? error = freezed,Object? nextSendAt = freezed,Object? resending = null,Object? verifiedSession = freezed,Object? profileTicket = freezed,}) {
  return _then(_EmailCodeState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EmailCodeStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AuthError?,nextSendAt: freezed == nextSendAt ? _self.nextSendAt : nextSendAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resending: null == resending ? _self.resending : resending // ignore: cast_nullable_to_non_nullable
as bool,verifiedSession: freezed == verifiedSession ? _self.verifiedSession : verifiedSession // ignore: cast_nullable_to_non_nullable
as Session?,profileTicket: freezed == profileTicket ? _self.profileTicket : profileTicket // ignore: cast_nullable_to_non_nullable
as RegistrationTicket?,
  ));
}

/// Create a copy of EmailCodeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res>? get verifiedSession {
    if (_self.verifiedSession == null) {
    return null;
  }

  return $SessionCopyWith<$Res>(_self.verifiedSession!, (value) {
    return _then(_self.copyWith(verifiedSession: value));
  });
}/// Create a copy of EmailCodeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistrationTicketCopyWith<$Res>? get profileTicket {
    if (_self.profileTicket == null) {
    return null;
  }

  return $RegistrationTicketCopyWith<$Res>(_self.profileTicket!, (value) {
    return _then(_self.copyWith(profileTicket: value));
  });
}
}

// dart format on
