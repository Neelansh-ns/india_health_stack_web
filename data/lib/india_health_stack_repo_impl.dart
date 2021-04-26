import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entities/hospital_entity.dart';
import 'package:entities/india_health_stack_repo.dart';
import 'package:entities/states.dart';
import 'package:remote_api/maps_api/maps_api.dart';

class IndiaHealthStackRepoImplementation extends IndiaHealthStackRepo {
  final MapsRemoteApi _mapsRemoteApi;
  final FirebaseFirestore _firebaseFirestore;

  IndiaHealthStackRepoImplementation(
      this._mapsRemoteApi, this._firebaseFirestore);

  @override
  Future<String> getAddressFromLatLong({double lat, double long}) {
    print("ROope inside repo $lat, $long");
    return _mapsRemoteApi
        .getAddressFromLatLong(
            '$lat,$long', 'AIzaSyBoeXXcnqKiAzu4npSDAsZeP5FSeiA6LWY')
        .then((value) {
      if (value.body["results"][0]["formatted_address"] != null) {
        return value.body["results"][0]["formatted_address"];
      } else {
        return null;
      }
    });
  }

  @override
  Stream<List<States>> getStateNamesList() async* {
    QuerySnapshot snapshot =
        await _firebaseFirestore.collection('states').get();
    yield snapshot.docs.map((e) {
      print((e.data()['cities']));
      return States(
          name: e.data()['name'], list: e.data()['cities'] as List<Cities>);
    }).toList();
  }

  // Future<List<Cities>> getCityNamesList(String cityId)async {
  //
  //   DocumentSnapshot snapshot =
  //       await _firebaseFirestore.collection('cities').doc(cityId).get();
  //   return snapshot.data().entries.map((e) => Cities(name: e.value)).toList();
  // }

  @override
  Future<List<HospitalEntity>> getHospitalData(int index) {
    HospitalEntity _hospitalEntity = HospitalEntity(
        hospitalName: "Apollo Hospital",
        resourcesList: [Resource(2, "TotalBeds"), Resource(4, "ICU Beds")]);
    HospitalEntity _hospitalEntity2 = HospitalEntity(
        hospitalName: "crazy Hospital",
        resourcesList: [Resource(2, "TotalBeds"), Resource(4, "ICU Beds")]);
    List<HospitalEntity> dummy = [_hospitalEntity, _hospitalEntity2];
    return Future.value(dummy);
  }
}
