import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zipper/utils/point_utils.dart';
import 'package:zipper/utils/edge.dart';

part 'maze_notifier.freezed.dart';

part 'maze_notifier.g.dart';

@freezed
abstract class MazeNotifierState with _$MazeNotifierState {
  const MazeNotifierState._();

  const factory MazeNotifierState({
    @Default([]) List<(int, int)> solution,
    @Default([]) List<(int, int)> checkpoints,
    @Default({}) Map<(int, int), List<(int, int)>> walls,
    @Default([]) List<(int, int)> path,
    @Default(5) int n,
    @Default(5) int m,
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
        startEdge = position.getEdge(path[pathIdx - 1]);
      }
      if (pathIdx < path.length - 1) {
        endEdge = position.getEdge(path[pathIdx + 1]);
      }
    }
    return (startEdge, endEdge);
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

  List<(int, int)> getWalls((int, int) position) {
    return walls[position] ?? [];
  }
}

@Riverpod(keepAlive: true)
class MazeNotifier extends _$MazeNotifier {
  @override
  MazeNotifierState build() {
    return MazeNotifierState();
  }

  void set({
    required List<(int, int)> solution,
    required List<(int, int)> checkpoints,
    required Map<(int, int), List<(int, int)>> walls,
    required int n,
    required int m,
  }) async {
    assert(checkpoints.length >= 2, [
      'checkpoints must have at least 2 points',
    ]);
    assert(n > 0 && m > 0, ['n and m must be greater than 0']);

    state = state.copyWith(
      n: n,
      m: m,
      solution: solution,
      checkpoints: checkpoints,
      walls: walls,
      path: checkpoints.isNotEmpty ? [checkpoints[0]] : [],
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

  void reset() {
    state = state.copyWith(path: [state.path.first]);
  }

  void solve() {
    state = state.copyWith(path: state.solution);
  }

  bool validMove((int, int) position) {
    if (state.path.isEmpty) return true;
    return state.path.last.isAdjacent(position) &&
        !isBlocked(state.path.last, position);
  }

  int get n => state.n;

  int get m => state.m;

  bool isEmpty((int, int) position) => state.isEmpty(position);

  bool isSelected((int, int) position) => state.isSelected(position);

  bool isBlocked((int, int) start, (int, int) end) {
    return state.walls[start]?.contains(end) ?? false;
  }
}
