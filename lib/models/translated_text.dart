class TranslatedText {
  final String text;
  final List<dynamic> params;
  final String suffix;

  TranslatedText(this.text, {this.suffix = '', this.params = const []});
}