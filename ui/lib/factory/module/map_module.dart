import 'package:entities/maps_repo.dart';
import 'package:ui/map/india_health_stack_map_view.dart';
import 'package:use_case/maps_location/get_lat_lng_from_js_object.dart';

class MapModule {
  MapsRepo _mapsRepo;

  MapModule(this._mapsRepo);

  IndiaHealthStackMapView getMapNewView() {
    return IndiaHealthStackMapView(GetLatLngFromLocationJsObject(_mapsRepo));
  }

}
