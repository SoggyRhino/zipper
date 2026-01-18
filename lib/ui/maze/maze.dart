import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zipper/state/maze_notifier.dart';
import 'package:zipper/utils/point_utils.dart';
import 'maze_controller.dart';
import 'maze_tile.dart';

class Maze extends ConsumerStatefulWidget {
  final MazeController controller;

  const Maze({super.key, required this.controller});

  @override
  ConsumerState<Maze> createState() => _MazeState();
}

class _MazeState extends ConsumerState<Maze>
    with SingleTickerProviderStateMixin {
  final GlobalKey _gridKey = GlobalKey();
  late final AnimationController pathAnimationController;

  (int, int)? _lastPosition;

  @override
  void initState() {
    super.initState();

    pathAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void dispose() {
    pathAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mazeNotifier = ref.read(mazeProvider.notifier);
    final mazeState = ref.watch(mazeProvider);

    return GestureDetector(
      onPanStart: widget.controller.active
          ? (details) {
              final position = _toPosition(
                details.globalPosition,
                mazeState.n,
                mazeState.m,
              );
              if (position == (-1, -1)) return;
              pathAnimationController.reset();

              if (mazeNotifier.isSelected(position)) {
                mazeNotifier.deselectAfter(position);
              } else if (mazeNotifier.isEmpty(position)) {
                mazeNotifier.select(position);
              }
              _lastPosition = position;
              pathAnimationController.forward();
            }
          : null,
      onPanUpdate: widget.controller.active
          ? (details) => _drag(
                mazeNotifier,
                details.globalPosition,
                mazeState.n,
                mazeState.m,
              )
          : null,
      onPanEnd: (_) => widget.controller.active ? _endDrag() : null,
      child: _buildGrid(mazeState.n, mazeState.m),
    );
  }

  Widget _buildGrid(int n, int m) {
    final size = MediaQuery.of(context).size;
    final double cellSize = min(
          size.width / m,
          size.height / n,
        ) *
        .95;

    return Center(
      child: SizedBox(
        width: cellSize * m,
        height: cellSize * n,
        child: GridView.builder(
          key: _gridKey,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: n * m,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: m,
            childAspectRatio: 1.0,
          ),
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return RepaintBoundary(
              child: MazeTile(
                position: (index % m, index ~/ m),
                animationController: pathAnimationController,
              ),
            );
          },
        ),
      ),
    );
  }

  (int, int) _toPosition(Offset globalOffset, int n, int m) {
    final RenderBox? box =
        _gridKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return (-1, -1);

    final Offset localOffset = box.globalToLocal(globalOffset);
    final double cellWidth = box.size.width / m;
    final double cellHeight = box.size.height / n;

    int x = (localOffset.dx / cellWidth).floor();
    int y = (localOffset.dy / cellHeight).floor();

    return (x.clamp(0, m - 1), y.clamp(0, n - 1));
  }

  void _drag(MazeNotifier notifier, Offset offset, int n, int m) {
    final position = _toPosition(offset, n, m);

    if (_lastPosition == null) {
      _lastPosition = position;
      return;
    }
    if (position == _lastPosition || position == (-1, -1)) return;

    if (notifier.isSelected(position) && notifier.isSelected(_lastPosition!)) {
      //if already selected, deselect if it was the last added
      // this means we can only directly backtrack using drag, unlike with tapping
      notifier.deselect(_lastPosition!);
      _lastPosition = position;
    } else if (notifier.isEmpty(position) &&
        position.isAdjacent(_lastPosition!)) {
      notifier.select(position);
      _lastPosition = position;
    }
  }

  void _endDrag() {
    _lastPosition = null;
    pathAnimationController.reset();
    pathAnimationController.forward();
  }
}
