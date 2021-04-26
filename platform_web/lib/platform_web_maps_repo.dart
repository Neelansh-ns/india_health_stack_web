import 'dart:convert';
import 'dart:js' as js;

import 'package:entities/lat_lng.dart';
import 'package:entities/maps_repo.dart';

class PlatformWebMapsRepo extends MapsRepo {
  @override
  LatLng getLatLngFromJsObject(jsObject) {
    var center = js.context['JSON'].callMethod('stringify', [jsObject]);
    print('JS Object center $center');
    return LatLng(jsonDecode(center)['lat'], jsonDecode(center)['lng']);
  }
}
