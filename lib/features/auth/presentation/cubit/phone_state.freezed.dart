// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PhoneState {

 bool get busy; AuthError? get error; Session? get signedInSession;
/// Create a copy of PhoneState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneStateCopyWith<PhoneState> get copyWith => _$PhoneStateCopyWithImpl<PhoneState>(this as PhoneState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PhoneState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneState&&(identical(other.busy, _this.busy) || other.busy == _this.busy)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.signedInSession, _this.signedInSession) || other.signedInSession == _this.signedInSession));
}


@override
int get hashCode {
  final _this = this as PhoneState;
  return Object.hash(runtimeType,_this.busy,_this.error,_this.signedInSession);
}

@override
String toString() {
  final _this = this as PhoneState;
  return 'PhoneState(busy: ${_this.busy}, error: ${_this.error}, signedInSession: ${_this.signedInSession})';
}


}

/// @nodoc
abstract mixin class $PhoneStateCopyWith<$Res>  {
  factory $PhoneStateCopyWith(PhoneState value, $Res Function(PhoneState) _then) = _$PhoneStateCopyWithImpl;
@useResult
$Res call({
 bool busy, AuthError? error, Session? signedInSession
});


$SessionCopyWith<$Res>? get signedInSession;

}
/// @nodoc
class _$PhoneStateCopyWithImpl<$Res>
    implements $PhoneStateCopyWith<$Res> {
  _$PhoneStateCopyWithImpl(this._self, this._then);

  final PhoneState _self;
  final $Res Function(PhoneState) _then;

/// Create a copy of PhoneState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? busy = null,Object? error = freezed,Object? signedInSession = freezed,}) {
  return _then(PhoneState(
busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AuthError?,signedInSession: freezed == signedInSession ? _self.signedInSession : signedInSession // ignore: cast_nullable_to_non_nullable
as Session?,
  ));
}
/// Create a copy of PhoneState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res>? get signedInSession {
    if (_self.signedInSession == null) {
    return null;
  }

  return $SessionCopyWith<$Res>(_self.signedInSession!, (value) {
    return _then(_self.copyWith(signedInSession: value));
  });
}
}


/// Adds pattern-matching-related methods to [PhoneState].
extension PhoneStatePatterns on PhoneState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneState value)  $default,){
final _that = this;
switch (_that) {
case _PhoneState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneState value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool busy,  AuthError? error,  Session? signedInSession)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneState() when $default != null:
return $default(_that.busy,_that.error,_that.signedInSession);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool busy,  AuthError? error,  Session? signedInSession)  $default,) {final _that = this;
switch (_that) {
case _PhoneState():
return $default(_that.busy,_that.error,_that.signedInSession);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool busy,  AuthError? error,  Session? signedInSession)?  $default,) {final _that = this;
switch (_that) {
case _PhoneState() when $default != null:
return $default(_that.busy,_that.error,_that.signedInSession);case _:
  return null;

}
}

}

/// @nodoc


class _PhoneState implements PhoneState {
  const _PhoneState({this.busy = false, this.error, this.signedInSession});
  

@override@JsonKey() final  bool busy;
@override final  AuthError? error;
@override final  Session? signedInSession;

/// Create a copy of PhoneState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneStateCopyWith<_PhoneState> get copyWith => __$PhoneStateCopyWithImpl<_PhoneState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneState&&(identical(other.busy, busy) || other.busy == busy)&&(identical(other.error, error) || other.error == error)&&(identical(other.signedInSession, signedInSession) || other.signedInSession == signedInSession));
}


@override
int get hashCode {
    return Object.hash(runtimeType,busy,error,signedInSession);
}

@override
String toString() {
    return 'PhoneState(busy: $busy, error: $error, signedInSession: $signedInSession)';
}


}

/// @nodoc
abstract mixin class _$PhoneStateCopyWith<$Res> implements $PhoneStateCopyWith<$Res> {
  factory _$PhoneStateCopyWith(_PhoneState value, $Res Function(_PhoneState) _then) = __$PhoneStateCopyWithImpl;
@override @useResult
$Res call({
 bool busy, AuthError? error, Session? signedInSession
});


@override $SessionCopyWith<$Res>? get signedInSession;

}
/// @nodoc
class __$PhoneStateCopyWithImpl<$Res>
    implements _$PhoneStateCopyWith<$Res> {
  __$PhoneStateCopyWithImpl(this._self, this._then);

  final _PhoneState _self;
  final $Res Function(_PhoneState) _then;

/// Create a copy of PhoneState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? busy = null,Object? error = freezed,Object? signedInSession = freezed,}) {
  return _then(_PhoneState(
busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AuthError?,signedInSession: freezed == signedInSession ? _self.signedInSession : signedInSession // ignore: cast_nullable_to_non_nullable
as Session?,
  ));
}

/// Create a copy of PhoneState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res>? get signedInSession {
    if (_self.signedInSession == null) {
    return null;
  }

  return $SessionCopyWith<$Res>(_self.signedInSession!, (value) {
    return _then(_self.copyWith(signedInSession: value));
  });
}
}

// dart format on
