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
}
