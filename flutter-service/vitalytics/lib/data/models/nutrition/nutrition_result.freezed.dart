// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nutrition_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NutritionResult {

 String get name; String get type; String get disease_type; String get query;
/// Create a copy of NutritionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NutritionResultCopyWith<NutritionResult> get copyWith => _$NutritionResultCopyWithImpl<NutritionResult>(this as NutritionResult, _$identity);

  /// Serializes this NutritionResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NutritionResult&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.disease_type, disease_type) || other.disease_type == disease_type)&&(identical(other.query, query) || other.query == query));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,type,disease_type,query);

@override
String toString() {
  return 'NutritionResult(name: $name, type: $type, disease_type: $disease_type, query: $query)';
}


}

/// @nodoc
abstract mixin class $NutritionResultCopyWith<$Res>  {
  factory $NutritionResultCopyWith(NutritionResult value, $Res Function(NutritionResult) _then) = _$NutritionResultCopyWithImpl;
@useResult
$Res call({
 String name, String type, String disease_type, String query
});




}
/// @nodoc
class _$NutritionResultCopyWithImpl<$Res>
    implements $NutritionResultCopyWith<$Res> {
  _$NutritionResultCopyWithImpl(this._self, this._then);

  final NutritionResult _self;
  final $Res Function(NutritionResult) _then;

/// Create a copy of NutritionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? type = null,Object? disease_type = null,Object? query = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,disease_type: null == disease_type ? _self.disease_type : disease_type // ignore: cast_nullable_to_non_nullable
as String,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NutritionResult].
extension NutritionResultPatterns on NutritionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NutritionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NutritionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NutritionResult value)  $default,){
final _that = this;
switch (_that) {
case _NutritionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NutritionResult value)?  $default,){
final _that = this;
switch (_that) {
case _NutritionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String type,  String disease_type,  String query)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NutritionResult() when $default != null:
return $default(_that.name,_that.type,_that.disease_type,_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String type,  String disease_type,  String query)  $default,) {final _that = this;
switch (_that) {
case _NutritionResult():
return $default(_that.name,_that.type,_that.disease_type,_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String type,  String disease_type,  String query)?  $default,) {final _that = this;
switch (_that) {
case _NutritionResult() when $default != null:
return $default(_that.name,_that.type,_that.disease_type,_that.query);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NutritionResult implements NutritionResult {
  const _NutritionResult({required this.name, required this.type, required this.disease_type, required this.query});
  factory _NutritionResult.fromJson(Map<String, dynamic> json) => _$NutritionResultFromJson(json);

@override final  String name;
@override final  String type;
@override final  String disease_type;
@override final  String query;

/// Create a copy of NutritionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NutritionResultCopyWith<_NutritionResult> get copyWith => __$NutritionResultCopyWithImpl<_NutritionResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NutritionResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NutritionResult&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.disease_type, disease_type) || other.disease_type == disease_type)&&(identical(other.query, query) || other.query == query));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,type,disease_type,query);

@override
String toString() {
  return 'NutritionResult(name: $name, type: $type, disease_type: $disease_type, query: $query)';
}


}

/// @nodoc
abstract mixin class _$NutritionResultCopyWith<$Res> implements $NutritionResultCopyWith<$Res> {
  factory _$NutritionResultCopyWith(_NutritionResult value, $Res Function(_NutritionResult) _then) = __$NutritionResultCopyWithImpl;
@override @useResult
$Res call({
 String name, String type, String disease_type, String query
});




}
/// @nodoc
class __$NutritionResultCopyWithImpl<$Res>
    implements _$NutritionResultCopyWith<$Res> {
  __$NutritionResultCopyWithImpl(this._self, this._then);

  final _NutritionResult _self;
  final $Res Function(_NutritionResult) _then;

/// Create a copy of NutritionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? type = null,Object? disease_type = null,Object? query = null,}) {
  return _then(_NutritionResult(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,disease_type: null == disease_type ? _self.disease_type : disease_type // ignore: cast_nullable_to_non_nullable
as String,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
