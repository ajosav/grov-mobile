// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_lookup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountLookup {

 bool get exists; bool get hasPassword; Set<AuthProvider> get providers;
/// Create a copy of AccountLookup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountLookupCopyWith<AccountLookup> get copyWith => _$AccountLookupCopyWithImpl<AccountLookup>(this as AccountLookup, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccountLookup;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountLookup&&(identical(other.exists, _this.exists) || other.exists == _this.exists)&&(identical(other.hasPassword, _this.hasPassword) || other.hasPassword == _this.hasPassword)&&const DeepCollectionEquality().equals(other.providers, _this.providers));
}


@override
int get hashCode {
  final _this = this as AccountLookup;
  return Object.hash(runtimeType,_this.exists,_this.hasPassword,const DeepCollectionEquality().hash(_this.providers));
}

@override
String toString() {
  final _this = this as AccountLookup;
  return 'AccountLookup(exists: ${_this.exists}, hasPassword: ${_this.hasPassword}, providers: ${_this.providers})';
}


}

/// @nodoc
abstract mixin class $AccountLookupCopyWith<$Res>  {
  factory $AccountLookupCopyWith(AccountLookup value, $Res Function(AccountLookup) _then) = _$AccountLookupCopyWithImpl;
@useResult
$Res call({
 bool exists, bool hasPassword, Set<AuthProvider> providers
});




}
/// @nodoc
class _$AccountLookupCopyWithImpl<$Res>
    implements $AccountLookupCopyWith<$Res> {
  _$AccountLookupCopyWithImpl(this._self, this._then);

  final AccountLookup _self;
  final $Res Function(AccountLookup) _then;

/// Create a copy of AccountLookup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exists = null,Object? hasPassword = null,Object? providers = null,}) {
  return _then(AccountLookup(
exists: null == exists ? _self.exists : exists // ignore: cast_nullable_to_non_nullable
as bool,hasPassword: null == hasPassword ? _self.hasPassword : hasPassword // ignore: cast_nullable_to_non_nullable
as bool,providers: null == providers ? _self.providers : providers // ignore: cast_nullable_to_non_nullable
as Set<AuthProvider>,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountLookup].
extension AccountLookupPatterns on AccountLookup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountLookup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountLookup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountLookup value)  $default,){
final _that = this;
switch (_that) {
case _AccountLookup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountLookup value)?  $default,){
final _that = this;
switch (_that) {
case _AccountLookup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool exists,  bool hasPassword,  Set<AuthProvider> providers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountLookup() when $default != null:
return $default(_that.exists,_that.hasPassword,_that.providers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool exists,  bool hasPassword,  Set<AuthProvider> providers)  $default,) {final _that = this;
switch (_that) {
case _AccountLookup():
return $default(_that.exists,_that.hasPassword,_that.providers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool exists,  bool hasPassword,  Set<AuthProvider> providers)?  $default,) {final _that = this;
switch (_that) {
case _AccountLookup() when $default != null:
return $default(_that.exists,_that.hasPassword,_that.providers);case _:
  return null;

}
}

}

/// @nodoc


class _AccountLookup implements AccountLookup {
  const _AccountLookup({required this.exists, required this.hasPassword,  Set<AuthProvider> providers = const <AuthProvider>{}}): _providers = providers;
  

@override final  bool exists;
@override final  bool hasPassword;
 final  Set<AuthProvider> _providers;
@override@JsonKey() Set<AuthProvider> get providers {
  if (_providers is EqualUnmodifiableSetView) return _providers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_providers);
}


/// Create a copy of AccountLookup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountLookupCopyWith<_AccountLookup> get copyWith => __$AccountLookupCopyWithImpl<_AccountLookup>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountLookup&&(identical(other.exists, exists) || other.exists == exists)&&(identical(other.hasPassword, hasPassword) || other.hasPassword == hasPassword)&&const DeepCollectionEquality().equals(other.providers, _providers));
}


@override
int get hashCode {
    return Object.hash(runtimeType,exists,hasPassword,const DeepCollectionEquality().hash(_providers));
}

@override
String toString() {
    return 'AccountLookup(exists: $exists, hasPassword: $hasPassword, providers: $providers)';
}


}

/// @nodoc
abstract mixin class _$AccountLookupCopyWith<$Res> implements $AccountLookupCopyWith<$Res> {
  factory _$AccountLookupCopyWith(_AccountLookup value, $Res Function(_AccountLookup) _then) = __$AccountLookupCopyWithImpl;
@override @useResult
$Res call({
 bool exists, bool hasPassword, Set<AuthProvider> providers
});




}
/// @nodoc
class __$AccountLookupCopyWithImpl<$Res>
    implements _$AccountLookupCopyWith<$Res> {
  __$AccountLookupCopyWithImpl(this._self, this._then);

  final _AccountLookup _self;
  final $Res Function(_AccountLookup) _then;

/// Create a copy of AccountLookup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exists = null,Object? hasPassword = null,Object? providers = null,}) {
  return _then(_AccountLookup(
exists: null == exists ? _self.exists : exists // ignore: cast_nullable_to_non_nullable
as bool,hasPassword: null == hasPassword ? _self.hasPassword : hasPassword // ignore: cast_nullable_to_non_nullable
as bool,providers: null == providers ? _self._providers : providers // ignore: cast_nullable_to_non_nullable
as Set<AuthProvider>,
  ));
}


}

// dart format on
