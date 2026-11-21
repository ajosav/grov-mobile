// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeState()';
}


}

/// @nodoc
class $HomeStateCopyWith<$Res>  {
$HomeStateCopyWith(HomeState _, $Res Function(HomeState) __);
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeLoading value)?  loading,TResult Function( HomeData value)?  data,TResult Function( HomeFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeLoading() when loading != null:
return loading(_that);case HomeData() when data != null:
return data(_that);case HomeFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeLoading value)  loading,required TResult Function( HomeData value)  data,required TResult Function( HomeFailure value)  failure,}){
final _that = this;
switch (_that) {
case HomeLoading():
return loading(_that);case HomeData():
return data(_that);case HomeFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeLoading value)?  loading,TResult? Function( HomeData value)?  data,TResult? Function( HomeFailure value)?  failure,}){
final _that = this;
switch (_that) {
case HomeLoading() when loading != null:
return loading(_that);case HomeData() when data != null:
return data(_that);case HomeFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( HomeSummary summary,  GreetingPeriod period)?  data,TResult Function()?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeLoading() when loading != null:
return loading();case HomeData() when data != null:
return data(_that.summary,_that.period);case HomeFailure() when failure != null:
return failure();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( HomeSummary summary,  GreetingPeriod period)  data,required TResult Function()  failure,}) {final _that = this;
switch (_that) {
case HomeLoading():
return loading();case HomeData():
return data(_that.summary,_that.period);case HomeFailure():
return failure();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( HomeSummary summary,  GreetingPeriod period)?  data,TResult? Function()?  failure,}) {final _that = this;
switch (_that) {
case HomeLoading() when loading != null:
return loading();case HomeData() when data != null:
return data(_that.summary,_that.period);case HomeFailure() when failure != null:
return failure();case _:
  return null;

}
}

}

/// @nodoc


class HomeLoading implements HomeState {
  const HomeLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeState.loading()';
}


}




/// @nodoc


class HomeData implements HomeState {
  const HomeData({required this.summary, required this.period});
  

 final  HomeSummary summary;
 final  GreetingPeriod period;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeDataCopyWith<HomeData> get copyWith => _$HomeDataCopyWithImpl<HomeData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeData&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.period, period) || other.period == period));
}


@override
int get hashCode {
    return Object.hash(runtimeType,summary,period);
}

@override
String toString() {
    return 'HomeState.data(summary: $summary, period: $period)';
}


}

/// @nodoc
abstract mixin class $HomeDataCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeDataCopyWith(HomeData value, $Res Function(HomeData) _then) = _$HomeDataCopyWithImpl;
@useResult
$Res call({
 HomeSummary summary, GreetingPeriod period
});


$HomeSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$HomeDataCopyWithImpl<$Res>
    implements $HomeDataCopyWith<$Res> {
  _$HomeDataCopyWithImpl(this._self, this._then);

  final HomeData _self;
  final $Res Function(HomeData) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? period = null,}) {
  return _then(HomeData(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as HomeSummary,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as GreetingPeriod,
  ));
}

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeSummaryCopyWith<$Res> get summary {
  
  return $HomeSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc


class HomeFailure implements HomeState {
  const HomeFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeState.failure()';
}


}




// dart format on
