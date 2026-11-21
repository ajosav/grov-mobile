// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeSummary {

 String get householdName; int get budgetUsedPercent; int get mealsCompleted; int get mealsPlanned; HomeMealIdea? get mealIdea; int get stockToBuyCount; int get stockToBuyKobo;
/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSummaryCopyWith<HomeSummary> get copyWith => _$HomeSummaryCopyWithImpl<HomeSummary>(this as HomeSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HomeSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSummary&&(identical(other.householdName, _this.householdName) || other.householdName == _this.householdName)&&(identical(other.budgetUsedPercent, _this.budgetUsedPercent) || other.budgetUsedPercent == _this.budgetUsedPercent)&&(identical(other.mealsCompleted, _this.mealsCompleted) || other.mealsCompleted == _this.mealsCompleted)&&(identical(other.mealsPlanned, _this.mealsPlanned) || other.mealsPlanned == _this.mealsPlanned)&&(identical(other.mealIdea, _this.mealIdea) || other.mealIdea == _this.mealIdea)&&(identical(other.stockToBuyCount, _this.stockToBuyCount) || other.stockToBuyCount == _this.stockToBuyCount)&&(identical(other.stockToBuyKobo, _this.stockToBuyKobo) || other.stockToBuyKobo == _this.stockToBuyKobo));
}


@override
int get hashCode {
  final _this = this as HomeSummary;
  return Object.hash(runtimeType,_this.householdName,_this.budgetUsedPercent,_this.mealsCompleted,_this.mealsPlanned,_this.mealIdea,_this.stockToBuyCount,_this.stockToBuyKobo);
}

@override
String toString() {
  final _this = this as HomeSummary;
  return 'HomeSummary(householdName: ${_this.householdName}, budgetUsedPercent: ${_this.budgetUsedPercent}, mealsCompleted: ${_this.mealsCompleted}, mealsPlanned: ${_this.mealsPlanned}, mealIdea: ${_this.mealIdea}, stockToBuyCount: ${_this.stockToBuyCount}, stockToBuyKobo: ${_this.stockToBuyKobo})';
}


}

