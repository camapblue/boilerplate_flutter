class AnimatedController {
  final Duration duration;
  Function runAnimation;
  Function onAnimationFinished;

  AnimatedController({
    this.duration = const Duration(milliseconds: 250),
  });

  void run() {
    if (runAnimation != null) {
      runAnimation();
    }
  }

  //ignore: use_setters_to_change_properties
  void addListeners({Function onFinished}) {
    onAnimationFinished = onFinished;
  }

  void dispose() {
    onAnimationFinished = null;
  }
}