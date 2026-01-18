import 'package:flutter/material.dart';
import '../../utils/edge.dart';

class MazePathPainter extends CustomPainter {
  final Edge? start;
  final Edge? end;
  final List<Edge> walls;
  final Color color;
  final double animationValue;

  MazePathPainter({
    required this.start,
    required this.end,
    required this.walls,
    required this.color,
    this.animationValue = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawPath(canvas, size);
    _drawWalls(canvas, size);
  }

  void _drawPath(Canvas canvas, Size size) {
    if (start == null && end == null) return;

    final pulseProgress = (1 - (animationValue * 2 - 1).abs());
    final strokeWidthPercent = 0.65 + (pulseProgress * 0.10);

    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width * strokeWidthPercent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);

    Offset getOffset(Edge edge) {
      switch (edge) {
        case Edge.top:
          return Offset(size.width / 2, 0);
        case Edge.bottom:
          return Offset(size.width / 2, size.height);
        case Edge.left:
          return Offset(0, size.height / 2);
        case Edge.right:
          return Offset(size.width, size.height / 2);
      }
    }

    final path = Path();

    if (start != null && end != null) {
      if (Edge.inline(start!, end!)) {
        path.moveTo(getOffset(start!).dx, getOffset(start!).dy);
        path.lineTo(getOffset(end!).dx, getOffset(end!).dy);
      } else {
        path.moveTo(getOffset(start!).dx, getOffset(start!).dy);
        path.lineTo(center.dx, center.dy);

        path.moveTo(center.dx, center.dy);
        path.lineTo(getOffset(end!).dx, getOffset(end!).dy);
      }
    } else if (start != null || end != null) {
      path.moveTo(center.dx, center.dy);
      if (start != null) {
        path.lineTo(getOffset(start!).dx, getOffset(start!).dy);
      } else {
        path.lineTo(getOffset(end!).dx, getOffset(end!).dy);
      }
    }

    canvas.drawPath(path, paint);
  }

  void _drawWalls(Canvas canvas, Size size) {
    if (walls.isEmpty) return;

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = size.width * .1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final path = Path();

    final (double, double) topLeftCorner = (0, 0);
    final (double, double) topRightCorner = (size.width, 0);
    final (double, double) bottomLeftCorner = (0, size.height);
    final (double, double) bottomRightCorner = (size.width, size.height);

    for (final edge in walls) {
      switch (edge) {
        case Edge.top:
          path.moveTo(topLeftCorner.$1, topLeftCorner.$2);
          path.lineTo(topRightCorner.$1, topRightCorner.$2);
          break;
        case Edge.right:
          path.moveTo(topRightCorner.$1, topRightCorner.$2);
          path.lineTo(bottomRightCorner.$1, bottomRightCorner.$2);
          break;
        case Edge.bottom:
          path.moveTo(bottomRightCorner.$1, bottomRightCorner.$2);
          path.lineTo(bottomLeftCorner.$1, bottomLeftCorner.$2);
          break;
        case Edge.left:
          path.moveTo(bottomLeftCorner.$1, bottomLeftCorner.$2);
          path.lineTo(topLeftCorner.$1, topLeftCorner.$2);
          break;
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MazePathPainter oldDelegate) {
    return oldDelegate.start != start ||
        oldDelegate.end != end ||
        oldDelegate.color != color ||
        oldDelegate.animationValue != animationValue;
  }
}
