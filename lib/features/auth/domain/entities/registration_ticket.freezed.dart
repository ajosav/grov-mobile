// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegistrationTicket {

 String get ticket; DateTime get expiresAt;
/// Create a copy of RegistrationTicket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationTicketCopyWith<RegistrationTicket> get copyWith => _$RegistrationTicketCopyWithImpl<RegistrationTicket>(this as RegistrationTicket, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RegistrationTicket;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationTicket&&(identical(other.ticket, _this.ticket) || other.ticket == _this.ticket)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt));
}


@override
int get hashCode {
  final _this = this as RegistrationTicket;
  return Object.hash(runtimeType,_this.ticket,_this.expiresAt);
}

@override
String toString() {
  final _this = this as RegistrationTicket;
  return 'RegistrationTicket(ticket: ${_this.ticket}, expiresAt: ${_this.expiresAt})';
}


}

/// @nodoc
abstract mixin class $RegistrationTicketCopyWith<$Res>  {
  factory $RegistrationTicketCopyWith(RegistrationTicket value, $Res Function(RegistrationTicket) _then) = _$RegistrationTicketCopyWithImpl;
@useResult
$Res call({
 String ticket, DateTime expiresAt
});




}
/// @nodoc
class _$RegistrationTicketCopyWithImpl<$Res>
    implements $RegistrationTicketCopyWith<$Res> {
  _$RegistrationTicketCopyWithImpl(this._self, this._then);

  final RegistrationTicket _self;
  final $Res Function(RegistrationTicket) _then;

/// Create a copy of RegistrationTicket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticket = null,Object? expiresAt = null,}) {
  return _then(RegistrationTicket(
ticket: null == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RegistrationTicket].
extension RegistrationTicketPatterns on RegistrationTicket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegistrationTicket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegistrationTicket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegistrationTicket value)  $default,){
final _that = this;
switch (_that) {
case _RegistrationTicket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegistrationTicket value)?  $default,){
final _that = this;
switch (_that) {
case _RegistrationTicket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticket,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegistrationTicket() when $default != null:
return $default(_that.ticket,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticket,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _RegistrationTicket():
return $default(_that.ticket,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticket,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _RegistrationTicket() when $default != null:
return $default(_that.ticket,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc


class _RegistrationTicket implements RegistrationTicket {
  const _RegistrationTicket({required this.ticket, required this.expiresAt});
  

@override final  String ticket;
@override final  DateTime expiresAt;

/// Create a copy of RegistrationTicket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationTicketCopyWith<_RegistrationTicket> get copyWith => __$RegistrationTicketCopyWithImpl<_RegistrationTicket>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegistrationTicket&&(identical(other.ticket, ticket) || other.ticket == ticket)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ticket,expiresAt);
}

@override
String toString() {
    return 'RegistrationTicket(ticket: $ticket, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$RegistrationTicketCopyWith<$Res> implements $RegistrationTicketCopyWith<$Res> {
  factory _$RegistrationTicketCopyWith(_RegistrationTicket value, $Res Function(_RegistrationTicket) _then) = __$RegistrationTicketCopyWithImpl;
@override @useResult
$Res call({
 String ticket, DateTime expiresAt
});




}
/// @nodoc
class __$RegistrationTicketCopyWithImpl<$Res>
    implements _$RegistrationTicketCopyWith<$Res> {
  __$RegistrationTicketCopyWithImpl(this._self, this._then);

  final _RegistrationTicket _self;
  final $Res Function(_RegistrationTicket) _then;

/// Create a copy of RegistrationTicket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticket = null,Object? expiresAt = null,}) {
  return _then(_RegistrationTicket(
ticket: null == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
