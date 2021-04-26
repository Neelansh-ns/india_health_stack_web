import 'dart:async';

import 'package:entities/india_health_stack_repo.dart';
import 'package:entities/states.dart';
import 'package:use_case/base_use_case.dart';

class GetStateListUseCase extends BaseUseCase<Stream<List<States>>, void> {
  IndiaHealthStackRepo _indiaHealthStackRepo;

  GetStateListUseCase(this._indiaHealthStackRepo);

  @override
  Stream<List<States>> execute([void _dummy]) {
    return _indiaHealthStackRepo.getStateNamesList();
  }
}
