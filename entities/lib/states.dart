import 'package:entities/hospital_entity.dart';

class States {
  String name;
  List<Cities> list;
  int totalCities;

  States({this.name, this.list,this.totalCities});
}

class Cities {
  String name;
  int id;
  List<HospitalEntity> hospitalList;

  Cities({this.name, this.id, this.hospitalList});
}
