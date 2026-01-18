// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'maze_preferences_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MazePreferencesNotifierState {

 int get width; int get height; int get minCheckpoints; int get maxCheckpoints; int get minWalls; int get maxWalls; Color get pathColor;
/// Create a copy of MazePreferencesNotifierState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MazePreferencesNotifierStateCopyWith<MazePreferencesNotifierState> get copyWith => _$MazePreferencesNotifierStateCopyWithImpl<MazePreferencesNotifierState>(this as MazePreferencesNotifierState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MazePreferencesNotifierState&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.minCheckpoints, minCheckpoints) || other.minCheckpoints == minCheckpoints)&&(identical(other.maxCheckpoints, maxCheckpoints) || other.maxCheckpoints == maxCheckpoints)&&(identical(other.minWalls, minWalls) || other.minWalls == minWalls)&&(identical(other.maxWalls, maxWalls) || other.maxWalls == maxWalls)&&(identical(other.pathColor, pathColor) || other.pathColor == pathColor));
}


@override
int get hashCode => Object.hash(runtimeType,width,height,minCheckpoints,maxCheckpoints,minWalls,maxWalls,pathColor);

@override
String toString() {
  return 'MazePreferencesNotifierState(width: $width, height: $height, minCheckpoints: $minCheckpoints, maxCheckpoints: $maxCheckpoints, minWalls: $minWalls, maxWalls: $maxWalls, pathColor: $pathColor)';
}


}

