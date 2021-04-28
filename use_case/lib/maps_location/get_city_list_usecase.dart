import 'dart:async';

import 'package:entities/india_health_stack_repo.dart';
import 'package:use_case/base_use_case.dart';
import 'package:entities/states.dart';

class GetCityListUseCase extends BaseUseCase<Stream<Cities>, int> {
  IndiaHealthStackRepo _indiaHealthStackRepo;

  GetCityListUseCase(this._indiaHealthStackRepo);

  @override
  Stream<Cities> execute([int cityIndex]) {
    // return _indiaHealthStackRepo.get();
  }
}
