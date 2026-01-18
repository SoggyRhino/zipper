import 'edge.dart';

extension TupleAddition on (int, int) {
  (int, int) operator +((int, int) other) {
    return (this.$1 + other.$1, this.$2 + other.$2);
  }

  (int, int) operator -((int, int) other) {
    return (this.$1 - other.$1, this.$2 - other.$2);
  }

  bool isAdjacent((int, int) pos2) {
    final dx = (this.$1 - pos2.$1).abs();
    final dy = (this.$2 - pos2.$2).abs();
    return (dx == 1 && dy == 0) || (dx == 0 && dy == 1);
  }

  Edge? getEdge((int, int) neighbor) {
    final dx = neighbor.$1 - this.$1;
    final dy = neighbor.$2 - this.$2;

    return switch ((dx, dy)) {
      (-1, 0) => Edge.left,
      (1, 0) => Edge.right,
      (0, -1) => Edge.top,
      (0, 1) => Edge.bottom,
      _ => null,
    };
  }
}
