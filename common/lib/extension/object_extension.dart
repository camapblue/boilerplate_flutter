typedef MapFunction<S, T> = T Function(S source);

T ifNotNullThen<S, T>(S source, MapFunction<S, T> mapFunction) {
  if (source != null) {
    return mapFunction(source);
  }

  return null;
}