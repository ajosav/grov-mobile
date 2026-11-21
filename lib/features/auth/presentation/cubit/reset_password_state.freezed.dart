// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResetPasswordState {

 ResetLinkStatus get link; bool get busy; Set<PasswordProblem> get problems; bool get serverChecked; AuthError? get error; Session? get signedInSession;
/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordStateCopyWith<ResetPasswordState> get copyWith => _$ResetPasswordStateCopyWithImpl<ResetPasswordState>(this as ResetPasswordState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ResetPasswordState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordState&&(identical(other.link, _this.link) || other.link == _this.link)&&(identical(other.busy, _this.busy) || other.busy == _this.busy)&&const DeepCollectionEquality().equals(other.problems, _this.problems)&&(identical(other.serverChecked, _this.serverChecked) || other.serverChecked == _this.serverChecked)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.signedInSession, _this.signedInSession) || other.signedInSession == _this.signedInSession));
}


@override
int get hashCode {
  final _this = this as ResetPasswordState;
  return Object.hash(runtimeType,_this.link,_this.busy,const DeepCollectionEquality().hash(_this.problems),_this.serverChecked,_this.error,_this.signedInSession);
}

@override
String toString() {
  final _this = this as ResetPasswordState;
  return 'ResetPasswordState(link: ${_this.link}, busy: ${_this.busy}, problems: ${_this.problems}, serverChecked: ${_this.serverChecked}, error: ${_this.error}, signedInSession: ${_this.signedInSession})';
}


}

/// @nodoc
abstract mixin class $ResetPasswordStateCopyWith<$Res>  {
  factory $ResetPasswordStateCopyWith(ResetPasswordState value, $Res Function(ResetPasswordState) _then) = _$ResetPasswordStateCopyWithImpl;
@useResult
$Res call({
 ResetLinkStatus link, bool busy, Set<PasswordProblem> problems, bool serverChecked, AuthError? error, Session? signedInSession
});


$SessionCopyWith<$Res>? get signedInSession;

}
/// @nodoc
class _$ResetPasswordStateCopyWithImpl<$Res>
    implements $ResetPasswordStateCopyWith<$Res> {
  _$ResetPasswordStateCopyWithImpl(this._self, this._then);

  final ResetPasswordState _self;
  final $Res Function(ResetPasswordState) _then;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? link = null,Object? busy = null,Object? problems = null,Object? serverChecked = null,Object? error = freezed,Object? signedInSession = freezed,}) {
  return _then(ResetPasswordState(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as ResetLinkStatus,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,problems: null == problems ? _self.problems : problems // ignore: cast_nullable_to_non_nullable
as Set<PasswordProblem>,serverChecked: null == serverChecked ? _self.serverChecked : serverChecked // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AuthError?,signedInSession: freezed == signedInSession ? _self.signedInSession : signedInSession // ignore: cast_nullable_to_non_nullable
as Session?,
  ));
}
/// Create a copy of ResetPasswordState
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


/// Adds pattern-matching-related methods to [ResetPasswordState].
extension ResetPasswordStatePatterns on ResetPasswordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResetPasswordState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResetPasswordState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResetPasswordState value)  $default,){
final _that = this;
switch (_that) {
case _ResetPasswordState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResetPasswordState value)?  $default,){
final _that = this;
switch (_that) {
case _ResetPasswordState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ResetLinkStatus link,  bool busy,  Set<PasswordProblem> problems,  bool serverChecked,  AuthError? error,  Session? signedInSession)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResetPasswordState() when $default != null:
return $default(_that.link,_that.busy,_that.problems,_that.serverChecked,_that.error,_that.signedInSession);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ResetLinkStatus link,  bool busy,  Set<PasswordProblem> problems,  bool serverChecked,  AuthError? error,  Session? signedInSession)  $default,) {final _that = this;
switch (_that) {
case _ResetPasswordState():
return $default(_that.link,_that.busy,_that.problems,_that.serverChecked,_that.error,_that.signedInSession);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ResetLinkStatus link,  bool busy,  Set<PasswordProblem> problems,  bool serverChecked,  AuthError? error,  Session? signedInSession)?  $default,) {final _that = this;
switch (_that) {
case _ResetPasswordState() when $default != null:
return $default(_that.link,_that.busy,_that.problems,_that.serverChecked,_that.error,_that.signedInSession);case _:
  return null;

}
}

}

/// @nodoc


class _ResetPasswordState implements ResetPasswordState {
  const _ResetPasswordState({this.link = ResetLinkStatus.checking, this.busy = false,  Set<PasswordProblem> problems = const <PasswordProblem>{}, this.serverChecked = false, this.error, this.signedInSession}): _problems = problems;
  

@override@JsonKey() final  ResetLinkStatus link;
@override@JsonKey() final  bool busy;
 final  Set<PasswordProblem> _problems;
@override@JsonKey() Set<PasswordProblem> get problems {
  if (_problems is EqualUnmodifiableSetView) return _problems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_problems);
}

@override@JsonKey() final  bool serverChecked;
@override final  AuthError? error;
@override final  Session? signedInSession;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetPasswordStateCopyWith<_ResetPasswordState> get copyWith => __$ResetPasswordStateCopyWithImpl<_ResetPasswordState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetPasswordState&&(identical(other.link, link) || other.link == link)&&(identical(other.busy, busy) || other.busy == busy)&&const DeepCollectionEquality().equals(other.problems, _problems)&&(identical(other.serverChecked, serverChecked) || other.serverChecked == serverChecked)&&(identical(other.error, error) || other.error == error)&&(identical(other.signedInSession, signedInSession) || other.signedInSession == signedInSession));
}


@override
int get hashCode {
    return Object.hash(runtimeType,link,busy,const DeepCollectionEquality().hash(_problems),serverChecked,error,signedInSession);
}

@override
String toString() {
    return 'ResetPasswordState(link: $link, busy: $busy, problems: $problems, serverChecked: $serverChecked, error: $error, signedInSession: $signedInSession)';
}


}

/// @nodoc
abstract mixin class _$ResetPasswordStateCopyWith<$Res> implements $ResetPasswordStateCopyWith<$Res> {
  factory _$ResetPasswordStateCopyWith(_ResetPasswordState value, $Res Function(_ResetPasswordState) _then) = __$ResetPasswordStateCopyWithImpl;
@override @useResult
$Res call({
 ResetLinkStatus link, bool busy, Set<PasswordProblem> problems, bool serverChecked, AuthError? error, Session? signedInSession
});


@override $SessionCopyWith<$Res>? get signedInSession;

}
/// @nodoc
class __$ResetPasswordStateCopyWithImpl<$Res>
    implements _$ResetPasswordStateCopyWith<$Res> {
  __$ResetPasswordStateCopyWithImpl(this._self, this._then);

  final _ResetPasswordState _self;
  final $Res Function(_ResetPasswordState) _then;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? link = null,Object? busy = null,Object? problems = null,Object? serverChecked = null,Object? error = freezed,Object? signedInSession = freezed,}) {
  return _then(_ResetPasswordState(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as ResetLinkStatus,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,problems: null == problems ? _self._problems : problems // ignore: cast_nullable_to_non_nullable
as Set<PasswordProblem>,serverChecked: null == serverChecked ? _self.serverChecked : serverChecked // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AuthError?,signedInSession: freezed == signedInSession ? _self.signedInSession : signedInSession // ignore: cast_nullable_to_non_nullable
as Session?,
  ));
}

/// Create a copy of ResetPasswordState
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
