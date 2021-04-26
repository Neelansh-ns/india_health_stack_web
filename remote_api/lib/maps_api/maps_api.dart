import 'dart:async';

import "package:chopper/chopper.dart";

part "maps_api.chopper.dart";

/// todo
///
/// In terminal :
/// cd remote_api
/// flutter packages pub run build_runner build
/// OR
/// flutter packages pub run build_runner watch
///
/// todo
///
/// Add 'http.Multipart' to only 'Multipart'
/// whenever running above commands
///
/// On conflicting errors:
/// flutter packages pub run build_runner build --delete-conflicting-outputs
///

@ChopperApi(baseUrl: "")
abstract class MapsRemoteApi extends ChopperService {
  static Map headers;

  static MapsRemoteApi create() {
    final client = ChopperClient(
        baseUrl: "https://maps.googleapis.com",
        // interceptors: [],
        converter: JsonConverter());

    return _$MapsRemoteApi(client);
  }

  @Get(path: "/maps/api/geocode/json")
  Future<dynamic> getAddressFromLatLong(@Query('latlng') String latLmg, @Query('key') String key);
}
