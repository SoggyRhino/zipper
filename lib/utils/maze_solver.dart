import 'dart:math';

import 'package:zipper/utils/point_utils.dart';

class MazeSolver {
  final Random random = Random();
  static const List<(int, int)> moves = [(-1, 0), (1, 0), (0, -1), (0, 1)];

  List<(int, int)> solve(int n, int m) {
    assert(n > 0 && m > 0, 'n and m must be positive');
    final path = <(int, int)>[];
    final visited = <(int, int)>{};
    final stack = <(int, int)>[];

    final start = (random.nextInt(m), random.nextInt(n));
    stack.add(start);
    visited.add(start);
    path.add(start);

    while (stack.isNotEmpty) {
      final current = stack.last;
      final neighbors = moves
          .map((move) => current + move)
          .where(
            (next) =>
                !visited.contains(next) &&
                next.$1 >= 0 &&
                next.$1 < m &&
                next.$2 >= 0 &&
                next.$2 < n,
          )
          .toList();
      if (neighbors.isNotEmpty) {
        final next = neighbors[random.nextInt(neighbors.length)];
        stack.add(next);
        visited.add(next);
        path.add(next);
      } else {
        stack.removeLast();
      }
    }
    return path;
  }

  bool rec(int n, int m, Set<(int, int)> path) {
    if (path.length == n * m) return true;

    int move = random.nextInt(3);
    for (int i = 0; i < 4; i++) {
      var next = path.last + moves[(move + i) % 4];

      if (path.contains(next) ||
          next.$1 < 0 ||
          next.$1 >= m ||
          next.$2 < 0 ||
          next.$2 >= n) {
        continue;
      }

      path.add(next);
      if (rec(n, m, path)) {
        return true;
      }

      path.remove(next);
    }
    return false;
  }

  List<(int, int)> generateCheckPoints(int n, int m, {int? count}) {
    final solution = solve(n, m);

    count ??= random.nextInt((n + m));

    Set<int> indices = {0, solution.length - 1};
    while (indices.length < count) {
      indices.add(random.nextInt(solution.length));
    }

    final sortedIndices = indices.toList()..sort();

    print("Dimensions: ${n}x${m}");
    print(
      "Checkpoints: ${sortedIndices.map((i) => solution[i]).toList(growable: false)}",
    );

    return sortedIndices.map((i) => solution[i]).toList(growable: false);
  }
}