/// @nodoc
abstract mixin class $MazePreferencesNotifierStateCopyWith<$Res>  {
  factory $MazePreferencesNotifierStateCopyWith(MazePreferencesNotifierState value, $Res Function(MazePreferencesNotifierState) _then) = _$MazePreferencesNotifierStateCopyWithImpl;
@useResult
$Res call({
 int width, int height, int minCheckpoints, int maxCheckpoints, int minWalls, int maxWalls, Color pathColor
});




}
/// @nodoc
class _$MazePreferencesNotifierStateCopyWithImpl<$Res>
    implements $MazePreferencesNotifierStateCopyWith<$Res> {
  _$MazePreferencesNotifierStateCopyWithImpl(this._self, this._then);

  final MazePreferencesNotifierState _self;
  final $Res Function(MazePreferencesNotifierState) _then;

/// Create a copy of MazePreferencesNotifierState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? width = null,Object? height = null,Object? minCheckpoints = null,Object? maxCheckpoints = null,Object? minWalls = null,Object? maxWalls = null,Object? pathColor = null,}) {
  return _then(_self.copyWith(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,minCheckpoints: null == minCheckpoints ? _self.minCheckpoints : minCheckpoints // ignore: cast_nullable_to_non_nullable
as int,maxCheckpoints: null == maxCheckpoints ? _self.maxCheckpoints : maxCheckpoints // ignore: cast_nullable_to_non_nullable
as int,minWalls: null == minWalls ? _self.minWalls : minWalls // ignore: cast_nullable_to_non_nullable
as int,maxWalls: null == maxWalls ? _self.maxWalls : maxWalls // ignore: cast_nullable_to_non_nullable
as int,pathColor: null == pathColor ? _self.pathColor : pathColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [MazePreferencesNotifierState].
extension MazePreferencesNotifierStatePatterns on MazePreferencesNotifierState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MazePreferencesNotifierState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MazePreferencesNotifierState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MazePreferencesNotifierState value)  $default,){
final _that = this;
switch (_that) {
case _MazePreferencesNotifierState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MazePreferencesNotifierState value)?  $default,){
final _that = this;
switch (_that) {
case _MazePreferencesNotifierState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int width,  int height,  int minCheckpoints,  int maxCheckpoints,  int minWalls,  int maxWalls,  Color pathColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MazePreferencesNotifierState() when $default != null:
return $default(_that.width,_that.height,_that.minCheckpoints,_that.maxCheckpoints,_that.minWalls,_that.maxWalls,_that.pathColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int width,  int height,  int minCheckpoints,  int maxCheckpoints,  int minWalls,  int maxWalls,  Color pathColor)  $default,) {final _that = this;
switch (_that) {
case _MazePreferencesNotifierState():
return $default(_that.width,_that.height,_that.minCheckpoints,_that.maxCheckpoints,_that.minWalls,_that.maxWalls,_that.pathColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int width,  int height,  int minCheckpoints,  int maxCheckpoints,  int minWalls,  int maxWalls,  Color pathColor)?  $default,) {final _that = this;
switch (_that) {
case _MazePreferencesNotifierState() when $default != null:
return $default(_that.width,_that.height,_that.minCheckpoints,_that.maxCheckpoints,_that.minWalls,_that.maxWalls,_that.pathColor);case _:
  return null;

}
}

}

/// @nodoc


class _MazePreferencesNotifierState extends MazePreferencesNotifierState {
  const _MazePreferencesNotifierState({this.width = 5, this.height = 5, this.minCheckpoints = 3, this.maxCheckpoints = 4, this.minWalls = 0, this.maxWalls = 6, this.pathColor = Colors.red}): super._();
  

@override@JsonKey() final  int width;
@override@JsonKey() final  int height;
@override@JsonKey() final  int minCheckpoints;
@override@JsonKey() final  int maxCheckpoints;
@override@JsonKey() final  int minWalls;
@override@JsonKey() final  int maxWalls;
@override@JsonKey() final  Color pathColor;

/// Create a copy of MazePreferencesNotifierState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MazePreferencesNotifierStateCopyWith<_MazePreferencesNotifierState> get copyWith => __$MazePreferencesNotifierStateCopyWithImpl<_MazePreferencesNotifierState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MazePreferencesNotifierState&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.minCheckpoints, minCheckpoints) || other.minCheckpoints == minCheckpoints)&&(identical(other.maxCheckpoints, maxCheckpoints) || other.maxCheckpoints == maxCheckpoints)&&(identical(other.minWalls, minWalls) || other.minWalls == minWalls)&&(identical(other.maxWalls, maxWalls) || other.maxWalls == maxWalls)&&(identical(other.pathColor, pathColor) || other.pathColor == pathColor));
}


@override
int get hashCode => Object.hash(runtimeType,width,height,minCheckpoints,maxCheckpoints,minWalls,maxWalls,pathColor);

@override
String toString() {
  return 'MazePreferencesNotifierState(width: $width, height: $height, minCheckpoints: $minCheckpoints, maxCheckpoints: $maxCheckpoints, minWalls: $minWalls, maxWalls: $maxWalls, pathColor: $pathColor)';
}


}

/// @nodoc
abstract mixin class _$MazePreferencesNotifierStateCopyWith<$Res> implements $MazePreferencesNotifierStateCopyWith<$Res> {
  factory _$MazePreferencesNotifierStateCopyWith(_MazePreferencesNotifierState value, $Res Function(_MazePreferencesNotifierState) _then) = __$MazePreferencesNotifierStateCopyWithImpl;
@override @useResult
$Res call({
 int width, int height, int minCheckpoints, int maxCheckpoints, int minWalls, int maxWalls, Color pathColor
});




}
/// @nodoc
class __$MazePreferencesNotifierStateCopyWithImpl<$Res>
    implements _$MazePreferencesNotifierStateCopyWith<$Res> {
  __$MazePreferencesNotifierStateCopyWithImpl(this._self, this._then);

  final _MazePreferencesNotifierState _self;
  final $Res Function(_MazePreferencesNotifierState) _then;

/// Create a copy of MazePreferencesNotifierState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? width = null,Object? height = null,Object? minCheckpoints = null,Object? maxCheckpoints = null,Object? minWalls = null,Object? maxWalls = null,Object? pathColor = null,}) {
  return _then(_MazePreferencesNotifierState(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,minCheckpoints: null == minCheckpoints ? _self.minCheckpoints : minCheckpoints // ignore: cast_nullable_to_non_nullable
as int,maxCheckpoints: null == maxCheckpoints ? _self.maxCheckpoints : maxCheckpoints // ignore: cast_nullable_to_non_nullable
as int,minWalls: null == minWalls ? _self.minWalls : minWalls // ignore: cast_nullable_to_non_nullable
as int,maxWalls: null == maxWalls ? _self.maxWalls : maxWalls // ignore: cast_nullable_to_non_nullable
as int,pathColor: null == pathColor ? _self.pathColor : pathColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
