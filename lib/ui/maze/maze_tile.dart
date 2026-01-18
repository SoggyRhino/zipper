import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zipper/state/maze_notifier.dart';
import 'package:zipper/state/maze_preferences_notifier.dart';
import 'package:zipper/utils/point_utils.dart';

import 'maze_path_painter.dart';

class MazeTile extends ConsumerWidget {
  final (int, int) position;
  final AnimationController animationController;

  const MazeTile({
    super.key,
    required this.position,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(
      mazePreferencesProvider.select((maze) => maze.pathColor),
    );

    final isSelected = ref.watch(
      mazeProvider.select((maze) => maze.isSelected(position)),
    );
    final (start, end) = ref.watch(
      mazeProvider.select((maze) => maze.getEdges(position)),
    );
    final checkpoint = ref.watch(
      mazeProvider.select((maze) => maze.getCheckPoint(position)),
    );
    final walls = ref
        .watch(mazeProvider.select((maze) => maze.getWalls(position)))
        .map((e) => position.getEdge(e))
        .nonNulls
        .toList(growable: false);
    final maze = ref.read(mazeProvider);

    return GridTile(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(120) : Colors.transparent,
          borderRadius: _getRadius(position, maze.n, maze.m),
          border: Border.all(color: Colors.black, width: .5),
        ),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return ClipRect(
                  child: SizedBox.expand(
                    child: CustomPaint(
                      painter: MazePathPainter(
                        start: start,
                        end: end,
                        color: color,
                        walls: walls,
                        animationValue: animationController.value,
                      ),
                    ),
                  ),
                );
              },
            ),
            if (checkpoint > -1)
              Center(
                child: Container(
                  width:  36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 3),
                  ),

                  // 3. Text styling adjustments
                  child: Text(
                    "${checkpoint + 1}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.0, // Helps vertical centering by removing font padding
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // round corresponding corners of the corner maze tiles
  static BorderRadius? _getRadius((int, int) pos, int n, int m) {
    final int x = pos.$1;
    final int y = pos.$2;

    if (x == 0 && y == 0) {
      return const BorderRadius.only(topLeft: Radius.circular(12));
    }
    if (x == m - 1 && y == 0) {
      return const BorderRadius.only(topRight: Radius.circular(12));
    }
    if (x == 0 && y == n - 1) {
      return const BorderRadius.only(bottomLeft: Radius.circular(12));
    }
    if (x == m - 1 && y == n - 1) {
      return const BorderRadius.only(bottomRight: Radius.circular(12));
    }

    return null;
  }
}
