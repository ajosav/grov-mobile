// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'code_verification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CodeVerification {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CodeVerification);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CodeVerification()';
}


}

/// @nodoc
class $CodeVerificationCopyWith<$Res>  {
$CodeVerificationCopyWith(CodeVerification _, $Res Function(CodeVerification) __);
}


/// Adds pattern-matching-related methods to [CodeVerification].
extension CodeVerificationPatterns on CodeVerification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CodeSignedIn value)?  signedIn,TResult Function( CodeProfileRequired value)?  profileRequired,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CodeSignedIn() when signedIn != null:
return signedIn(_that);case CodeProfileRequired() when profileRequired != null:
return profileRequired(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CodeSignedIn value)  signedIn,required TResult Function( CodeProfileRequired value)  profileRequired,}){
final _that = this;
switch (_that) {
case CodeSignedIn():
return signedIn(_that);case CodeProfileRequired():
return profileRequired(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CodeSignedIn value)?  signedIn,TResult? Function( CodeProfileRequired value)?  profileRequired,}){
final _that = this;
switch (_that) {
case CodeSignedIn() when signedIn != null:
return signedIn(_that);case CodeProfileRequired() when profileRequired != null:
return profileRequired(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AuthOutcome outcome)?  signedIn,TResult Function( RegistrationTicket ticket)?  profileRequired,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CodeSignedIn() when signedIn != null:
return signedIn(_that.outcome);case CodeProfileRequired() when profileRequired != null:
return profileRequired(_that.ticket);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AuthOutcome outcome)  signedIn,required TResult Function( RegistrationTicket ticket)  profileRequired,}) {final _that = this;
switch (_that) {
case CodeSignedIn():
return signedIn(_that.outcome);case CodeProfileRequired():
return profileRequired(_that.ticket);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AuthOutcome outcome)?  signedIn,TResult? Function( RegistrationTicket ticket)?  profileRequired,}) {final _that = this;
switch (_that) {
case CodeSignedIn() when signedIn != null:
return signedIn(_that.outcome);case CodeProfileRequired() when profileRequired != null:
return profileRequired(_that.ticket);case _:
  return null;

}
}

}

/// @nodoc


class CodeSignedIn implements CodeVerification {
  const CodeSignedIn(this.outcome);
  

 final  AuthOutcome outcome;

/// Create a copy of CodeVerification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodeSignedInCopyWith<CodeSignedIn> get copyWith => _$CodeSignedInCopyWithImpl<CodeSignedIn>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CodeSignedIn&&(identical(other.outcome, outcome) || other.outcome == outcome));
}


@override
int get hashCode {
    return Object.hash(runtimeType,outcome);
}

@override
String toString() {
    return 'CodeVerification.signedIn(outcome: $outcome)';
}


}

/// @nodoc
abstract mixin class $CodeSignedInCopyWith<$Res> implements $CodeVerificationCopyWith<$Res> {
  factory $CodeSignedInCopyWith(CodeSignedIn value, $Res Function(CodeSignedIn) _then) = _$CodeSignedInCopyWithImpl;
@useResult
$Res call({
 AuthOutcome outcome
});


$AuthOutcomeCopyWith<$Res> get outcome;

}
/// @nodoc
class _$CodeSignedInCopyWithImpl<$Res>
    implements $CodeSignedInCopyWith<$Res> {
  _$CodeSignedInCopyWithImpl(this._self, this._then);

  final CodeSignedIn _self;
  final $Res Function(CodeSignedIn) _then;

/// Create a copy of CodeVerification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? outcome = null,}) {
  return _then(CodeSignedIn(
null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as AuthOutcome,
  ));
}

/// Create a copy of CodeVerification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthOutcomeCopyWith<$Res> get outcome {
  
  return $AuthOutcomeCopyWith<$Res>(_self.outcome, (value) {
    return _then(_self.copyWith(outcome: value));
  });
}
}

/// @nodoc


class CodeProfileRequired implements CodeVerification {
  const CodeProfileRequired(this.ticket);
  

 final  RegistrationTicket ticket;

/// Create a copy of CodeVerification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodeProfileRequiredCopyWith<CodeProfileRequired> get copyWith => _$CodeProfileRequiredCopyWithImpl<CodeProfileRequired>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CodeProfileRequired&&(identical(other.ticket, ticket) || other.ticket == ticket));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ticket);
}

@override
String toString() {
    return 'CodeVerification.profileRequired(ticket: $ticket)';
}


}

/// @nodoc
abstract mixin class $CodeProfileRequiredCopyWith<$Res> implements $CodeVerificationCopyWith<$Res> {
  factory $CodeProfileRequiredCopyWith(CodeProfileRequired value, $Res Function(CodeProfileRequired) _then) = _$CodeProfileRequiredCopyWithImpl;
@useResult
$Res call({
 RegistrationTicket ticket
});


$RegistrationTicketCopyWith<$Res> get ticket;

}
/// @nodoc
class _$CodeProfileRequiredCopyWithImpl<$Res>
    implements $CodeProfileRequiredCopyWith<$Res> {
  _$CodeProfileRequiredCopyWithImpl(this._self, this._then);

  final CodeProfileRequired _self;
  final $Res Function(CodeProfileRequired) _then;

/// Create a copy of CodeVerification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticket = null,}) {
  return _then(CodeProfileRequired(
null == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as RegistrationTicket,
  ));
}

/// Create a copy of CodeVerification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegistrationTicketCopyWith<$Res> get ticket {
  
  return $RegistrationTicketCopyWith<$Res>(_self.ticket, (value) {
    return _then(_self.copyWith(ticket: value));
  });
}
}

// dart format on
