import 'package:entities/hospital_entity.dart';
import 'package:entities/states.dart';

abstract class IndiaHealthStackRepo {
  Future<String> getAddressFromLatLong({double lat, double long});

  Stream<List<States>> getStateNamesList();

  Future<List<HospitalEntity>> getHospitalData(int index);
}