/// @nodoc
abstract mixin class $HomeSummaryCopyWith<$Res>  {
  factory $HomeSummaryCopyWith(HomeSummary value, $Res Function(HomeSummary) _then) = _$HomeSummaryCopyWithImpl;
@useResult
$Res call({
 String householdName, int budgetUsedPercent, int mealsCompleted, int mealsPlanned, HomeMealIdea? mealIdea, int stockToBuyCount, int stockToBuyKobo
});


$HomeMealIdeaCopyWith<$Res>? get mealIdea;

}
/// @nodoc
class _$HomeSummaryCopyWithImpl<$Res>
    implements $HomeSummaryCopyWith<$Res> {
  _$HomeSummaryCopyWithImpl(this._self, this._then);

  final HomeSummary _self;
  final $Res Function(HomeSummary) _then;

/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? householdName = null,Object? budgetUsedPercent = null,Object? mealsCompleted = null,Object? mealsPlanned = null,Object? mealIdea = freezed,Object? stockToBuyCount = null,Object? stockToBuyKobo = null,}) {
  return _then(HomeSummary(
householdName: null == householdName ? _self.householdName : householdName // ignore: cast_nullable_to_non_nullable
as String,budgetUsedPercent: null == budgetUsedPercent ? _self.budgetUsedPercent : budgetUsedPercent // ignore: cast_nullable_to_non_nullable
as int,mealsCompleted: null == mealsCompleted ? _self.mealsCompleted : mealsCompleted // ignore: cast_nullable_to_non_nullable
as int,mealsPlanned: null == mealsPlanned ? _self.mealsPlanned : mealsPlanned // ignore: cast_nullable_to_non_nullable
as int,mealIdea: freezed == mealIdea ? _self.mealIdea : mealIdea // ignore: cast_nullable_to_non_nullable
as HomeMealIdea?,stockToBuyCount: null == stockToBuyCount ? _self.stockToBuyCount : stockToBuyCount // ignore: cast_nullable_to_non_nullable
as int,stockToBuyKobo: null == stockToBuyKobo ? _self.stockToBuyKobo : stockToBuyKobo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeMealIdeaCopyWith<$Res>? get mealIdea {
    if (_self.mealIdea == null) {
    return null;
  }

  return $HomeMealIdeaCopyWith<$Res>(_self.mealIdea!, (value) {
    return _then(_self.copyWith(mealIdea: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeSummary].
extension HomeSummaryPatterns on HomeSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeSummary value)  $default,){
final _that = this;
switch (_that) {
case _HomeSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String householdName,  int budgetUsedPercent,  int mealsCompleted,  int mealsPlanned,  HomeMealIdea? mealIdea,  int stockToBuyCount,  int stockToBuyKobo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
return $default(_that.householdName,_that.budgetUsedPercent,_that.mealsCompleted,_that.mealsPlanned,_that.mealIdea,_that.stockToBuyCount,_that.stockToBuyKobo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String householdName,  int budgetUsedPercent,  int mealsCompleted,  int mealsPlanned,  HomeMealIdea? mealIdea,  int stockToBuyCount,  int stockToBuyKobo)  $default,) {final _that = this;
switch (_that) {
case _HomeSummary():
return $default(_that.householdName,_that.budgetUsedPercent,_that.mealsCompleted,_that.mealsPlanned,_that.mealIdea,_that.stockToBuyCount,_that.stockToBuyKobo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String householdName,  int budgetUsedPercent,  int mealsCompleted,  int mealsPlanned,  HomeMealIdea? mealIdea,  int stockToBuyCount,  int stockToBuyKobo)?  $default,) {final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
return $default(_that.householdName,_that.budgetUsedPercent,_that.mealsCompleted,_that.mealsPlanned,_that.mealIdea,_that.stockToBuyCount,_that.stockToBuyKobo);case _:
  return null;

}
}

}

/// @nodoc


class _HomeSummary implements HomeSummary {
  const _HomeSummary({required this.householdName, required this.budgetUsedPercent, required this.mealsCompleted, required this.mealsPlanned, this.mealIdea, required this.stockToBuyCount, required this.stockToBuyKobo});
  

@override final  String householdName;
@override final  int budgetUsedPercent;
@override final  int mealsCompleted;
@override final  int mealsPlanned;
@override final  HomeMealIdea? mealIdea;
@override final  int stockToBuyCount;
@override final  int stockToBuyKobo;

/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeSummaryCopyWith<_HomeSummary> get copyWith => __$HomeSummaryCopyWithImpl<_HomeSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeSummary&&(identical(other.householdName, householdName) || other.householdName == householdName)&&(identical(other.budgetUsedPercent, budgetUsedPercent) || other.budgetUsedPercent == budgetUsedPercent)&&(identical(other.mealsCompleted, mealsCompleted) || other.mealsCompleted == mealsCompleted)&&(identical(other.mealsPlanned, mealsPlanned) || other.mealsPlanned == mealsPlanned)&&(identical(other.mealIdea, mealIdea) || other.mealIdea == mealIdea)&&(identical(other.stockToBuyCount, stockToBuyCount) || other.stockToBuyCount == stockToBuyCount)&&(identical(other.stockToBuyKobo, stockToBuyKobo) || other.stockToBuyKobo == stockToBuyKobo));
}


@override
int get hashCode {
    return Object.hash(runtimeType,householdName,budgetUsedPercent,mealsCompleted,mealsPlanned,mealIdea,stockToBuyCount,stockToBuyKobo);
}

@override
String toString() {
    return 'HomeSummary(householdName: $householdName, budgetUsedPercent: $budgetUsedPercent, mealsCompleted: $mealsCompleted, mealsPlanned: $mealsPlanned, mealIdea: $mealIdea, stockToBuyCount: $stockToBuyCount, stockToBuyKobo: $stockToBuyKobo)';
}


}

/// @nodoc
abstract mixin class _$HomeSummaryCopyWith<$Res> implements $HomeSummaryCopyWith<$Res> {
  factory _$HomeSummaryCopyWith(_HomeSummary value, $Res Function(_HomeSummary) _then) = __$HomeSummaryCopyWithImpl;
@override @useResult
$Res call({
 String householdName, int budgetUsedPercent, int mealsCompleted, int mealsPlanned, HomeMealIdea? mealIdea, int stockToBuyCount, int stockToBuyKobo
});


@override $HomeMealIdeaCopyWith<$Res>? get mealIdea;

}
/// @nodoc
class __$HomeSummaryCopyWithImpl<$Res>
    implements _$HomeSummaryCopyWith<$Res> {
  __$HomeSummaryCopyWithImpl(this._self, this._then);

  final _HomeSummary _self;
  final $Res Function(_HomeSummary) _then;

/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? householdName = null,Object? budgetUsedPercent = null,Object? mealsCompleted = null,Object? mealsPlanned = null,Object? mealIdea = freezed,Object? stockToBuyCount = null,Object? stockToBuyKobo = null,}) {
  return _then(_HomeSummary(
householdName: null == householdName ? _self.householdName : householdName // ignore: cast_nullable_to_non_nullable
as String,budgetUsedPercent: null == budgetUsedPercent ? _self.budgetUsedPercent : budgetUsedPercent // ignore: cast_nullable_to_non_nullable
as int,mealsCompleted: null == mealsCompleted ? _self.mealsCompleted : mealsCompleted // ignore: cast_nullable_to_non_nullable
as int,mealsPlanned: null == mealsPlanned ? _self.mealsPlanned : mealsPlanned // ignore: cast_nullable_to_non_nullable
as int,mealIdea: freezed == mealIdea ? _self.mealIdea : mealIdea // ignore: cast_nullable_to_non_nullable
as HomeMealIdea?,stockToBuyCount: null == stockToBuyCount ? _self.stockToBuyCount : stockToBuyCount // ignore: cast_nullable_to_non_nullable
as int,stockToBuyKobo: null == stockToBuyKobo ? _self.stockToBuyKobo : stockToBuyKobo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeMealIdeaCopyWith<$Res>? get mealIdea {
    if (_self.mealIdea == null) {
    return null;
  }

  return $HomeMealIdeaCopyWith<$Res>(_self.mealIdea!, (value) {
    return _then(_self.copyWith(mealIdea: value));
  });
}
}

// dart format on
