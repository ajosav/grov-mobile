// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewProfile {

 String get ticket; String get firstName; String get lastName; String get phone; String get termsVersion;
/// Create a copy of NewProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewProfileCopyWith<NewProfile> get copyWith => _$NewProfileCopyWithImpl<NewProfile>(this as NewProfile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NewProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewProfile&&(identical(other.ticket, _this.ticket) || other.ticket == _this.ticket)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.termsVersion, _this.termsVersion) || other.termsVersion == _this.termsVersion));
}


@override
int get hashCode {
  final _this = this as NewProfile;
  return Object.hash(runtimeType,_this.ticket,_this.firstName,_this.lastName,_this.phone,_this.termsVersion);
}

@override
String toString() {
  final _this = this as NewProfile;
  return 'NewProfile(ticket: ${_this.ticket}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, phone: ${_this.phone}, termsVersion: ${_this.termsVersion})';
}


}

/// @nodoc
abstract mixin class $NewProfileCopyWith<$Res>  {
  factory $NewProfileCopyWith(NewProfile value, $Res Function(NewProfile) _then) = _$NewProfileCopyWithImpl;
@useResult
$Res call({
 String ticket, String firstName, String lastName, String phone, String termsVersion
});




}
/// @nodoc
class _$NewProfileCopyWithImpl<$Res>
    implements $NewProfileCopyWith<$Res> {
  _$NewProfileCopyWithImpl(this._self, this._then);

  final NewProfile _self;
  final $Res Function(NewProfile) _then;

/// Create a copy of NewProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticket = null,Object? firstName = null,Object? lastName = null,Object? phone = null,Object? termsVersion = null,}) {
  return _then(NewProfile(
ticket: null == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,termsVersion: null == termsVersion ? _self.termsVersion : termsVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NewProfile].
extension NewProfilePatterns on NewProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewProfile value)  $default,){
final _that = this;
switch (_that) {
case _NewProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewProfile value)?  $default,){
final _that = this;
switch (_that) {
case _NewProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticket,  String firstName,  String lastName,  String phone,  String termsVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewProfile() when $default != null:
return $default(_that.ticket,_that.firstName,_that.lastName,_that.phone,_that.termsVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticket,  String firstName,  String lastName,  String phone,  String termsVersion)  $default,) {final _that = this;
switch (_that) {
case _NewProfile():
return $default(_that.ticket,_that.firstName,_that.lastName,_that.phone,_that.termsVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticket,  String firstName,  String lastName,  String phone,  String termsVersion)?  $default,) {final _that = this;
switch (_that) {
case _NewProfile() when $default != null:
return $default(_that.ticket,_that.firstName,_that.lastName,_that.phone,_that.termsVersion);case _:
  return null;

}
}

}

/// @nodoc


class _NewProfile implements NewProfile {
  const _NewProfile({required this.ticket, required this.firstName, required this.lastName, required this.phone, required this.termsVersion});
  

@override final  String ticket;
@override final  String firstName;
@override final  String lastName;
@override final  String phone;
@override final  String termsVersion;

/// Create a copy of NewProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewProfileCopyWith<_NewProfile> get copyWith => __$NewProfileCopyWithImpl<_NewProfile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewProfile&&(identical(other.ticket, ticket) || other.ticket == ticket)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.termsVersion, termsVersion) || other.termsVersion == termsVersion));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ticket,firstName,lastName,phone,termsVersion);
}

@override
String toString() {
    return 'NewProfile(ticket: $ticket, firstName: $firstName, lastName: $lastName, phone: $phone, termsVersion: $termsVersion)';
}


}

/// @nodoc
abstract mixin class _$NewProfileCopyWith<$Res> implements $NewProfileCopyWith<$Res> {
  factory _$NewProfileCopyWith(_NewProfile value, $Res Function(_NewProfile) _then) = __$NewProfileCopyWithImpl;
@override @useResult
$Res call({
 String ticket, String firstName, String lastName, String phone, String termsVersion
});




}
/// @nodoc
class __$NewProfileCopyWithImpl<$Res>
    implements _$NewProfileCopyWith<$Res> {
  __$NewProfileCopyWithImpl(this._self, this._then);

  final _NewProfile _self;
  final $Res Function(_NewProfile) _then;

/// Create a copy of NewProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticket = null,Object? firstName = null,Object? lastName = null,Object? phone = null,Object? termsVersion = null,}) {
  return _then(_NewProfile(
ticket: null == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,termsVersion: null == termsVersion ? _self.termsVersion : termsVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
