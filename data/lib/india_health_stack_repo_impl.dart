import 'package:entities/hospital_entity.dart';
import 'package:entities/india_health_stack_repo.dart';
import 'package:remote_api/maps_api/maps_api.dart';
class IndiaHealthStackRepoImplementation extends IndiaHealthStackRepo{

  final MapsRemoteApi _mapsRemoteApi;

  IndiaHealthStackRepoImplementation(this._mapsRemoteApi);

  @override
  Future<String> getAddressFromLatLong({double lat, double long}) {
    print("ROope inside repo $lat, $long");
    return _mapsRemoteApi
        .getAddressFromLatLong('$lat,$long', 'AIzaSyBoeXXcnqKiAzu4npSDAsZeP5FSeiA6LWY')
        .then((value) {
      if (value.body["results"][0]["formatted_address"] != null) {
        return value.body["results"][0]["formatted_address"];
      } else {
        return null;
      }
    });
  }

  @override
  Future<List<String>> getStateNamesList() {
    List<String> dummy = ["Karnataka" , "Andrapradesh"];
    return Future.value(dummy);
  }

  @override
  Future<List<String>> getCityNamesList(int cityIndex) {
    List<String> dummy = ["Bangalore" , "Kalburgi"];
    return Future.value(dummy);
  }

  @override
  Future<List<HospitalEntity>> getHospitalData(int index) {
    HospitalEntity _hospitalEntity = HospitalEntity(name: "Apollo Hospital",numberOfAvailableBeds:2 ,numberOfBeds: 1);
    HospitalEntity _hospitalEntity2 = HospitalEntity(name: "Crazy Hospital",numberOfAvailableBeds:5 ,numberOfBeds: 9);
    List<HospitalEntity> dummy = [_hospitalEntity,_hospitalEntity2];
    return Future.value(dummy);
  }
}