// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForgotPasswordState {

 String get email; bool get busy; AuthError? get error; DateTime? get nextSendAt; bool get sent;
/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordStateCopyWith<ForgotPasswordState> get copyWith => _$ForgotPasswordStateCopyWithImpl<ForgotPasswordState>(this as ForgotPasswordState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ForgotPasswordState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordState&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.busy, _this.busy) || other.busy == _this.busy)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.nextSendAt, _this.nextSendAt) || other.nextSendAt == _this.nextSendAt)&&(identical(other.sent, _this.sent) || other.sent == _this.sent));
}


@override
int get hashCode {
  final _this = this as ForgotPasswordState;
  return Object.hash(runtimeType,_this.email,_this.busy,_this.error,_this.nextSendAt,_this.sent);
}

@override
String toString() {
  final _this = this as ForgotPasswordState;
  return 'ForgotPasswordState(email: ${_this.email}, busy: ${_this.busy}, error: ${_this.error}, nextSendAt: ${_this.nextSendAt}, sent: ${_this.sent})';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordStateCopyWith<$Res>  {
  factory $ForgotPasswordStateCopyWith(ForgotPasswordState value, $Res Function(ForgotPasswordState) _then) = _$ForgotPasswordStateCopyWithImpl;
@useResult
$Res call({
 String email, bool busy, AuthError? error, DateTime? nextSendAt, bool sent
});




}
/// @nodoc
class _$ForgotPasswordStateCopyWithImpl<$Res>
    implements $ForgotPasswordStateCopyWith<$Res> {
  _$ForgotPasswordStateCopyWithImpl(this._self, this._then);

  final ForgotPasswordState _self;
  final $Res Function(ForgotPasswordState) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? busy = null,Object? error = freezed,Object? nextSendAt = freezed,Object? sent = null,}) {
  return _then(ForgotPasswordState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AuthError?,nextSendAt: freezed == nextSendAt ? _self.nextSendAt : nextSendAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sent: null == sent ? _self.sent : sent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ForgotPasswordState].
extension ForgotPasswordStatePatterns on ForgotPasswordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForgotPasswordState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForgotPasswordState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForgotPasswordState value)  $default,){
final _that = this;
switch (_that) {
case _ForgotPasswordState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForgotPasswordState value)?  $default,){
final _that = this;
switch (_that) {
case _ForgotPasswordState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  bool busy,  AuthError? error,  DateTime? nextSendAt,  bool sent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForgotPasswordState() when $default != null:
return $default(_that.email,_that.busy,_that.error,_that.nextSendAt,_that.sent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  bool busy,  AuthError? error,  DateTime? nextSendAt,  bool sent)  $default,) {final _that = this;
switch (_that) {
case _ForgotPasswordState():
return $default(_that.email,_that.busy,_that.error,_that.nextSendAt,_that.sent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  bool busy,  AuthError? error,  DateTime? nextSendAt,  bool sent)?  $default,) {final _that = this;
switch (_that) {
case _ForgotPasswordState() when $default != null:
return $default(_that.email,_that.busy,_that.error,_that.nextSendAt,_that.sent);case _:
  return null;

}
}

}

/// @nodoc


class _ForgotPasswordState implements ForgotPasswordState {
  const _ForgotPasswordState({this.email = '', this.busy = false, this.error, this.nextSendAt, this.sent = false});
  

@override@JsonKey() final  String email;
@override@JsonKey() final  bool busy;
@override final  AuthError? error;
@override final  DateTime? nextSendAt;
@override@JsonKey() final  bool sent;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForgotPasswordStateCopyWith<_ForgotPasswordState> get copyWith => __$ForgotPasswordStateCopyWithImpl<_ForgotPasswordState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForgotPasswordState&&(identical(other.email, email) || other.email == email)&&(identical(other.busy, busy) || other.busy == busy)&&(identical(other.error, error) || other.error == error)&&(identical(other.nextSendAt, nextSendAt) || other.nextSendAt == nextSendAt)&&(identical(other.sent, sent) || other.sent == sent));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email,busy,error,nextSendAt,sent);
}

@override
String toString() {
    return 'ForgotPasswordState(email: $email, busy: $busy, error: $error, nextSendAt: $nextSendAt, sent: $sent)';
}


}

/// @nodoc
abstract mixin class _$ForgotPasswordStateCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory _$ForgotPasswordStateCopyWith(_ForgotPasswordState value, $Res Function(_ForgotPasswordState) _then) = __$ForgotPasswordStateCopyWithImpl;
@override @useResult
$Res call({
 String email, bool busy, AuthError? error, DateTime? nextSendAt, bool sent
});




}
/// @nodoc
class __$ForgotPasswordStateCopyWithImpl<$Res>
    implements _$ForgotPasswordStateCopyWith<$Res> {
  __$ForgotPasswordStateCopyWithImpl(this._self, this._then);

  final _ForgotPasswordState _self;
  final $Res Function(_ForgotPasswordState) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? busy = null,Object? error = freezed,Object? nextSendAt = freezed,Object? sent = null,}) {
  return _then(_ForgotPasswordState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AuthError?,nextSendAt: freezed == nextSendAt ? _self.nextSendAt : nextSendAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sent: null == sent ? _self.sent : sent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
