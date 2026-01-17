// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'maze_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MazeNotifierState {

 List<(int, int)> get checkpoints; List<(int, int)> get path; int get n; int get m; bool get solved;
/// Create a copy of MazeNotifierState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MazeNotifierStateCopyWith<MazeNotifierState> get copyWith => _$MazeNotifierStateCopyWithImpl<MazeNotifierState>(this as MazeNotifierState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MazeNotifierState&&const DeepCollectionEquality().equals(other.checkpoints, checkpoints)&&const DeepCollectionEquality().equals(other.path, path)&&(identical(other.n, n) || other.n == n)&&(identical(other.m, m) || other.m == m)&&(identical(other.solved, solved) || other.solved == solved));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(checkpoints),const DeepCollectionEquality().hash(path),n,m,solved);

@override
String toString() {
  return 'MazeNotifierState(checkpoints: $checkpoints, path: $path, n: $n, m: $m, solved: $solved)';
}


}

/// @nodoc
abstract mixin class $MazeNotifierStateCopyWith<$Res>  {
  factory $MazeNotifierStateCopyWith(MazeNotifierState value, $Res Function(MazeNotifierState) _then) = _$MazeNotifierStateCopyWithImpl;
@useResult
$Res call({
 List<(int, int)> checkpoints, List<(int, int)> path, int n, int m, bool solved
});




}
/// @nodoc
class _$MazeNotifierStateCopyWithImpl<$Res>
    implements $MazeNotifierStateCopyWith<$Res> {
  _$MazeNotifierStateCopyWithImpl(this._self, this._then);

  final MazeNotifierState _self;
  final $Res Function(MazeNotifierState) _then;

/// Create a copy of MazeNotifierState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? checkpoints = null,Object? path = null,Object? n = null,Object? m = null,Object? solved = null,}) {
  return _then(_self.copyWith(
checkpoints: null == checkpoints ? _self.checkpoints : checkpoints // ignore: cast_nullable_to_non_nullable
as List<(int, int)>,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as List<(int, int)>,n: null == n ? _self.n : n // ignore: cast_nullable_to_non_nullable
as int,m: null == m ? _self.m : m // ignore: cast_nullable_to_non_nullable
as int,solved: null == solved ? _self.solved : solved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MazeNotifierState].
extension MazeNotifierStatePatterns on MazeNotifierState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MazeNotifierState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MazeNotifierState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MazeNotifierState value)  $default,){
final _that = this;
switch (_that) {
case _MazeNotifierState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MazeNotifierState value)?  $default,){
final _that = this;
switch (_that) {
case _MazeNotifierState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<(int, int)> checkpoints,  List<(int, int)> path,  int n,  int m,  bool solved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MazeNotifierState() when $default != null:
return $default(_that.checkpoints,_that.path,_that.n,_that.m,_that.solved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<(int, int)> checkpoints,  List<(int, int)> path,  int n,  int m,  bool solved)  $default,) {final _that = this;
switch (_that) {
case _MazeNotifierState():
return $default(_that.checkpoints,_that.path,_that.n,_that.m,_that.solved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<(int, int)> checkpoints,  List<(int, int)> path,  int n,  int m,  bool solved)?  $default,) {final _that = this;
switch (_that) {
case _MazeNotifierState() when $default != null:
return $default(_that.checkpoints,_that.path,_that.n,_that.m,_that.solved);case _:
  return null;

}
}

}

/// @nodoc


class _MazeNotifierState extends MazeNotifierState {
  const _MazeNotifierState({final  List<(int, int)> checkpoints = const [], final  List<(int, int)> path = const [], this.n = 5, this.m = 5, this.solved = false}): _checkpoints = checkpoints,_path = path,super._();
  

 final  List<(int, int)> _checkpoints;
@override@JsonKey() List<(int, int)> get checkpoints {
  if (_checkpoints is EqualUnmodifiableListView) return _checkpoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checkpoints);
}

 final  List<(int, int)> _path;
@override@JsonKey() List<(int, int)> get path {
  if (_path is EqualUnmodifiableListView) return _path;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_path);
}

@override@JsonKey() final  int n;
@override@JsonKey() final  int m;
@override@JsonKey() final  bool solved;

/// Create a copy of MazeNotifierState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MazeNotifierStateCopyWith<_MazeNotifierState> get copyWith => __$MazeNotifierStateCopyWithImpl<_MazeNotifierState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MazeNotifierState&&const DeepCollectionEquality().equals(other._checkpoints, _checkpoints)&&const DeepCollectionEquality().equals(other._path, _path)&&(identical(other.n, n) || other.n == n)&&(identical(other.m, m) || other.m == m)&&(identical(other.solved, solved) || other.solved == solved));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_checkpoints),const DeepCollectionEquality().hash(_path),n,m,solved);

@override
String toString() {
  return 'MazeNotifierState(checkpoints: $checkpoints, path: $path, n: $n, m: $m, solved: $solved)';
}


}

/// @nodoc
abstract mixin class _$MazeNotifierStateCopyWith<$Res> implements $MazeNotifierStateCopyWith<$Res> {
  factory _$MazeNotifierStateCopyWith(_MazeNotifierState value, $Res Function(_MazeNotifierState) _then) = __$MazeNotifierStateCopyWithImpl;
@override @useResult
$Res call({
 List<(int, int)> checkpoints, List<(int, int)> path, int n, int m, bool solved
});




}
/// @nodoc
class __$MazeNotifierStateCopyWithImpl<$Res>
    implements _$MazeNotifierStateCopyWith<$Res> {
  __$MazeNotifierStateCopyWithImpl(this._self, this._then);

  final _MazeNotifierState _self;
  final $Res Function(_MazeNotifierState) _then;

/// Create a copy of MazeNotifierState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? checkpoints = null,Object? path = null,Object? n = null,Object? m = null,Object? solved = null,}) {
  return _then(_MazeNotifierState(
checkpoints: null == checkpoints ? _self._checkpoints : checkpoints // ignore: cast_nullable_to_non_nullable
as List<(int, int)>,path: null == path ? _self._path : path // ignore: cast_nullable_to_non_nullable
as List<(int, int)>,n: null == n ? _self.n : n // ignore: cast_nullable_to_non_nullable
as int,m: null == m ? _self.m : m // ignore: cast_nullable_to_non_nullable
as int,solved: null == solved ? _self.solved : solved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
