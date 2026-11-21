// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeviceSettingsState {

 DeviceSettings get settings;/// Android reports a low-RAM device.
 bool get lowRamDevice;/// False until the first read from Drift. The app renders defaults (system
/// theme, blur per device) until then, so the first frame never waits.
 bool get loaded;
/// Create a copy of DeviceSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceSettingsStateCopyWith<DeviceSettingsState> get copyWith => _$DeviceSettingsStateCopyWithImpl<DeviceSettingsState>(this as DeviceSettingsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DeviceSettingsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSettingsState&&(identical(other.settings, _this.settings) || other.settings == _this.settings)&&(identical(other.lowRamDevice, _this.lowRamDevice) || other.lowRamDevice == _this.lowRamDevice)&&(identical(other.loaded, _this.loaded) || other.loaded == _this.loaded));
}


@override
int get hashCode {
  final _this = this as DeviceSettingsState;
  return Object.hash(runtimeType,_this.settings,_this.lowRamDevice,_this.loaded);
}

@override
String toString() {
  final _this = this as DeviceSettingsState;
  return 'DeviceSettingsState(settings: ${_this.settings}, lowRamDevice: ${_this.lowRamDevice}, loaded: ${_this.loaded})';
}


}

/// @nodoc
abstract mixin class $DeviceSettingsStateCopyWith<$Res>  {
  factory $DeviceSettingsStateCopyWith(DeviceSettingsState value, $Res Function(DeviceSettingsState) _then) = _$DeviceSettingsStateCopyWithImpl;
@useResult
$Res call({
 DeviceSettings settings, bool lowRamDevice, bool loaded
});


$DeviceSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class _$DeviceSettingsStateCopyWithImpl<$Res>
    implements $DeviceSettingsStateCopyWith<$Res> {
  _$DeviceSettingsStateCopyWithImpl(this._self, this._then);

  final DeviceSettingsState _self;
  final $Res Function(DeviceSettingsState) _then;

/// Create a copy of DeviceSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = null,Object? lowRamDevice = null,Object? loaded = null,}) {
  return _then(DeviceSettingsState(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as DeviceSettings,lowRamDevice: null == lowRamDevice ? _self.lowRamDevice : lowRamDevice // ignore: cast_nullable_to_non_nullable
as bool,loaded: null == loaded ? _self.loaded : loaded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of DeviceSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceSettingsCopyWith<$Res> get settings {
  
  return $DeviceSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}


/// Adds pattern-matching-related methods to [DeviceSettingsState].
extension DeviceSettingsStatePatterns on DeviceSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _DeviceSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DeviceSettings settings,  bool lowRamDevice,  bool loaded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceSettingsState() when $default != null:
return $default(_that.settings,_that.lowRamDevice,_that.loaded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DeviceSettings settings,  bool lowRamDevice,  bool loaded)  $default,) {final _that = this;
switch (_that) {
case _DeviceSettingsState():
return $default(_that.settings,_that.lowRamDevice,_that.loaded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DeviceSettings settings,  bool lowRamDevice,  bool loaded)?  $default,) {final _that = this;
switch (_that) {
case _DeviceSettingsState() when $default != null:
return $default(_that.settings,_that.lowRamDevice,_that.loaded);case _:
  return null;

}
}

}

/// @nodoc


class _DeviceSettingsState extends DeviceSettingsState {
  const _DeviceSettingsState({this.settings = const DeviceSettings(), this.lowRamDevice = false, this.loaded = false}): super._();
  

@override@JsonKey() final  DeviceSettings settings;
/// Android reports a low-RAM device.
@override@JsonKey() final  bool lowRamDevice;
/// False until the first read from Drift. The app renders defaults (system
/// theme, blur per device) until then, so the first frame never waits.
@override@JsonKey() final  bool loaded;

/// Create a copy of DeviceSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceSettingsStateCopyWith<_DeviceSettingsState> get copyWith => __$DeviceSettingsStateCopyWithImpl<_DeviceSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceSettingsState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.lowRamDevice, lowRamDevice) || other.lowRamDevice == lowRamDevice)&&(identical(other.loaded, loaded) || other.loaded == loaded));
}


@override
int get hashCode {
    return Object.hash(runtimeType,settings,lowRamDevice,loaded);
}

@override
String toString() {
    return 'DeviceSettingsState(settings: $settings, lowRamDevice: $lowRamDevice, loaded: $loaded)';
}


}

/// @nodoc
abstract mixin class _$DeviceSettingsStateCopyWith<$Res> implements $DeviceSettingsStateCopyWith<$Res> {
  factory _$DeviceSettingsStateCopyWith(_DeviceSettingsState value, $Res Function(_DeviceSettingsState) _then) = __$DeviceSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 DeviceSettings settings, bool lowRamDevice, bool loaded
});


@override $DeviceSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class __$DeviceSettingsStateCopyWithImpl<$Res>
    implements _$DeviceSettingsStateCopyWith<$Res> {
  __$DeviceSettingsStateCopyWithImpl(this._self, this._then);

  final _DeviceSettingsState _self;
  final $Res Function(_DeviceSettingsState) _then;

/// Create a copy of DeviceSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = null,Object? lowRamDevice = null,Object? loaded = null,}) {
  return _then(_DeviceSettingsState(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as DeviceSettings,lowRamDevice: null == lowRamDevice ? _self.lowRamDevice : lowRamDevice // ignore: cast_nullable_to_non_nullable
as bool,loaded: null == loaded ? _self.loaded : loaded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of DeviceSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceSettingsCopyWith<$Res> get settings {
  
  return $DeviceSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

// dart format on
