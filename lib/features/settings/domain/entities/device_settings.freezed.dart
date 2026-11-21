// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeviceSettings {

 AppearanceMode get appearance; LowEndPreference get lowEnd; String? get rememberedEmail;
/// Create a copy of DeviceSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceSettingsCopyWith<DeviceSettings> get copyWith => _$DeviceSettingsCopyWithImpl<DeviceSettings>(this as DeviceSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DeviceSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSettings&&(identical(other.appearance, _this.appearance) || other.appearance == _this.appearance)&&(identical(other.lowEnd, _this.lowEnd) || other.lowEnd == _this.lowEnd)&&(identical(other.rememberedEmail, _this.rememberedEmail) || other.rememberedEmail == _this.rememberedEmail));
}


@override
int get hashCode {
  final _this = this as DeviceSettings;
  return Object.hash(runtimeType,_this.appearance,_this.lowEnd,_this.rememberedEmail);
}

@override
String toString() {
  final _this = this as DeviceSettings;
  return 'DeviceSettings(appearance: ${_this.appearance}, lowEnd: ${_this.lowEnd}, rememberedEmail: ${_this.rememberedEmail})';
}


}

/// @nodoc
abstract mixin class $DeviceSettingsCopyWith<$Res>  {
  factory $DeviceSettingsCopyWith(DeviceSettings value, $Res Function(DeviceSettings) _then) = _$DeviceSettingsCopyWithImpl;
@useResult
$Res call({
 AppearanceMode appearance, LowEndPreference lowEnd, String? rememberedEmail
});




}
/// @nodoc
class _$DeviceSettingsCopyWithImpl<$Res>
    implements $DeviceSettingsCopyWith<$Res> {
  _$DeviceSettingsCopyWithImpl(this._self, this._then);

  final DeviceSettings _self;
  final $Res Function(DeviceSettings) _then;

/// Create a copy of DeviceSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appearance = null,Object? lowEnd = null,Object? rememberedEmail = freezed,}) {
  return _then(DeviceSettings(
appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as AppearanceMode,lowEnd: null == lowEnd ? _self.lowEnd : lowEnd // ignore: cast_nullable_to_non_nullable
as LowEndPreference,rememberedEmail: freezed == rememberedEmail ? _self.rememberedEmail : rememberedEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceSettings].
extension DeviceSettingsPatterns on DeviceSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceSettings value)  $default,){
final _that = this;
switch (_that) {
case _DeviceSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceSettings value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppearanceMode appearance,  LowEndPreference lowEnd,  String? rememberedEmail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceSettings() when $default != null:
return $default(_that.appearance,_that.lowEnd,_that.rememberedEmail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppearanceMode appearance,  LowEndPreference lowEnd,  String? rememberedEmail)  $default,) {final _that = this;
switch (_that) {
case _DeviceSettings():
return $default(_that.appearance,_that.lowEnd,_that.rememberedEmail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppearanceMode appearance,  LowEndPreference lowEnd,  String? rememberedEmail)?  $default,) {final _that = this;
switch (_that) {
case _DeviceSettings() when $default != null:
return $default(_that.appearance,_that.lowEnd,_that.rememberedEmail);case _:
  return null;

}
}

}

/// @nodoc


class _DeviceSettings implements DeviceSettings {
  const _DeviceSettings({this.appearance = AppearanceMode.system, this.lowEnd = LowEndPreference.auto, this.rememberedEmail});
  

@override@JsonKey() final  AppearanceMode appearance;
@override@JsonKey() final  LowEndPreference lowEnd;
@override final  String? rememberedEmail;

/// Create a copy of DeviceSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceSettingsCopyWith<_DeviceSettings> get copyWith => __$DeviceSettingsCopyWithImpl<_DeviceSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceSettings&&(identical(other.appearance, appearance) || other.appearance == appearance)&&(identical(other.lowEnd, lowEnd) || other.lowEnd == lowEnd)&&(identical(other.rememberedEmail, rememberedEmail) || other.rememberedEmail == rememberedEmail));
}


@override
int get hashCode {
    return Object.hash(runtimeType,appearance,lowEnd,rememberedEmail);
}

@override
String toString() {
    return 'DeviceSettings(appearance: $appearance, lowEnd: $lowEnd, rememberedEmail: $rememberedEmail)';
}


}

/// @nodoc
abstract mixin class _$DeviceSettingsCopyWith<$Res> implements $DeviceSettingsCopyWith<$Res> {
  factory _$DeviceSettingsCopyWith(_DeviceSettings value, $Res Function(_DeviceSettings) _then) = __$DeviceSettingsCopyWithImpl;
@override @useResult
$Res call({
 AppearanceMode appearance, LowEndPreference lowEnd, String? rememberedEmail
});




}
/// @nodoc
class __$DeviceSettingsCopyWithImpl<$Res>
    implements _$DeviceSettingsCopyWith<$Res> {
  __$DeviceSettingsCopyWithImpl(this._self, this._then);

  final _DeviceSettings _self;
  final $Res Function(_DeviceSettings) _then;

/// Create a copy of DeviceSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appearance = null,Object? lowEnd = null,Object? rememberedEmail = freezed,}) {
  return _then(_DeviceSettings(
appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as AppearanceMode,lowEnd: null == lowEnd ? _self.lowEnd : lowEnd // ignore: cast_nullable_to_non_nullable
as LowEndPreference,rememberedEmail: freezed == rememberedEmail ? _self.rememberedEmail : rememberedEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
