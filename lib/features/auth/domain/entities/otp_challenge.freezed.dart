// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_challenge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtpChallenge {

 DateTime get expiresAt; DateTime get nextSendAt;
/// Create a copy of OtpChallenge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpChallengeCopyWith<OtpChallenge> get copyWith => _$OtpChallengeCopyWithImpl<OtpChallenge>(this as OtpChallenge, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OtpChallenge;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpChallenge&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.nextSendAt, _this.nextSendAt) || other.nextSendAt == _this.nextSendAt));
}


@override
int get hashCode {
  final _this = this as OtpChallenge;
  return Object.hash(runtimeType,_this.expiresAt,_this.nextSendAt);
}

@override
String toString() {
  final _this = this as OtpChallenge;
  return 'OtpChallenge(expiresAt: ${_this.expiresAt}, nextSendAt: ${_this.nextSendAt})';
}


}

/// @nodoc
abstract mixin class $OtpChallengeCopyWith<$Res>  {
  factory $OtpChallengeCopyWith(OtpChallenge value, $Res Function(OtpChallenge) _then) = _$OtpChallengeCopyWithImpl;
@useResult
$Res call({
 DateTime expiresAt, DateTime nextSendAt
});




}
/// @nodoc
class _$OtpChallengeCopyWithImpl<$Res>
    implements $OtpChallengeCopyWith<$Res> {
  _$OtpChallengeCopyWithImpl(this._self, this._then);

  final OtpChallenge _self;
  final $Res Function(OtpChallenge) _then;

/// Create a copy of OtpChallenge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expiresAt = null,Object? nextSendAt = null,}) {
  return _then(OtpChallenge(
expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,nextSendAt: null == nextSendAt ? _self.nextSendAt : nextSendAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpChallenge].
extension OtpChallengePatterns on OtpChallenge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpChallenge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpChallenge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpChallenge value)  $default,){
final _that = this;
switch (_that) {
case _OtpChallenge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpChallenge value)?  $default,){
final _that = this;
switch (_that) {
case _OtpChallenge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime expiresAt,  DateTime nextSendAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpChallenge() when $default != null:
return $default(_that.expiresAt,_that.nextSendAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime expiresAt,  DateTime nextSendAt)  $default,) {final _that = this;
switch (_that) {
case _OtpChallenge():
return $default(_that.expiresAt,_that.nextSendAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime expiresAt,  DateTime nextSendAt)?  $default,) {final _that = this;
switch (_that) {
case _OtpChallenge() when $default != null:
return $default(_that.expiresAt,_that.nextSendAt);case _:
  return null;

}
}

}

/// @nodoc


class _OtpChallenge implements OtpChallenge {
  const _OtpChallenge({required this.expiresAt, required this.nextSendAt});
  

@override final  DateTime expiresAt;
@override final  DateTime nextSendAt;

/// Create a copy of OtpChallenge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpChallengeCopyWith<_OtpChallenge> get copyWith => __$OtpChallengeCopyWithImpl<_OtpChallenge>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpChallenge&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.nextSendAt, nextSendAt) || other.nextSendAt == nextSendAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,expiresAt,nextSendAt);
}

@override
String toString() {
    return 'OtpChallenge(expiresAt: $expiresAt, nextSendAt: $nextSendAt)';
}


}

/// @nodoc
abstract mixin class _$OtpChallengeCopyWith<$Res> implements $OtpChallengeCopyWith<$Res> {
  factory _$OtpChallengeCopyWith(_OtpChallenge value, $Res Function(_OtpChallenge) _then) = __$OtpChallengeCopyWithImpl;
@override @useResult
$Res call({
 DateTime expiresAt, DateTime nextSendAt
});




}
/// @nodoc
class __$OtpChallengeCopyWithImpl<$Res>
    implements _$OtpChallengeCopyWith<$Res> {
  __$OtpChallengeCopyWithImpl(this._self, this._then);

  final _OtpChallenge _self;
  final $Res Function(_OtpChallenge) _then;

/// Create a copy of OtpChallenge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expiresAt = null,Object? nextSendAt = null,}) {
  return _then(_OtpChallenge(
expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,nextSendAt: null == nextSendAt ? _self.nextSendAt : nextSendAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
