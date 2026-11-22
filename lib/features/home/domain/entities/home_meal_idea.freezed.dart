// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_meal_idea.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeMealIdea {

 String get id; String get title; MealTime get mealTime; bool get cooked;/// Picture served by the backend. The app bundles no meal images.
 String? get photoUrl;/// TEMP test data only: a bundled picture used when [photoUrl] is null.
/// Delete this field and its asset once the API supplies photos.
 String? get photoAsset;
/// Create a copy of HomeMealIdea
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeMealIdeaCopyWith<HomeMealIdea> get copyWith => _$HomeMealIdeaCopyWithImpl<HomeMealIdea>(this as HomeMealIdea, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HomeMealIdea;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeMealIdea&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.mealTime, _this.mealTime) || other.mealTime == _this.mealTime)&&(identical(other.cooked, _this.cooked) || other.cooked == _this.cooked)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&(identical(other.photoAsset, _this.photoAsset) || other.photoAsset == _this.photoAsset));
}


@override
int get hashCode {
  final _this = this as HomeMealIdea;
  return Object.hash(runtimeType,_this.id,_this.title,_this.mealTime,_this.cooked,_this.photoUrl,_this.photoAsset);
}

@override
String toString() {
  final _this = this as HomeMealIdea;
  return 'HomeMealIdea(id: ${_this.id}, title: ${_this.title}, mealTime: ${_this.mealTime}, cooked: ${_this.cooked}, photoUrl: ${_this.photoUrl}, photoAsset: ${_this.photoAsset})';
}


}

/// @nodoc
abstract mixin class $HomeMealIdeaCopyWith<$Res>  {
  factory $HomeMealIdeaCopyWith(HomeMealIdea value, $Res Function(HomeMealIdea) _then) = _$HomeMealIdeaCopyWithImpl;
@useResult
$Res call({
 String id, String title, MealTime mealTime, bool cooked, String? photoUrl, String? photoAsset
});




}
/// @nodoc
class _$HomeMealIdeaCopyWithImpl<$Res>
    implements $HomeMealIdeaCopyWith<$Res> {
  _$HomeMealIdeaCopyWithImpl(this._self, this._then);

  final HomeMealIdea _self;
  final $Res Function(HomeMealIdea) _then;

/// Create a copy of HomeMealIdea
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? mealTime = null,Object? cooked = null,Object? photoUrl = freezed,Object? photoAsset = freezed,}) {
  return _then(HomeMealIdea(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,mealTime: null == mealTime ? _self.mealTime : mealTime // ignore: cast_nullable_to_non_nullable
as MealTime,cooked: null == cooked ? _self.cooked : cooked // ignore: cast_nullable_to_non_nullable
as bool,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,photoAsset: freezed == photoAsset ? _self.photoAsset : photoAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeMealIdea].
extension HomeMealIdeaPatterns on HomeMealIdea {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeMealIdea value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeMealIdea() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeMealIdea value)  $default,){
final _that = this;
switch (_that) {
case _HomeMealIdea():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeMealIdea value)?  $default,){
final _that = this;
switch (_that) {
case _HomeMealIdea() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  MealTime mealTime,  bool cooked,  String? photoUrl,  String? photoAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeMealIdea() when $default != null:
return $default(_that.id,_that.title,_that.mealTime,_that.cooked,_that.photoUrl,_that.photoAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  MealTime mealTime,  bool cooked,  String? photoUrl,  String? photoAsset)  $default,) {final _that = this;
switch (_that) {
case _HomeMealIdea():
return $default(_that.id,_that.title,_that.mealTime,_that.cooked,_that.photoUrl,_that.photoAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  MealTime mealTime,  bool cooked,  String? photoUrl,  String? photoAsset)?  $default,) {final _that = this;
switch (_that) {
case _HomeMealIdea() when $default != null:
return $default(_that.id,_that.title,_that.mealTime,_that.cooked,_that.photoUrl,_that.photoAsset);case _:
  return null;

}
}

}

/// @nodoc


class _HomeMealIdea implements HomeMealIdea {
  const _HomeMealIdea({required this.id, required this.title, required this.mealTime, required this.cooked, this.photoUrl, this.photoAsset});
  

@override final  String id;
@override final  String title;
@override final  MealTime mealTime;
@override final  bool cooked;
/// Picture served by the backend. The app bundles no meal images.
@override final  String? photoUrl;
/// TEMP test data only: a bundled picture used when [photoUrl] is null.
/// Delete this field and its asset once the API supplies photos.
@override final  String? photoAsset;

/// Create a copy of HomeMealIdea
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeMealIdeaCopyWith<_HomeMealIdea> get copyWith => __$HomeMealIdeaCopyWithImpl<_HomeMealIdea>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeMealIdea&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.mealTime, mealTime) || other.mealTime == mealTime)&&(identical(other.cooked, cooked) || other.cooked == cooked)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.photoAsset, photoAsset) || other.photoAsset == photoAsset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,mealTime,cooked,photoUrl,photoAsset);
}

@override
String toString() {
    return 'HomeMealIdea(id: $id, title: $title, mealTime: $mealTime, cooked: $cooked, photoUrl: $photoUrl, photoAsset: $photoAsset)';
}


}

/// @nodoc
abstract mixin class _$HomeMealIdeaCopyWith<$Res> implements $HomeMealIdeaCopyWith<$Res> {
  factory _$HomeMealIdeaCopyWith(_HomeMealIdea value, $Res Function(_HomeMealIdea) _then) = __$HomeMealIdeaCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, MealTime mealTime, bool cooked, String? photoUrl, String? photoAsset
});




}
/// @nodoc
class __$HomeMealIdeaCopyWithImpl<$Res>
    implements _$HomeMealIdeaCopyWith<$Res> {
  __$HomeMealIdeaCopyWithImpl(this._self, this._then);

  final _HomeMealIdea _self;
  final $Res Function(_HomeMealIdea) _then;

/// Create a copy of HomeMealIdea
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? mealTime = null,Object? cooked = null,Object? photoUrl = freezed,Object? photoAsset = freezed,}) {
  return _then(_HomeMealIdea(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,mealTime: null == mealTime ? _self.mealTime : mealTime // ignore: cast_nullable_to_non_nullable
as MealTime,cooked: null == cooked ? _self.cooked : cooked // ignore: cast_nullable_to_non_nullable
as bool,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,photoAsset: freezed == photoAsset ? _self.photoAsset : photoAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
