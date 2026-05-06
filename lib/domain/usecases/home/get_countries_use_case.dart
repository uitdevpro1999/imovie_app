import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/home/home_country.dart';
import 'package:imovie_app/domain/repositories/home_repository.dart';

class GetCountriesUseCase implements UseCase<List<HomeCountry>, NoParams> {
  const GetCountriesUseCase(this.repository);

  final HomeRepository repository;

  @override
  Future<Result<List<HomeCountry>>> call(NoParams params) {
    return repository.getCountries();
  }
}
