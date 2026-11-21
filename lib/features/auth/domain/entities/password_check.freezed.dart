// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_check.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PasswordCheck {

 bool get ok; Set<PasswordProblem> get problems;
/// Create a copy of PasswordCheck
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PasswordCheckCopyWith<PasswordCheck> get copyWith => _$PasswordCheckCopyWithImpl<PasswordCheck>(this as PasswordCheck, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PasswordCheck;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordCheck&&(identical(other.ok, _this.ok) || other.ok == _this.ok)&&const DeepCollectionEquality().equals(other.problems, _this.problems));
}


@override
int get hashCode {
  final _this = this as PasswordCheck;
  return Object.hash(runtimeType,_this.ok,const DeepCollectionEquality().hash(_this.problems));
}

@override
String toString() {
  final _this = this as PasswordCheck;
  return 'PasswordCheck(ok: ${_this.ok}, problems: ${_this.problems})';
}


}

/// @nodoc
abstract mixin class $PasswordCheckCopyWith<$Res>  {
  factory $PasswordCheckCopyWith(PasswordCheck value, $Res Function(PasswordCheck) _then) = _$PasswordCheckCopyWithImpl;
@useResult
$Res call({
 bool ok, Set<PasswordProblem> problems
});




}
/// @nodoc
class _$PasswordCheckCopyWithImpl<$Res>
    implements $PasswordCheckCopyWith<$Res> {
  _$PasswordCheckCopyWithImpl(this._self, this._then);

  final PasswordCheck _self;
  final $Res Function(PasswordCheck) _then;

/// Create a copy of PasswordCheck
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ok = null,Object? problems = null,}) {
  return _then(PasswordCheck(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,problems: null == problems ? _self.problems : problems // ignore: cast_nullable_to_non_nullable
as Set<PasswordProblem>,
  ));
}

}


/// Adds pattern-matching-related methods to [PasswordCheck].
extension PasswordCheckPatterns on PasswordCheck {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PasswordCheck value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PasswordCheck() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PasswordCheck value)  $default,){
final _that = this;
switch (_that) {
case _PasswordCheck():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PasswordCheck value)?  $default,){
final _that = this;
switch (_that) {
case _PasswordCheck() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool ok,  Set<PasswordProblem> problems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PasswordCheck() when $default != null:
return $default(_that.ok,_that.problems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool ok,  Set<PasswordProblem> problems)  $default,) {final _that = this;
switch (_that) {
case _PasswordCheck():
return $default(_that.ok,_that.problems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool ok,  Set<PasswordProblem> problems)?  $default,) {final _that = this;
switch (_that) {
case _PasswordCheck() when $default != null:
return $default(_that.ok,_that.problems);case _:
  return null;

}
}

}

/// @nodoc


class _PasswordCheck implements PasswordCheck {
  const _PasswordCheck({required this.ok,  Set<PasswordProblem> problems = const <PasswordProblem>{}}): _problems = problems;
  

@override final  bool ok;
 final  Set<PasswordProblem> _problems;
@override@JsonKey() Set<PasswordProblem> get problems {
  if (_problems is EqualUnmodifiableSetView) return _problems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_problems);
}


/// Create a copy of PasswordCheck
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordCheckCopyWith<_PasswordCheck> get copyWith => __$PasswordCheckCopyWithImpl<_PasswordCheck>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordCheck&&(identical(other.ok, ok) || other.ok == ok)&&const DeepCollectionEquality().equals(other.problems, _problems));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ok,const DeepCollectionEquality().hash(_problems));
}

@override
String toString() {
    return 'PasswordCheck(ok: $ok, problems: $problems)';
}


}

/// @nodoc
abstract mixin class _$PasswordCheckCopyWith<$Res> implements $PasswordCheckCopyWith<$Res> {
  factory _$PasswordCheckCopyWith(_PasswordCheck value, $Res Function(_PasswordCheck) _then) = __$PasswordCheckCopyWithImpl;
@override @useResult
$Res call({
 bool ok, Set<PasswordProblem> problems
});




}
/// @nodoc
class __$PasswordCheckCopyWithImpl<$Res>
    implements _$PasswordCheckCopyWith<$Res> {
  __$PasswordCheckCopyWithImpl(this._self, this._then);

  final _PasswordCheck _self;
  final $Res Function(_PasswordCheck) _then;

/// Create a copy of PasswordCheck
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ok = null,Object? problems = null,}) {
  return _then(_PasswordCheck(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,problems: null == problems ? _self._problems : problems // ignore: cast_nullable_to_non_nullable
as Set<PasswordProblem>,
  ));
}


}

// dart format on
