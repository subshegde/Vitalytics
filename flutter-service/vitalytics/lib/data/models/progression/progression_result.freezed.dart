// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progression_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProgressionResult {

 String get analysis_date; String get status; String get change_description; String get suggested_adjustment;
/// Create a copy of ProgressionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressionResultCopyWith<ProgressionResult> get copyWith => _$ProgressionResultCopyWithImpl<ProgressionResult>(this as ProgressionResult, _$identity);

  /// Serializes this ProgressionResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressionResult&&(identical(other.analysis_date, analysis_date) || other.analysis_date == analysis_date)&&(identical(other.status, status) || other.status == status)&&(identical(other.change_description, change_description) || other.change_description == change_description)&&(identical(other.suggested_adjustment, suggested_adjustment) || other.suggested_adjustment == suggested_adjustment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,analysis_date,status,change_description,suggested_adjustment);

@override
String toString() {
  return 'ProgressionResult(analysis_date: $analysis_date, status: $status, change_description: $change_description, suggested_adjustment: $suggested_adjustment)';
}


}

/// @nodoc
abstract mixin class $ProgressionResultCopyWith<$Res>  {
  factory $ProgressionResultCopyWith(ProgressionResult value, $Res Function(ProgressionResult) _then) = _$ProgressionResultCopyWithImpl;
@useResult
$Res call({
 String analysis_date, String status, String change_description, String suggested_adjustment
});




}
/// @nodoc
class _$ProgressionResultCopyWithImpl<$Res>
    implements $ProgressionResultCopyWith<$Res> {
  _$ProgressionResultCopyWithImpl(this._self, this._then);

  final ProgressionResult _self;
  final $Res Function(ProgressionResult) _then;

/// Create a copy of ProgressionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? analysis_date = null,Object? status = null,Object? change_description = null,Object? suggested_adjustment = null,}) {
  return _then(_self.copyWith(
analysis_date: null == analysis_date ? _self.analysis_date : analysis_date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,change_description: null == change_description ? _self.change_description : change_description // ignore: cast_nullable_to_non_nullable
as String,suggested_adjustment: null == suggested_adjustment ? _self.suggested_adjustment : suggested_adjustment // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgressionResult].
extension ProgressionResultPatterns on ProgressionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgressionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgressionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgressionResult value)  $default,){
final _that = this;
switch (_that) {
case _ProgressionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgressionResult value)?  $default,){
final _that = this;
switch (_that) {
case _ProgressionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String analysis_date,  String status,  String change_description,  String suggested_adjustment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressionResult() when $default != null:
return $default(_that.analysis_date,_that.status,_that.change_description,_that.suggested_adjustment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String analysis_date,  String status,  String change_description,  String suggested_adjustment)  $default,) {final _that = this;
switch (_that) {
case _ProgressionResult():
return $default(_that.analysis_date,_that.status,_that.change_description,_that.suggested_adjustment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String analysis_date,  String status,  String change_description,  String suggested_adjustment)?  $default,) {final _that = this;
switch (_that) {
case _ProgressionResult() when $default != null:
return $default(_that.analysis_date,_that.status,_that.change_description,_that.suggested_adjustment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgressionResult implements ProgressionResult {
  const _ProgressionResult({required this.analysis_date, required this.status, required this.change_description, required this.suggested_adjustment});
  factory _ProgressionResult.fromJson(Map<String, dynamic> json) => _$ProgressionResultFromJson(json);

@override final  String analysis_date;
@override final  String status;
@override final  String change_description;
@override final  String suggested_adjustment;

/// Create a copy of ProgressionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressionResultCopyWith<_ProgressionResult> get copyWith => __$ProgressionResultCopyWithImpl<_ProgressionResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgressionResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressionResult&&(identical(other.analysis_date, analysis_date) || other.analysis_date == analysis_date)&&(identical(other.status, status) || other.status == status)&&(identical(other.change_description, change_description) || other.change_description == change_description)&&(identical(other.suggested_adjustment, suggested_adjustment) || other.suggested_adjustment == suggested_adjustment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,analysis_date,status,change_description,suggested_adjustment);

@override
String toString() {
  return 'ProgressionResult(analysis_date: $analysis_date, status: $status, change_description: $change_description, suggested_adjustment: $suggested_adjustment)';
}


}

/// @nodoc
abstract mixin class _$ProgressionResultCopyWith<$Res> implements $ProgressionResultCopyWith<$Res> {
  factory _$ProgressionResultCopyWith(_ProgressionResult value, $Res Function(_ProgressionResult) _then) = __$ProgressionResultCopyWithImpl;
@override @useResult
$Res call({
 String analysis_date, String status, String change_description, String suggested_adjustment
});




}
/// @nodoc
class __$ProgressionResultCopyWithImpl<$Res>
    implements _$ProgressionResultCopyWith<$Res> {
  __$ProgressionResultCopyWithImpl(this._self, this._then);

  final _ProgressionResult _self;
  final $Res Function(_ProgressionResult) _then;

/// Create a copy of ProgressionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? analysis_date = null,Object? status = null,Object? change_description = null,Object? suggested_adjustment = null,}) {
  return _then(_ProgressionResult(
analysis_date: null == analysis_date ? _self.analysis_date : analysis_date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,change_description: null == change_description ? _self.change_description : change_description // ignore: cast_nullable_to_non_nullable
as String,suggested_adjustment: null == suggested_adjustment ? _self.suggested_adjustment : suggested_adjustment // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
