enum Edge {
  top,
  left,
  right,
  bottom;

  static int _value(Edge edge) {
    switch (edge) {
      case Edge.top:
        return 1;
      case Edge.right:
        return 2;
      case Edge.bottom:
        return 3;
      case Edge.left:
        return 4;
    }
  }

  static bool inline(Edge edge1, Edge edge2) {
    return (_value(edge1) + _value(edge2)) % 2 == 0;
  }
}
