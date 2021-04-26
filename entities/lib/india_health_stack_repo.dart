import 'package:entities/hospital_entity.dart';

abstract class IndiaHealthStackRepo{
  Future<String> getAddressFromLatLong({double lat, double long});

  Future<List<String>> getStateNamesList();
  Future<List<String>> getCityNamesList(int index);
  Future<List<HospitalEntity>> getHospitalData(int index);

}