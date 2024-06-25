enum Side {
  TOP,
  RIGHT,
  BOTTOM,
  LEFT
}

Side previousSide(Side side) {
  switch(side) {
    case Side.TOP:
      return Side.LEFT;
    case Side.RIGHT:
      return Side.TOP;
    case Side.BOTTOM:
      return Side.RIGHT;
    case Side.LEFT:
      return Side.BOTTOM;
  }
}

Side nextSide(Side side) {
  switch(side) {
    case Side.TOP:
      return Side.RIGHT;
    case Side.RIGHT:
      return Side.BOTTOM;
    case Side.BOTTOM:
      return Side.LEFT;
    case Side.LEFT:
      return Side.TOP;
  }
}

// Side oppositeSide(Side theSide) {
//   switch (theSide) {
//     case Side.BOTTOM:
//       return Side.TOP;
//     case Side.LEFT:
//       return Side.RIGHT;
//     case Side.RIGHT:
//       return Side.LEFT;
//     case Side.TOP:
//       return Side.BOTTOM;
//   }
// }