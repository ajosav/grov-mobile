// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_outcome.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthOutcome {

 Session? get session; OtpChallenge? get challenge; String? get firstName;
/// Create a copy of AuthOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthOutcomeCopyWith<AuthOutcome> get copyWith => _$AuthOutcomeCopyWithImpl<AuthOutcome>(this as AuthOutcome, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AuthOutcome;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthOutcome&&(identical(other.session, _this.session) || other.session == _this.session)&&(identical(other.challenge, _this.challenge) || other.challenge == _this.challenge)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName));
}


@override
int get hashCode {
  final _this = this as AuthOutcome;
  return Object.hash(runtimeType,_this.session,_this.challenge,_this.firstName);
}

@override
String toString() {
  final _this = this as AuthOutcome;
  return 'AuthOutcome(session: ${_this.session}, challenge: ${_this.challenge}, firstName: ${_this.firstName})';
}


}

/// @nodoc
abstract mixin class $AuthOutcomeCopyWith<$Res>  {
  factory $AuthOutcomeCopyWith(AuthOutcome value, $Res Function(AuthOutcome) _then) = _$AuthOutcomeCopyWithImpl;
@useResult
$Res call({
 Session? session, OtpChallenge? challenge, String? firstName
});


$SessionCopyWith<$Res>? get session;$OtpChallengeCopyWith<$Res>? get challenge;

}
/// @nodoc
class _$AuthOutcomeCopyWithImpl<$Res>
    implements $AuthOutcomeCopyWith<$Res> {
  _$AuthOutcomeCopyWithImpl(this._self, this._then);

  final AuthOutcome _self;
  final $Res Function(AuthOutcome) _then;

/// Create a copy of AuthOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = freezed,Object? challenge = freezed,Object? firstName = freezed,}) {
  return _then(AuthOutcome(
session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session?,challenge: freezed == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as OtpChallenge?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AuthOutcome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $SessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of AuthOutcome
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
}
}


/// Adds pattern-matching-related methods to [AuthOutcome].
extension AuthOutcomePatterns on AuthOutcome {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthOutcome value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthOutcome() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthOutcome value)  $default,){
final _that = this;
switch (_that) {
case _AuthOutcome():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthOutcome value)?  $default,){
final _that = this;
switch (_that) {
case _AuthOutcome() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Session? session,  OtpChallenge? challenge,  String? firstName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthOutcome() when $default != null:
return $default(_that.session,_that.challenge,_that.firstName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Session? session,  OtpChallenge? challenge,  String? firstName)  $default,) {final _that = this;
switch (_that) {
case _AuthOutcome():
return $default(_that.session,_that.challenge,_that.firstName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Session? session,  OtpChallenge? challenge,  String? firstName)?  $default,) {final _that = this;
switch (_that) {
case _AuthOutcome() when $default != null:
return $default(_that.session,_that.challenge,_that.firstName);case _:
  return null;

}
}

}

/// @nodoc


class _AuthOutcome implements AuthOutcome {
  const _AuthOutcome({this.session, this.challenge, this.firstName});
  

@override final  Session? session;
@override final  OtpChallenge? challenge;
@override final  String? firstName;

/// Create a copy of AuthOutcome
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthOutcomeCopyWith<_AuthOutcome> get copyWith => __$AuthOutcomeCopyWithImpl<_AuthOutcome>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthOutcome&&(identical(other.session, session) || other.session == session)&&(identical(other.challenge, challenge) || other.challenge == challenge)&&(identical(other.firstName, firstName) || other.firstName == firstName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,session,challenge,firstName);
}

@override
String toString() {
    return 'AuthOutcome(session: $session, challenge: $challenge, firstName: $firstName)';
}


}

/// @nodoc
abstract mixin class _$AuthOutcomeCopyWith<$Res> implements $AuthOutcomeCopyWith<$Res> {
  factory _$AuthOutcomeCopyWith(_AuthOutcome value, $Res Function(_AuthOutcome) _then) = __$AuthOutcomeCopyWithImpl;
@override @useResult
$Res call({
 Session? session, OtpChallenge? challenge, String? firstName
});


@override $SessionCopyWith<$Res>? get session;@override $OtpChallengeCopyWith<$Res>? get challenge;

}
/// @nodoc
class __$AuthOutcomeCopyWithImpl<$Res>
    implements _$AuthOutcomeCopyWith<$Res> {
  __$AuthOutcomeCopyWithImpl(this._self, this._then);

  final _AuthOutcome _self;
  final $Res Function(_AuthOutcome) _then;

/// Create a copy of AuthOutcome
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = freezed,Object? challenge = freezed,Object? firstName = freezed,}) {
  return _then(_AuthOutcome(
session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session?,challenge: freezed == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as OtpChallenge?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AuthOutcome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $SessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of AuthOutcome
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
}
}

// dart format on
