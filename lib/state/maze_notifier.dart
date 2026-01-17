import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zipper/utils/point_utils.dart';
import 'package:zipper/utils/edge.dart';
import 'package:zipper/utils/moves.dart';

part 'maze_notifier.freezed.dart';

part 'maze_notifier.g.dart';

@freezed
abstract class MazeNotifierState with _$MazeNotifierState {
  const MazeNotifierState._();

  const factory MazeNotifierState({
    @Default([]) List<(int, int)> checkpoints,
    @Default([]) List<(int, int)> path,
    @Default(5) int n,
    @Default(5) int m,
    @Default(false) bool solved,
  }) = _MazeNotifierState;

  bool isEmpty((int, int) position) => !path.contains(position);

  bool isSelected((int, int) position) => path.contains(position);

  int getCheckPoint((int, int) point) => checkpoints.indexOf(point);

  (Edge?, Edge?) getEdges((int, int) position) {
    final pathIdx = path.indexOf(position);

    Edge? startEdge;
    Edge? endEdge;

    if (pathIdx != -1) {
      if (pathIdx > 0) {
        startEdge = _getEdge(position, path[pathIdx - 1]);
      }
      if (pathIdx < path.length - 1) {
        endEdge = _getEdge(position, path[pathIdx + 1]);
      }
    }
    return (startEdge, endEdge);
  }

  Edge? _getEdge((int, int) current, (int, int) neighbor) {
    final dx = neighbor.$1 - current.$1;
    final dy = neighbor.$2 - current.$2;

    return switch ((dx, dy)) {
      (-1, 0) => Edge.left,
      (1, 0) => Edge.right,
      (0, -1) => Edge.top,
      (0, 1) => Edge.bottom,
      _ => null,
    };
  }

  bool isWin() {
    if (path.length != n * m) return false;
    if (checkpoints.length < 2) return true;

    int i = 0;
    for ((int, int) pos in path) {
      if (i >= checkpoints.length) break;
      if (pos == checkpoints[i]) {
        i++;
      }
    }
    return i == checkpoints.length && path.last == checkpoints.last;
  }
}

@Riverpod(keepAlive: true)
class MazeNotifier extends _$MazeNotifier {
  @override
  MazeNotifierState build() {
    return MazeNotifierState();
  }

  void set({
    required List<(int, int)> checkpoints,
    required int n,
    required int m,
  }) async {
    assert(checkpoints.length >= 2, [
      'checkpoints must have at least 2 points',
    ]);
    assert(n > 0 && m > 0, ['n and m must be greater than 0']);

    state = state.copyWith(
      checkpoints: checkpoints,
      n: n,
      m: m,
      path: checkpoints.isNotEmpty ? [checkpoints[0]] : [],
      solved: false,
    );
  }

  // remove all positions from path after position
  void deselectAfter((int, int) position) {
    int index = state.path.indexOf(position);
    assert(index != -1, ['position must already be selected']);
    state = state.copyWith(path: state.path.sublist(0, index + 1));
  }

  // add position to path if it is adjacent to head of existing path
  void select((int, int) position) {
    if (validMove(position)) {
      state = state.copyWith(path: [...state.path, position]);
    }
  }

  // remove position from path if it is the last position in the path
  void deselect((int, int) position) {
    if (state.path.length <= 1) return;
    if (state.path.last == position) {
      state = state.copyWith(
        path: state.path.sublist(0, state.path.length - 1),
      );
    }
  }

  bool validMove((int, int) position) =>
      state.path.isEmpty || state.path.last.isAdjacent(position);

  int get n => state.n;

  int get m => state.m;

  bool isEmpty((int, int) position) => state.isEmpty(position);

  bool isSelected((int, int) position) => state.isSelected(position);
}
