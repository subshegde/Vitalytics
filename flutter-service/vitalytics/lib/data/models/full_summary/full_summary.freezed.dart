// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'full_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FullSummary {

 String get last_analysis_date; List<String> get disease_history; String get current_status; Map<String, dynamic> get recommendations_snapshot;
/// Create a copy of FullSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FullSummaryCopyWith<FullSummary> get copyWith => _$FullSummaryCopyWithImpl<FullSummary>(this as FullSummary, _$identity);

  /// Serializes this FullSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FullSummary&&(identical(other.last_analysis_date, last_analysis_date) || other.last_analysis_date == last_analysis_date)&&const DeepCollectionEquality().equals(other.disease_history, disease_history)&&(identical(other.current_status, current_status) || other.current_status == current_status)&&const DeepCollectionEquality().equals(other.recommendations_snapshot, recommendations_snapshot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,last_analysis_date,const DeepCollectionEquality().hash(disease_history),current_status,const DeepCollectionEquality().hash(recommendations_snapshot));

@override
String toString() {
  return 'FullSummary(last_analysis_date: $last_analysis_date, disease_history: $disease_history, current_status: $current_status, recommendations_snapshot: $recommendations_snapshot)';
}


}

/// @nodoc
abstract mixin class $FullSummaryCopyWith<$Res>  {
  factory $FullSummaryCopyWith(FullSummary value, $Res Function(FullSummary) _then) = _$FullSummaryCopyWithImpl;
@useResult
$Res call({
 String last_analysis_date, List<String> disease_history, String current_status, Map<String, dynamic> recommendations_snapshot
});




}
/// @nodoc
class _$FullSummaryCopyWithImpl<$Res>
    implements $FullSummaryCopyWith<$Res> {
  _$FullSummaryCopyWithImpl(this._self, this._then);

  final FullSummary _self;
  final $Res Function(FullSummary) _then;

/// Create a copy of FullSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? last_analysis_date = null,Object? disease_history = null,Object? current_status = null,Object? recommendations_snapshot = null,}) {
  return _then(_self.copyWith(
last_analysis_date: null == last_analysis_date ? _self.last_analysis_date : last_analysis_date // ignore: cast_nullable_to_non_nullable
as String,disease_history: null == disease_history ? _self.disease_history : disease_history // ignore: cast_nullable_to_non_nullable
as List<String>,current_status: null == current_status ? _self.current_status : current_status // ignore: cast_nullable_to_non_nullable
as String,recommendations_snapshot: null == recommendations_snapshot ? _self.recommendations_snapshot : recommendations_snapshot // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [FullSummary].
extension FullSummaryPatterns on FullSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FullSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FullSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FullSummary value)  $default,){
final _that = this;
switch (_that) {
case _FullSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FullSummary value)?  $default,){
final _that = this;
switch (_that) {
case _FullSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String last_analysis_date,  List<String> disease_history,  String current_status,  Map<String, dynamic> recommendations_snapshot)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FullSummary() when $default != null:
return $default(_that.last_analysis_date,_that.disease_history,_that.current_status,_that.recommendations_snapshot);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String last_analysis_date,  List<String> disease_history,  String current_status,  Map<String, dynamic> recommendations_snapshot)  $default,) {final _that = this;
switch (_that) {
case _FullSummary():
return $default(_that.last_analysis_date,_that.disease_history,_that.current_status,_that.recommendations_snapshot);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String last_analysis_date,  List<String> disease_history,  String current_status,  Map<String, dynamic> recommendations_snapshot)?  $default,) {final _that = this;
switch (_that) {
case _FullSummary() when $default != null:
return $default(_that.last_analysis_date,_that.disease_history,_that.current_status,_that.recommendations_snapshot);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FullSummary implements FullSummary {
  const _FullSummary({required this.last_analysis_date, required final  List<String> disease_history, required this.current_status, required final  Map<String, dynamic> recommendations_snapshot}): _disease_history = disease_history,_recommendations_snapshot = recommendations_snapshot;
  factory _FullSummary.fromJson(Map<String, dynamic> json) => _$FullSummaryFromJson(json);

@override final  String last_analysis_date;
 final  List<String> _disease_history;
@override List<String> get disease_history {
  if (_disease_history is EqualUnmodifiableListView) return _disease_history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_disease_history);
}

@override final  String current_status;
 final  Map<String, dynamic> _recommendations_snapshot;
@override Map<String, dynamic> get recommendations_snapshot {
  if (_recommendations_snapshot is EqualUnmodifiableMapView) return _recommendations_snapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_recommendations_snapshot);
}


/// Create a copy of FullSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FullSummaryCopyWith<_FullSummary> get copyWith => __$FullSummaryCopyWithImpl<_FullSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FullSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FullSummary&&(identical(other.last_analysis_date, last_analysis_date) || other.last_analysis_date == last_analysis_date)&&const DeepCollectionEquality().equals(other._disease_history, _disease_history)&&(identical(other.current_status, current_status) || other.current_status == current_status)&&const DeepCollectionEquality().equals(other._recommendations_snapshot, _recommendations_snapshot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,last_analysis_date,const DeepCollectionEquality().hash(_disease_history),current_status,const DeepCollectionEquality().hash(_recommendations_snapshot));

@override
String toString() {
  return 'FullSummary(last_analysis_date: $last_analysis_date, disease_history: $disease_history, current_status: $current_status, recommendations_snapshot: $recommendations_snapshot)';
}


}

/// @nodoc
abstract mixin class _$FullSummaryCopyWith<$Res> implements $FullSummaryCopyWith<$Res> {
  factory _$FullSummaryCopyWith(_FullSummary value, $Res Function(_FullSummary) _then) = __$FullSummaryCopyWithImpl;
@override @useResult
$Res call({
 String last_analysis_date, List<String> disease_history, String current_status, Map<String, dynamic> recommendations_snapshot
});




}
/// @nodoc
class __$FullSummaryCopyWithImpl<$Res>
    implements _$FullSummaryCopyWith<$Res> {
  __$FullSummaryCopyWithImpl(this._self, this._then);

  final _FullSummary _self;
  final $Res Function(_FullSummary) _then;

/// Create a copy of FullSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? last_analysis_date = null,Object? disease_history = null,Object? current_status = null,Object? recommendations_snapshot = null,}) {
  return _then(_FullSummary(
last_analysis_date: null == last_analysis_date ? _self.last_analysis_date : last_analysis_date // ignore: cast_nullable_to_non_nullable
as String,disease_history: null == disease_history ? _self._disease_history : disease_history // ignore: cast_nullable_to_non_nullable
as List<String>,current_status: null == current_status ? _self.current_status : current_status // ignore: cast_nullable_to_non_nullable
as String,recommendations_snapshot: null == recommendations_snapshot ? _self._recommendations_snapshot : recommendations_snapshot // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
