import 'package:entities/lat_lng.dart';
abstract class MapsRepo {
  LatLng getLatLngFromJsObject(jsObject);
}
