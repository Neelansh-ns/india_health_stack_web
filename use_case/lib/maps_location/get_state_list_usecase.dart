import 'dart:async';

import 'package:entities/india_health_stack_repo.dart';
import 'package:use_case/base_use_case.dart';

class GetCityListUseCase extends BaseUseCase<List<String>, int> {
  IndiaHealthStackRepo _indiaHealthStackRepo;

  GetCityListUseCase(this._indiaHealthStackRepo);

  @override
  Future<List<String>> execute([int cityIndex]) {
    return _indiaHealthStackRepo.getCityNamesList(cityIndex);
  }
}