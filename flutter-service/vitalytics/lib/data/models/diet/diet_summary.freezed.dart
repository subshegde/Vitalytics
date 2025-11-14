// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diet_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DietSummaryResponse {

 String get title; String get summary_text; List<Map<String, dynamic>> get suggested_meals;
/// Create a copy of DietSummaryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DietSummaryResponseCopyWith<DietSummaryResponse> get copyWith => _$DietSummaryResponseCopyWithImpl<DietSummaryResponse>(this as DietSummaryResponse, _$identity);

  /// Serializes this DietSummaryResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DietSummaryResponse&&(identical(other.title, title) || other.title == title)&&(identical(other.summary_text, summary_text) || other.summary_text == summary_text)&&const DeepCollectionEquality().equals(other.suggested_meals, suggested_meals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,summary_text,const DeepCollectionEquality().hash(suggested_meals));

@override
String toString() {
  return 'DietSummaryResponse(title: $title, summary_text: $summary_text, suggested_meals: $suggested_meals)';
}


}

/// @nodoc
abstract mixin class $DietSummaryResponseCopyWith<$Res>  {
  factory $DietSummaryResponseCopyWith(DietSummaryResponse value, $Res Function(DietSummaryResponse) _then) = _$DietSummaryResponseCopyWithImpl;
@useResult
$Res call({
 String title, String summary_text, List<Map<String, dynamic>> suggested_meals
});




}
/// @nodoc
class _$DietSummaryResponseCopyWithImpl<$Res>
    implements $DietSummaryResponseCopyWith<$Res> {
  _$DietSummaryResponseCopyWithImpl(this._self, this._then);

  final DietSummaryResponse _self;
  final $Res Function(DietSummaryResponse) _then;

/// Create a copy of DietSummaryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? summary_text = null,Object? suggested_meals = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,summary_text: null == summary_text ? _self.summary_text : summary_text // ignore: cast_nullable_to_non_nullable
as String,suggested_meals: null == suggested_meals ? _self.suggested_meals : suggested_meals // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}

}


/// Adds pattern-matching-related methods to [DietSummaryResponse].
extension DietSummaryResponsePatterns on DietSummaryResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DietSummaryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DietSummaryResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DietSummaryResponse value)  $default,){
final _that = this;
switch (_that) {
case _DietSummaryResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DietSummaryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DietSummaryResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String summary_text,  List<Map<String, dynamic>> suggested_meals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DietSummaryResponse() when $default != null:
return $default(_that.title,_that.summary_text,_that.suggested_meals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String summary_text,  List<Map<String, dynamic>> suggested_meals)  $default,) {final _that = this;
switch (_that) {
case _DietSummaryResponse():
return $default(_that.title,_that.summary_text,_that.suggested_meals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String summary_text,  List<Map<String, dynamic>> suggested_meals)?  $default,) {final _that = this;
switch (_that) {
case _DietSummaryResponse() when $default != null:
return $default(_that.title,_that.summary_text,_that.suggested_meals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DietSummaryResponse implements DietSummaryResponse {
  const _DietSummaryResponse({required this.title, required this.summary_text, required final  List<Map<String, dynamic>> suggested_meals}): _suggested_meals = suggested_meals;
  factory _DietSummaryResponse.fromJson(Map<String, dynamic> json) => _$DietSummaryResponseFromJson(json);

@override final  String title;
@override final  String summary_text;
 final  List<Map<String, dynamic>> _suggested_meals;
@override List<Map<String, dynamic>> get suggested_meals {
  if (_suggested_meals is EqualUnmodifiableListView) return _suggested_meals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggested_meals);
}


/// Create a copy of DietSummaryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DietSummaryResponseCopyWith<_DietSummaryResponse> get copyWith => __$DietSummaryResponseCopyWithImpl<_DietSummaryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DietSummaryResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DietSummaryResponse&&(identical(other.title, title) || other.title == title)&&(identical(other.summary_text, summary_text) || other.summary_text == summary_text)&&const DeepCollectionEquality().equals(other._suggested_meals, _suggested_meals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,summary_text,const DeepCollectionEquality().hash(_suggested_meals));

@override
String toString() {
  return 'DietSummaryResponse(title: $title, summary_text: $summary_text, suggested_meals: $suggested_meals)';
}


}

/// @nodoc
abstract mixin class _$DietSummaryResponseCopyWith<$Res> implements $DietSummaryResponseCopyWith<$Res> {
  factory _$DietSummaryResponseCopyWith(_DietSummaryResponse value, $Res Function(_DietSummaryResponse) _then) = __$DietSummaryResponseCopyWithImpl;
@override @useResult
$Res call({
 String title, String summary_text, List<Map<String, dynamic>> suggested_meals
});




}
/// @nodoc
class __$DietSummaryResponseCopyWithImpl<$Res>
    implements _$DietSummaryResponseCopyWith<$Res> {
  __$DietSummaryResponseCopyWithImpl(this._self, this._then);

  final _DietSummaryResponse _self;
  final $Res Function(_DietSummaryResponse) _then;

/// Create a copy of DietSummaryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? summary_text = null,Object? suggested_meals = null,}) {
  return _then(_DietSummaryResponse(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,summary_text: null == summary_text ? _self.summary_text : summary_text // ignore: cast_nullable_to_non_nullable
as String,suggested_meals: null == suggested_meals ? _self._suggested_meals : suggested_meals // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}


}

// dart format on
