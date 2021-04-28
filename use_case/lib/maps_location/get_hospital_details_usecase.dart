import 'dart:async';

import 'package:entities/hospital_entity.dart';
import 'package:entities/india_health_stack_repo.dart';
import 'package:entities/states.dart';
import 'package:use_case/base_use_case.dart';

class GetHospitalDetailsUseCase extends BaseUseCase<HospitalEntity, int> {
  IndiaHealthStackRepo _indiaHealthStackRepo;

  GetHospitalDetailsUseCase(this._indiaHealthStackRepo);

  @override
  Future<HospitalEntity> execute([int index]) {
    return _indiaHealthStackRepo.getHospitalDetails(index);
  }
}