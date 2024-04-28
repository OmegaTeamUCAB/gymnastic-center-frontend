class Result<T> {
  final T? value;
  final Error? error;

  Result._(this.value, this.error);

  get isSuccessful => this.value != null;
  get isError => this.error != null;

  T unwrap() {
    if (isSuccessful) {
      return this.value!;
    } else {
      throw this.error!;
    }
  }

  static Result<T> success<T>(T value) {
    return Result._(value, null);
  }

  static Result<T> failure<T>(Error error) {
    return Result._(null, error);
  }
}
