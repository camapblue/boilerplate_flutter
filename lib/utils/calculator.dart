class Calculator {
  static int getLevelFromUnit(int unit) {
    if (unit & (1 << 2) > 0) {
      return 3;
    } else if (unit & (1 << 1) > 0) {
      return 2;
    }
    return 1;
  }

  static int getUnitFromLevel(int level) {
    var unit = 0;
    for (var i = 0 ; i < level ; i++) {
      unit = unit | (1 << i);
    }
    return unit;
  }
}