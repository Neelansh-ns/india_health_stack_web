import 'dart:async';
import 'package:entities/hospital_entity.dart';

import 'package:entities/india_health_stack_repo.dart';
import 'package:use_case/base_use_case.dart';

class GetHospitalListUseCase extends BaseUseCase<List<HospitalEntity>, int> {
  IndiaHealthStackRepo _indiaHealthStackRepo;

  GetHospitalListUseCase(this._indiaHealthStackRepo);

  @override
  Future<List<HospitalEntity>> execute([int index]) {
    return _indiaHealthStackRepo.getHospitalData(index);
  }
}