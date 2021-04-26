import 'package:entities/maps_repo.dart';
import 'package:ui/map/bounce_map_new_view.dart';
import 'package:use_case/maps_location/get_lat_lng_from_js_object.dart';

class MapModule {
  MapsRepo _mapsRepo;

  MapModule(this._mapsRepo);

  BounceMapNewView getMapNewView() {
    return BounceMapNewView(GetLatLngFromLocationJsObject(_mapsRepo));
  }

}
