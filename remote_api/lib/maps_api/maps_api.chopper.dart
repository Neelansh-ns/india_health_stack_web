// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maps_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$MapsRemoteApi extends MapsRemoteApi {
  _$MapsRemoteApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MapsRemoteApi;

  @override
  Future<dynamic> getAddressFromLatLong(String latLmg, String key) {
    final $url = '/maps/api/geocode/json';
    final $params = <String, dynamic>{'latlng': latLmg, 'key': key};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send($request);
  }
}
