import 'dart:async';

import 'package:entities/india_health_stack_repo.dart';
import 'package:use_case/base_use_case.dart';

class GetStateListUseCase extends BaseUseCase<List<String>, void> {
  IndiaHealthStackRepo _indiaHealthStackRepo;

  GetStateListUseCase(this._indiaHealthStackRepo);

  @override
  Future<List<String>> execute([void _dummy]) {
    return _indiaHealthStackRepo.getStateNamesList();
  }
}