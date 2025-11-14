// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suggestion_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SuggestionResult {

 String get suggestion_type; List<Map<String, dynamic>> get items;
/// Create a copy of SuggestionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuggestionResultCopyWith<SuggestionResult> get copyWith => _$SuggestionResultCopyWithImpl<SuggestionResult>(this as SuggestionResult, _$identity);

  /// Serializes this SuggestionResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuggestionResult&&(identical(other.suggestion_type, suggestion_type) || other.suggestion_type == suggestion_type)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,suggestion_type,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'SuggestionResult(suggestion_type: $suggestion_type, items: $items)';
}


}

/// @nodoc
abstract mixin class $SuggestionResultCopyWith<$Res>  {
  factory $SuggestionResultCopyWith(SuggestionResult value, $Res Function(SuggestionResult) _then) = _$SuggestionResultCopyWithImpl;
@useResult
$Res call({
 String suggestion_type, List<Map<String, dynamic>> items
});




}
/// @nodoc
class _$SuggestionResultCopyWithImpl<$Res>
    implements $SuggestionResultCopyWith<$Res> {
  _$SuggestionResultCopyWithImpl(this._self, this._then);

  final SuggestionResult _self;
  final $Res Function(SuggestionResult) _then;

/// Create a copy of SuggestionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? suggestion_type = null,Object? items = null,}) {
  return _then(_self.copyWith(
suggestion_type: null == suggestion_type ? _self.suggestion_type : suggestion_type // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}

}


/// Adds pattern-matching-related methods to [SuggestionResult].
extension SuggestionResultPatterns on SuggestionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuggestionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuggestionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuggestionResult value)  $default,){
final _that = this;
switch (_that) {
case _SuggestionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuggestionResult value)?  $default,){
final _that = this;
switch (_that) {
case _SuggestionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String suggestion_type,  List<Map<String, dynamic>> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuggestionResult() when $default != null:
return $default(_that.suggestion_type,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String suggestion_type,  List<Map<String, dynamic>> items)  $default,) {final _that = this;
switch (_that) {
case _SuggestionResult():
return $default(_that.suggestion_type,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String suggestion_type,  List<Map<String, dynamic>> items)?  $default,) {final _that = this;
switch (_that) {
case _SuggestionResult() when $default != null:
return $default(_that.suggestion_type,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SuggestionResult implements SuggestionResult {
  const _SuggestionResult({required this.suggestion_type, required final  List<Map<String, dynamic>> items}): _items = items;
  factory _SuggestionResult.fromJson(Map<String, dynamic> json) => _$SuggestionResultFromJson(json);

@override final  String suggestion_type;
 final  List<Map<String, dynamic>> _items;
@override List<Map<String, dynamic>> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of SuggestionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuggestionResultCopyWith<_SuggestionResult> get copyWith => __$SuggestionResultCopyWithImpl<_SuggestionResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SuggestionResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuggestionResult&&(identical(other.suggestion_type, suggestion_type) || other.suggestion_type == suggestion_type)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,suggestion_type,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'SuggestionResult(suggestion_type: $suggestion_type, items: $items)';
}


}

/// @nodoc
abstract mixin class _$SuggestionResultCopyWith<$Res> implements $SuggestionResultCopyWith<$Res> {
  factory _$SuggestionResultCopyWith(_SuggestionResult value, $Res Function(_SuggestionResult) _then) = __$SuggestionResultCopyWithImpl;
@override @useResult
$Res call({
 String suggestion_type, List<Map<String, dynamic>> items
});




}
/// @nodoc
class __$SuggestionResultCopyWithImpl<$Res>
    implements _$SuggestionResultCopyWith<$Res> {
  __$SuggestionResultCopyWithImpl(this._self, this._then);

  final _SuggestionResult _self;
  final $Res Function(_SuggestionResult) _then;

/// Create a copy of SuggestionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? suggestion_type = null,Object? items = null,}) {
  return _then(_SuggestionResult(
suggestion_type: null == suggestion_type ? _self.suggestion_type : suggestion_type // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}


}

// dart format on
