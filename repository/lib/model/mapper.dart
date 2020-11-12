typedef FromJson<T> = T Function(Map<String, dynamic> json);

class Mapper<T> {
  final FromJson<T> parse;
  
  Mapper({this.parse});

  Mapper.none(): parse = null;
}