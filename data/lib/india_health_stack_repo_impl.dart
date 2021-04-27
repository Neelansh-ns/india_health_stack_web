import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entities/hospital_entity.dart';
import 'package:entities/india_health_stack_repo.dart';
import 'package:entities/states.dart';
import 'package:remote_api/maps_api/maps_api.dart';

class IndiaHealthStackRepoImplementation extends IndiaHealthStackRepo {
  final MapsRemoteApi _mapsRemoteApi;
  final FirebaseFirestore _firebaseFirestore;

  IndiaHealthStackRepoImplementation(this._mapsRemoteApi, this._firebaseFirestore);

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
  Stream<List<States>> getStateNamesList() async* {
    QuerySnapshot snapshot = await _firebaseFirestore.collection('states').get();
    yield snapshot.docs.map((e) {
      print((e.data()['cities']));
      return States(name: e.data()['name'], list: _getCities(e.data()['cities'] as List<dynamic>));
    }).toList();
  }

  _getCities(List<dynamic> data) {
    return data.map((e) => Cities(name: e['name'], id: e['id'])).toList();
  }

  @override
  Future<List<HospitalEntity>> getHospitalData(int index) async {

    QuerySnapshot snapshot = await _firebaseFirestore.collection('hospitals').get();
    QuerySnapshot queryofdocs = await _firebaseFirestore.collection('resources').get();


    return  snapshot.docs.map((e)  {
      print(" Roope ${(e.data()['resources'])}");
      if (e.data() != null && e.data()['cityId'] == index) {
        return HospitalEntity(
          uniqueID: e.data()['id'],
          mapLink: e?.data()['mapLink'],
          lastUpdatedTimestamp: e?.data()['lastUpdated'],
          // resourcesList:  _getResourceList(e?.data()['resources'] as List<dynamic>,queryofdocs),
          //resourcesList:_getResourceList(e?.data()['resources'] as DocumentReference),
          hospitalName: e.data()['name'],
          phoneNumber: e?.data()['contactNumber'] ?? "123456789",
        );
      }
    }).toList();

  }

  // _getResourceData(DocumentReference data) async* {
  //   DocumentSnapshot snapshot =
  //       await _firebaseFirestore.collection('resources').doc(data.path).get();
  //   print(snapshot);
  //   print(snapshot.data()['resId']);
  //   yield snapshot.data()['resName'];
  // }


}
