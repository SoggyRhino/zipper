import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zipper/utils/point_utils.dart';
import 'package:zipper/utils/edge.dart';
import 'package:zipper/utils/moves.dart';

part 'maze_preferences_notifier.freezed.dart';

part 'maze_preferences_notifier.g.dart';

@freezed
abstract class MazePreferencesNotifierState
    with _$MazePreferencesNotifierState {
  static final Random random = Random();

  const MazePreferencesNotifierState._();

  const factory MazePreferencesNotifierState({
    @Default(5) int width,
    @Default(5) int height,
    @Default(3) int minCheckpoints,
    @Default(4) int maxCheckpoints,
    @Default(0) int minWalls,
    @Default(6) int maxWalls,
    @Default(Colors.red) Color pathColor,
  }) = _MazePreferencesNotifierState;

  int get widthFloor => 3;

  int get heightFloor => 3;

  int get widthCeil => 9;

  int get heightCeil => 15;

  int get checkPointFloor => 2;

  int get checkPointCeil => max(width * height ~/ 6, 3);

  int calcCheckPointCeil(int width, int height) {
    return max(width * height ~/ 6, 3);
  }

  int get wallFloor => 0;

  int get wallCeil => max(1, ((2 * width * height) - width - height) ~/ 6);

  int calcWallCeil(int width, int height) {
    return max(1, ((2 * width * height) - width - height) ~/ 6);
  }

  int randomCheckPoints() {
    return maxCheckpoints == minCheckpoints
        ? maxCheckpoints
        : random.nextInt(maxCheckpoints - minCheckpoints) + minCheckpoints;
  }

  int randomWalls() {
    return maxWalls == minWalls
        ? maxWalls
        : random.nextInt(maxWalls - minWalls) + minWalls;
  }
}

@Riverpod(keepAlive: true)
class MazePreferencesNotifier extends _$MazePreferencesNotifier {
  @override
  MazePreferencesNotifierState build() {
    return MazePreferencesNotifierState();
  }

  void set({
    int? width,
    int? height,
    int? minCheckpoints,
    int? maxCheckpoints,
    int? minWalls,
    int? maxWalls,
    Color? pathColor,
  }) {
    final newWidth = width ?? state.width;
    final newHeight = height ?? state.height;

    int nextMaxCP = min(
      maxCheckpoints ?? state.maxCheckpoints,
      state.calcCheckPointCeil(newWidth, newHeight),
    );

    int nextMinCP = clampInt(
      minCheckpoints ?? state.minCheckpoints,
      state.checkPointFloor,
      nextMaxCP,
    );

    int nextMaxWalls = min(
      maxWalls ?? state.maxWalls,
      state.calcWallCeil(newWidth, newHeight),
    );

    int nextMinWalls = clampInt(
      minWalls ?? state.minWalls,
      state.wallFloor,
      nextMaxWalls,
    );

    state = state.copyWith(
      width: newWidth,
      height: newHeight,
      minCheckpoints: nextMinCP,
      maxCheckpoints: nextMaxCP,
      minWalls: nextMinWalls,
      maxWalls: nextMaxWalls,
      pathColor: pathColor ?? state.pathColor,
    );
  }

  // Helper to keep code clean
  int clampInt(int value, int low, int high) {
    if (value < low) return low;
    if (value > high) return high;
    return value;
  }

  void reset() {
    state = MazePreferencesNotifierState();
  }
}
