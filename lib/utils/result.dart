sealed class Result<T> {
  const Result();

  const factory Result.succ(T value) = Succ._;

  const factory Result.fail(Exception error) = Fail._;
}

final class Succ<T> extends Result<T> {
  const Succ._(this.value);

  final T value;

  @override
  String toString() => 'Result<$T>.succ($value)';
}

final class Fail<T> extends Result<T> {
  const Fail._(this.error);

  final Exception error;

  @override
  String toString() => 'Result<$T>.fail($error)';
}
