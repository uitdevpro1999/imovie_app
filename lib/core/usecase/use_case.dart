import 'package:imovie_app/core/result/result.dart';

abstract interface class UseCase<Output, Params> {
  Future<Result<Output>> call(Params params);
}

class NoParams {
  const NoParams();
}
