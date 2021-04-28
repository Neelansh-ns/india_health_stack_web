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
    QuerySnapshot snapshot =
        await _firebaseFirestore.collection('hospitals').where("cityId", isEqualTo: index).get();
    QuerySnapshot queryofdocs = await _firebaseFirestore.collection('resources').get();

    List<HospitalEntity> hospitalEntity = List();
    if (snapshot.docs.isNotEmpty) {
      await Future.forEach(snapshot.docs, (e) async {
        // await snapshot.docs.forEach((e) async{
        print(" Roope ${(e.data()['resources'])}");

        List<Resource> resources = await _getResourceList(e?.data()['resources'] as List<dynamic>);

        hospitalEntity.add(HospitalEntity(
          uniqueID: e.data()['id'],
          mapLink: e?.data()['mapLink'],
          lastUpdatedTimestamp: e?.data()['lastUpdated'],
          pinCode: e?.data()['pincode'],
          address:e.data()['address'] ,
          paymentType:e.data()['paymentModes'] ,
          resourcesList: resources,
          hospitalName: e.data()['name'],
          phoneNumber: e?.data()['contactNumber'] ?? "123456789",
        ));
      });

      return hospitalEntity;
    } else {
      return null;
    }
  }

  Future<List<Resource>> _getResourceList(List data) async {
    List<Resource> resources = List();

    await Future.forEach(data, (e) async {
      // await data.forEach((e) async {
      var resource = await _getResourceData(e['resReference'] as DocumentReference);

      resources.add(Resource(
          countAvailable: e['resCount'],
          refID: resource['resId'],
          resourceName: resource['resName'],
          resIcon: resource['resIcon']));
      // });
    });

    return resources;
  }

  Future<Map<String, dynamic>> _getResourceData(DocumentReference ref) async {
    print(" Roope path  ${ref.path}");

    DocumentSnapshot snapshot = await _firebaseFirestore.doc(ref.path).get().catchError((e) {
      print("error $e");
    });
    if (snapshot.exists) {
      print("data exists");
    } else {
      print("data dont  exists");
    }
    print(snapshot.data()['resId']);
    return snapshot.data();
  }

  @override
  Future<List<HospitalEntity>> getResourceData(String docPath) async {
    DocumentReference doc = docPath as DocumentReference;

    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection('resources').doc(doc.path).get();
    print(snapshot);
    print(snapshot.data()['resId']);
  }

  @override
  Future<HospitalEntity> getHospitalDetails(int index) async {
    QuerySnapshot snapshot =
        await _firebaseFirestore.collection('hospitals').where("id", isEqualTo: index).get();
    List<Resource> resources =
        await _getResourceList(snapshot?.docs[0].data()['resources'] as List<dynamic>);

    if (snapshot.docs.isNotEmpty) {
      return HospitalEntity(
        uniqueID: snapshot.docs[0].data()['id'],
        mapLink: snapshot.docs[0].data()['mapLink'],
        lastUpdatedTimestamp: snapshot.docs[0].data()['lastUpdated'],
        pinCode: snapshot.docs[0].data()['pincode'],
        address:snapshot.docs[0].data()['address'] ,
        paymentType:snapshot.docs[0].data()['paymentModes'] ,
        resourcesList: resources,
        hospitalName: snapshot.docs[0].data()['name'],
        phoneNumber: snapshot.docs[0].data()['contactNumber'] ?? "123456789",
      );
    } else {
      return null;
    }
  }
}
