import 'package:imovie_app/core/error/app_failure.dart';

sealed class Result<T> {
  const Result();

  R map<R>({
    required R Function(T data) success,
    required R Function(AppFailure failure) failure,
  }) {
    final current = this;

    if (current is Success<T>) {
      return success(current.data);
    }

    return failure((current as FailureResult<T>).failure);
  }
}

class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final AppFailure failure;
}
