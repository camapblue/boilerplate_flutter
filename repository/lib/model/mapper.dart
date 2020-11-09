typedef T FromJson<T>(Map<String, dynamic> json);

class Mapper<T> {
  final FromJson<T> parse;
  
  Mapper({this.parse});

  Mapper.none(): parse = null;
}