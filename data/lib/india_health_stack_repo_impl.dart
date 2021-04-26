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
}