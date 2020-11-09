extension NumExtension on num {
  bool get isInteger => 
    this is int || this == roundToDouble();
}