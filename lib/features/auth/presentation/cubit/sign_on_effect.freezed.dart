// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_on_effect.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignOnEffect {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SignOnEffect);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignOnEffect()';
}


}

/// @nodoc
class $SignOnEffectCopyWith<$Res>  {
$SignOnEffectCopyWith(SignOnEffect _, $Res Function(SignOnEffect) __);
}


/// Adds pattern-matching-related methods to [SignOnEffect].
extension SignOnEffectPatterns on SignOnEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SignOnToCode value)?  toCode,TResult Function( SignOnSignedIn value)?  signedIn,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SignOnToCode() when toCode != null:
return toCode(_that);case SignOnSignedIn() when signedIn != null:
return signedIn(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SignOnToCode value)  toCode,required TResult Function( SignOnSignedIn value)  signedIn,}){
final _that = this;
switch (_that) {
case SignOnToCode():
return toCode(_that);case SignOnSignedIn():
return signedIn(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SignOnToCode value)?  toCode,TResult? Function( SignOnSignedIn value)?  signedIn,}){
final _that = this;
switch (_that) {
case SignOnToCode() when toCode != null:
return toCode(_that);case SignOnSignedIn() when signedIn != null:
return signedIn(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  toCode,TResult Function( Session session)?  signedIn,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SignOnToCode() when toCode != null:
return toCode();case SignOnSignedIn() when signedIn != null:
return signedIn(_that.session);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  toCode,required TResult Function( Session session)  signedIn,}) {final _that = this;
switch (_that) {
case SignOnToCode():
return toCode();case SignOnSignedIn():
return signedIn(_that.session);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  toCode,TResult? Function( Session session)?  signedIn,}) {final _that = this;
switch (_that) {
case SignOnToCode() when toCode != null:
return toCode();case SignOnSignedIn() when signedIn != null:
return signedIn(_that.session);case _:
  return null;

}
}

}

/// @nodoc


class SignOnToCode implements SignOnEffect {
  const SignOnToCode();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SignOnToCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignOnEffect.toCode()';
}


}




/// @nodoc


class SignOnSignedIn implements SignOnEffect {
  const SignOnSignedIn(this.session);
  

 final  Session session;

/// Create a copy of SignOnEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignOnSignedInCopyWith<SignOnSignedIn> get copyWith => _$SignOnSignedInCopyWithImpl<SignOnSignedIn>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SignOnSignedIn&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode {
    return Object.hash(runtimeType,session);
}

@override
String toString() {
    return 'SignOnEffect.signedIn(session: $session)';
}


}

/// @nodoc
abstract mixin class $SignOnSignedInCopyWith<$Res> implements $SignOnEffectCopyWith<$Res> {
  factory $SignOnSignedInCopyWith(SignOnSignedIn value, $Res Function(SignOnSignedIn) _then) = _$SignOnSignedInCopyWithImpl;
@useResult
$Res call({
 Session session
});


$SessionCopyWith<$Res> get session;

}
/// @nodoc
class _$SignOnSignedInCopyWithImpl<$Res>
    implements $SignOnSignedInCopyWith<$Res> {
  _$SignOnSignedInCopyWithImpl(this._self, this._then);

  final SignOnSignedIn _self;
  final $Res Function(SignOnSignedIn) _then;

/// Create a copy of SignOnEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? session = null,}) {
  return _then(SignOnSignedIn(
null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as Session,
  ));
}

/// Create a copy of SignOnEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionCopyWith<$Res> get session {
  
  return $SessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
