typedef FromJson<T> = T Function(Map<String, dynamic> json);

class Mapper<T> {
  final FromJson<T> parser;

  Mapper({required this.parser});

  List<T> toList({required List<dynamic> json}) {
    // ignore: unnecessary_lambdas
    return List.from(json).map((e) => parser(e)).toList();
  }

  T toObject({required Map<String, dynamic> json}) {
    return parser(json);
  }
}
