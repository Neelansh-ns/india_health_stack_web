import 'package:entities/lat_lng.dart';
import 'package:entities/maps_repo.dart';
import 'package:use_case/base_use_case.dart';

class GetLatLngFromLocationJsObject extends BaseUseCase<LatLng, dynamic> {
  MapsRepo _mapsRepo;

  GetLatLngFromLocationJsObject(this._mapsRepo);

  @override
  LatLng execute([dynamic jsObject]) {
    return _mapsRepo.getLatLngFromJsObject(jsObject);
  }
}
