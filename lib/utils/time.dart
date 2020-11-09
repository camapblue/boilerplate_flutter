class Time {
  static String currentSeason() {
    final now = DateTime.now();

    if (now.month < 8) {
      return '${now.year - 1}-${now.year}';
    }
    return '${now.year}-${now.year + 1}';
  }
}