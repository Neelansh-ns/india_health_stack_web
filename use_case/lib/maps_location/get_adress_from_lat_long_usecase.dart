import 'dart:async';

import 'package:entities/india_health_stack_repo.dart';
import 'package:use_case/base_use_case.dart';

class GetAddressFromLatLongUseCase extends BaseUseCase<String, double> {
  IndiaHealthStackRepo _indiaHealthStackRepo;

  GetAddressFromLatLongUseCase(this._indiaHealthStackRepo);

  @override
  Future<String> execute([double lat, double long]) {
    print("ROope lat long $lat");
    return _indiaHealthStackRepo.getAddressFromLatLong(lat: lat, long: long);
  }
}
