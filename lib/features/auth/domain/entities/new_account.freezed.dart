// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewAccount {

 String get email; String get firstName; String get lastName; String get phone; String get password;
/// Create a copy of NewAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewAccountCopyWith<NewAccount> get copyWith => _$NewAccountCopyWithImpl<NewAccount>(this as NewAccount, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NewAccount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewAccount&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.password, _this.password) || other.password == _this.password));
}


@override
int get hashCode {
  final _this = this as NewAccount;
  return Object.hash(runtimeType,_this.email,_this.firstName,_this.lastName,_this.phone,_this.password);
}

@override
String toString() {
  final _this = this as NewAccount;
  return 'NewAccount(email: ${_this.email}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, phone: ${_this.phone}, password: ${_this.password})';
}


}

/// @nodoc
abstract mixin class $NewAccountCopyWith<$Res>  {
  factory $NewAccountCopyWith(NewAccount value, $Res Function(NewAccount) _then) = _$NewAccountCopyWithImpl;
@useResult
$Res call({
 String email, String firstName, String lastName, String phone, String password
});




}
/// @nodoc
class _$NewAccountCopyWithImpl<$Res>
    implements $NewAccountCopyWith<$Res> {
  _$NewAccountCopyWithImpl(this._self, this._then);

  final NewAccount _self;
  final $Res Function(NewAccount) _then;

/// Create a copy of NewAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? firstName = null,Object? lastName = null,Object? phone = null,Object? password = null,}) {
  return _then(NewAccount(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NewAccount].
extension NewAccountPatterns on NewAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewAccount value)  $default,){
final _that = this;
switch (_that) {
case _NewAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewAccount value)?  $default,){
final _that = this;
switch (_that) {
case _NewAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String firstName,  String lastName,  String phone,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewAccount() when $default != null:
return $default(_that.email,_that.firstName,_that.lastName,_that.phone,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String firstName,  String lastName,  String phone,  String password)  $default,) {final _that = this;
switch (_that) {
case _NewAccount():
return $default(_that.email,_that.firstName,_that.lastName,_that.phone,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String firstName,  String lastName,  String phone,  String password)?  $default,) {final _that = this;
switch (_that) {
case _NewAccount() when $default != null:
return $default(_that.email,_that.firstName,_that.lastName,_that.phone,_that.password);case _:
  return null;

}
}

}

/// @nodoc


class _NewAccount implements NewAccount {
  const _NewAccount({required this.email, required this.firstName, required this.lastName, required this.phone, required this.password});
  

@override final  String email;
@override final  String firstName;
@override final  String lastName;
@override final  String phone;
@override final  String password;

/// Create a copy of NewAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewAccountCopyWith<_NewAccount> get copyWith => __$NewAccountCopyWithImpl<_NewAccount>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewAccount&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email,firstName,lastName,phone,password);
}

@override
String toString() {
    return 'NewAccount(email: $email, firstName: $firstName, lastName: $lastName, phone: $phone, password: $password)';
}


}

/// @nodoc
abstract mixin class _$NewAccountCopyWith<$Res> implements $NewAccountCopyWith<$Res> {
  factory _$NewAccountCopyWith(_NewAccount value, $Res Function(_NewAccount) _then) = __$NewAccountCopyWithImpl;
@override @useResult
$Res call({
 String email, String firstName, String lastName, String phone, String password
});




}
/// @nodoc
class __$NewAccountCopyWithImpl<$Res>
    implements _$NewAccountCopyWith<$Res> {
  __$NewAccountCopyWithImpl(this._self, this._then);

  final _NewAccount _self;
  final $Res Function(_NewAccount) _then;

/// Create a copy of NewAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? firstName = null,Object? lastName = null,Object? phone = null,Object? password = null,}) {
  return _then(_NewAccount(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
