import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:zipper/utils/point_utils.dart';

class Solution {
  final List<(int, int)> solution;
  final List<(int, int)> checkpoints;
  final Map<(int, int), List<(int, int)>> walls;

  Solution(this.solution, this.checkpoints, this.walls);
}

class MazeSolver {
  static final Random random = Random();
  static const List<(int, int)> moves = [(-1, 0), (1, 0), (0, -1), (0, 1)];

  static Future<Solution> generateCheckPoints(
    int n,
    int m,
    int checkPointCount, {
    int wallCount = 0,
  }) async {
    final input = (n, m, checkPointCount, wallCount);
    return await compute(_generateSolution, input);
  }

  static Solution _generateSolution((int, int, int, int) input) {
    final (n, m, checkPointCount, wallCount) = input;

    final solution = _solve(n, m);
    final checkPoints = _generateCheckPoints(solution, checkPointCount);
    final walls = _generateWalls(solution, wallCount, n, m);

    final solutionCR = solution.map((p) => (p.$2, p.$1)).toList();
    final checkPointsCR = checkPoints.map((p) => (p.$2, p.$1)).toList();
    final wallsCR = walls.map((key, value) =>
        MapEntry((key.$2, key.$1), value.map((p) => (p.$2, p.$1)).toList()));

    return (Solution(solutionCR, checkPointsCR, wallsCR));
  }

  static List<(int, int)> _solve(int n, int m) {
    // 1. Initialization: Create a "plough" configuration.
    // The initial walk is a deterministic snake pattern visiting every node.
    List<(int, int)> path = [];
    for (int r = 0; r < n; r++) {
      if (r % 2 == 0) {
        // Even rows: Left to Right
        for (int c = 0; c < m; c++) {
          path.add((r, c));
        }
      } else {
        // Odd rows: Right to Left
        for (int c = m - 1; c >= 0; c--) {
          path.add((r, c));
        }
      }
    }

    // 2. Determine Iterations.
    // The correlation time scales as N^z where z ≈ 0.16[cite: 65].
    // We use a heuristic multiplier (e.g., 10 * N^1.16) to ensuring mixing.
    int totalNodes = n * m;
    int iterations = (10.0 * pow(totalNodes, 1.16)).toInt();

    final random = Random();

    for (int i = 0; i < iterations; i++) {
      // 3. Select an Endpoint.
      // We can backbite from either the head (index 0) or tail (index N-1)[cite: 91].
      bool useHead = random.nextBool();
      (int, int) currentEnd = useHead ? path.first : path.last;

      // 4. Find valid neighbors for the backbite.
      // A neighbor is valid if it is adjacent on the grid but not connected
      // to the current endpoint in the path[cite: 91].
      List<(int, int)> candidates = [];

      // Check 4 cardinal directions
      for (var dir in const [(0, 1), (0, -1), (1, 0), (-1, 0)]) {
        int nr = currentEnd.$1 + dir.$1;
        int nc = currentEnd.$2 + dir.$2;

        // Must be within grid bounds
        if (nr >= 0 && nr < n && nc >= 0 && nc < m) {
          var neighbor = (nr, nc);

          // Identify the immediate connection to avoid verifying an existing link.
          // If we are at Head, the existing link is path[1].
          // If we are at Tail, the existing link is path[length-2].
          (int, int) existingLink = useHead ? path[1] : path[path.length - 2];

          if (neighbor != existingLink) {
            candidates.add(neighbor);
          }
        }
      }

      // If no backbite moves are possible from this end, skip turn.
      if (candidates.isEmpty) continue;

      // 5. Perform the Backbite Move.
      // Select a random neighbor to connect to[cite: 92].
      var target = candidates[random.nextInt(candidates.length)];

      // Find where this neighbor sits in the current path.
      // Note: Since it's a Hamiltonian path, the neighbor IS in the list.
      int k = path.indexOf(target);

      // Reconstruct the path to break the cycle[cite: 94].
      // This effectively reverses a subsection of the path.
      if (useHead) {
        // Case: Backbiting from Head (index 0) to node at index k.
        // We add edge 0-k, creating a loop 0...k-0.
        // We break the edge at k-1 to k.
        // The segment 0...k-1 is reversed.
        _reverseRange(path, 0, k - 1);
      } else {
        // Case: Backbiting from Tail (last index) to node at index k.
        // We add edge last-k, creating a loop k...last-k.
        // We break the edge at k to k+1.
        // The segment k+1...last is reversed.
        _reverseRange(path, k + 1, path.length - 1);
      }
    }

    return path;
  }

  /// Helper to reverse a sublist of [path] in-place from [start] to [end] inclusive.
  static void _reverseRange(List<(int, int)> path, int start, int end) {
    while (start < end) {
      var temp = path[start];
      path[start] = path[end];
      path[end] = temp;
      start++;
      end--;
    }
  }

  static List<(int, int)> _generateCheckPoints(
    List<(int, int)> solution,
    int count,
  ) {
    assert(solution.length > 1, 'solution must have at least 2 points');
    assert(solution.length > count, 'count must be less than solution length');

    Set<int> indices = {0, solution.length - 1};
    while (indices.length < count) {
      indices.add(random.nextInt(solution.length));
    }

    return (indices.toList()..sort())
        .map((i) => solution[i])
        .toList(growable: false);
  }

  static Map<(int, int), List<(int, int)>> _generateWalls(
    List<(int, int)> solution,
    int count,
    int n,
    int m,
  ) {
    Map<(int, int), List<(int, int)>> walls = {};
    int total = 0;

    while (total < count) {
      final randIndex = random.nextInt(solution.length);
      (int, int) position = solution[randIndex];

      int move = random.nextInt(3);
      for (int i = 0; i < 4; i++) {
        var adjacent = position + moves[(move + i) % 4];
        if (adjacent.$1 < 0 ||
            adjacent.$1 >= n ||
            adjacent.$2 < 0 ||
            adjacent.$2 >= m ||
            (solution.indexOf(adjacent) - randIndex).abs() == 1) {
          continue;
        }

        if (walls.containsKey(position)) {
          walls[position]!.add(adjacent);
        } else {
          walls[position] = [adjacent];
        }

        if (walls.containsKey(adjacent)) {
          walls[adjacent]!.add(position);
        } else {
          walls[adjacent] = [position];
        }

        total++;
        break;
      }
    }
    return walls;
  }
}
