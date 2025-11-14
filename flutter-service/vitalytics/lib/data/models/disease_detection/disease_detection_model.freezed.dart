// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'disease_detection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiseaseDetectionModel {

 String get detected_disease; double get confidence_score; String get description; List<String> get precautionary_steps;
/// Create a copy of DiseaseDetectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiseaseDetectionModelCopyWith<DiseaseDetectionModel> get copyWith => _$DiseaseDetectionModelCopyWithImpl<DiseaseDetectionModel>(this as DiseaseDetectionModel, _$identity);

  /// Serializes this DiseaseDetectionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiseaseDetectionModel&&(identical(other.detected_disease, detected_disease) || other.detected_disease == detected_disease)&&(identical(other.confidence_score, confidence_score) || other.confidence_score == confidence_score)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.precautionary_steps, precautionary_steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detected_disease,confidence_score,description,const DeepCollectionEquality().hash(precautionary_steps));

@override
String toString() {
  return 'DiseaseDetectionModel(detected_disease: $detected_disease, confidence_score: $confidence_score, description: $description, precautionary_steps: $precautionary_steps)';
}


}

/// @nodoc
abstract mixin class $DiseaseDetectionModelCopyWith<$Res>  {
  factory $DiseaseDetectionModelCopyWith(DiseaseDetectionModel value, $Res Function(DiseaseDetectionModel) _then) = _$DiseaseDetectionModelCopyWithImpl;
@useResult
$Res call({
 String detected_disease, double confidence_score, String description, List<String> precautionary_steps
});




}
/// @nodoc
class _$DiseaseDetectionModelCopyWithImpl<$Res>
    implements $DiseaseDetectionModelCopyWith<$Res> {
  _$DiseaseDetectionModelCopyWithImpl(this._self, this._then);

  final DiseaseDetectionModel _self;
  final $Res Function(DiseaseDetectionModel) _then;

/// Create a copy of DiseaseDetectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? detected_disease = null,Object? confidence_score = null,Object? description = null,Object? precautionary_steps = null,}) {
  return _then(_self.copyWith(
detected_disease: null == detected_disease ? _self.detected_disease : detected_disease // ignore: cast_nullable_to_non_nullable
as String,confidence_score: null == confidence_score ? _self.confidence_score : confidence_score // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,precautionary_steps: null == precautionary_steps ? _self.precautionary_steps : precautionary_steps // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DiseaseDetectionModel].
extension DiseaseDetectionModelPatterns on DiseaseDetectionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiseaseDetectionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiseaseDetectionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiseaseDetectionModel value)  $default,){
final _that = this;
switch (_that) {
case _DiseaseDetectionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiseaseDetectionModel value)?  $default,){
final _that = this;
switch (_that) {
case _DiseaseDetectionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String detected_disease,  double confidence_score,  String description,  List<String> precautionary_steps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiseaseDetectionModel() when $default != null:
return $default(_that.detected_disease,_that.confidence_score,_that.description,_that.precautionary_steps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String detected_disease,  double confidence_score,  String description,  List<String> precautionary_steps)  $default,) {final _that = this;
switch (_that) {
case _DiseaseDetectionModel():
return $default(_that.detected_disease,_that.confidence_score,_that.description,_that.precautionary_steps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String detected_disease,  double confidence_score,  String description,  List<String> precautionary_steps)?  $default,) {final _that = this;
switch (_that) {
case _DiseaseDetectionModel() when $default != null:
return $default(_that.detected_disease,_that.confidence_score,_that.description,_that.precautionary_steps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiseaseDetectionModel implements DiseaseDetectionModel {
  const _DiseaseDetectionModel({required this.detected_disease, required this.confidence_score, required this.description, required final  List<String> precautionary_steps}): _precautionary_steps = precautionary_steps;
  factory _DiseaseDetectionModel.fromJson(Map<String, dynamic> json) => _$DiseaseDetectionModelFromJson(json);

@override final  String detected_disease;
@override final  double confidence_score;
@override final  String description;
 final  List<String> _precautionary_steps;
@override List<String> get precautionary_steps {
  if (_precautionary_steps is EqualUnmodifiableListView) return _precautionary_steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_precautionary_steps);
}


/// Create a copy of DiseaseDetectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiseaseDetectionModelCopyWith<_DiseaseDetectionModel> get copyWith => __$DiseaseDetectionModelCopyWithImpl<_DiseaseDetectionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiseaseDetectionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiseaseDetectionModel&&(identical(other.detected_disease, detected_disease) || other.detected_disease == detected_disease)&&(identical(other.confidence_score, confidence_score) || other.confidence_score == confidence_score)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._precautionary_steps, _precautionary_steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detected_disease,confidence_score,description,const DeepCollectionEquality().hash(_precautionary_steps));

@override
String toString() {
  return 'DiseaseDetectionModel(detected_disease: $detected_disease, confidence_score: $confidence_score, description: $description, precautionary_steps: $precautionary_steps)';
}


}

/// @nodoc
abstract mixin class _$DiseaseDetectionModelCopyWith<$Res> implements $DiseaseDetectionModelCopyWith<$Res> {
  factory _$DiseaseDetectionModelCopyWith(_DiseaseDetectionModel value, $Res Function(_DiseaseDetectionModel) _then) = __$DiseaseDetectionModelCopyWithImpl;
@override @useResult
$Res call({
 String detected_disease, double confidence_score, String description, List<String> precautionary_steps
});




}
/// @nodoc
class __$DiseaseDetectionModelCopyWithImpl<$Res>
    implements _$DiseaseDetectionModelCopyWith<$Res> {
  __$DiseaseDetectionModelCopyWithImpl(this._self, this._then);

  final _DiseaseDetectionModel _self;
  final $Res Function(_DiseaseDetectionModel) _then;

/// Create a copy of DiseaseDetectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? detected_disease = null,Object? confidence_score = null,Object? description = null,Object? precautionary_steps = null,}) {
  return _then(_DiseaseDetectionModel(
detected_disease: null == detected_disease ? _self.detected_disease : detected_disease // ignore: cast_nullable_to_non_nullable
as String,confidence_score: null == confidence_score ? _self.confidence_score : confidence_score // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,precautionary_steps: null == precautionary_steps ? _self._precautionary_steps : precautionary_steps // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
