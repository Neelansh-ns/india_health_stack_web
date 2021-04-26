import 'dart:async';

import 'package:entities/lat_lng.dart';
import 'package:google_maps/google_maps.dart' as googleMaps;
import 'package:rxdart/rxdart.dart';
import 'package:ui/factory/core/base_view.dart';
import 'package:ui/factory/core/base_view_out_state.dart';
import 'package:ui/factory/core/base_view_state.dart';
import 'package:use_case/maps_location/get_lat_lng_from_js_object.dart';

class BounceMapNewView extends BaseView<BounceMapState, BounceMapOutState> {
  GetLatLngFromLocationJsObject _getLatLngFromLocationJsObject;

  BounceMapNewView(this._getLatLngFromLocationJsObject);

  void init(List<List<LatLng>> polygonPoints, LatLng userLatLng) {
    state._userLatLng = userLatLng;
    state._serviceAreaSet.clear();
    state._moveToCurrentLocation.add(false);
    getServiceAreaPolyLines(polygonPoints);
  }

  getServiceAreaPolyLines(List<List<LatLng>> polygonPoints) async {
    polygonPoints.forEach((element) {
      List _latLng = element.map((e) => googleMaps.LatLng(e.lat, e.lng)).toList();
      state._serviceAreaSet.add(googleMaps.Polygon(googleMaps.PolygonOptions()
        ..paths = _latLng
        ..visible = true
        ..fillColor = '#ffffff'
        ..fillOpacity = 0
        ..strokeColor = '#4a377b'
        ..strokeWeight = 3));
    });
  }

  onCurrentLocationSearch() {
    state._searchPin = null;
//    state._mapDrawState.add(getCurrentLocationMapDrawState());
  }

  googleMaps.LatLng getCurrentLocation() {
    return googleMaps.LatLng(12.932117, 77.580824);
  }

  googleMaps.LatLng getSearchPinLocation() {
    return googleMaps.LatLng(state._searchPin.lat, state._searchPin.lng);
  }

  updateCameraTargetOnMove(LatLng latLng) {
    state._cameraTarget.add(latLng);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  onCameraMove() {
    state._isMapIdle.add(false);
  }

  onCameraIdle() {
    state._isMapIdle.add(true);
  }

//
//  Future<bool> logCleverTapEvent(String eventName, {ScooterPickupOption scooter}) {
//    Map<String, dynamic> additionalParams = Map();
//
//    switch (eventName) {
//      case AnalyticsHelperService.TRIP_A2B_BIKE_MARKER_CLICK:
//        additionalParams = {
//          AnalyticsHelperService.NEAREST_BIKE_DISTANCE:
//              value(ViewFactory().get<RideFinderView>().queryScooter()?.distanceInMts),
//          AnalyticsHelperService.NEAREST_BIKE_TIME:
//              value(ViewFactory().get<RideFinderView>().queryScooter()?.walkTime),
//        };
//        break;
//    }
//    return _logEventUseCase
//        .execute(CleverTapParams(eventName: eventName, additionalParameters: additionalParams));
//  }

//  Future<List<googleMaps.Circle>> getCirclesForDecodedPathPoints(
//      List<googleMaps.LatLng> decodedPathPoints) async {
//  }

  @override
  BounceMapState initializeState() {
    return BounceMapState();
  }

  @override
  BounceMapOutState initializeOutState() {
    return null;
  }

  void mapJsObjectToLatLng(center) {
    LatLng _latLng = _getLatLngFromLocationJsObject.execute(center);
    updateCameraTargetOnMove(_latLng);
    print(_latLng.toJson());
    onCameraIdle();
  }

  void moveToCurrentLocation() {
    state._moveToCurrentLocation.add(true);
  }
}

class BounceMapState extends BaseViewState {
  BehaviorSubject<LatLng> _cameraTarget = BehaviorSubject();
  BehaviorSubject<String> _currentAddress = BehaviorSubject.seeded('');
  BehaviorSubject<bool> _isMapIdle = BehaviorSubject.seeded(true);
  BehaviorSubject<bool> _moveToCurrentLocation = BehaviorSubject();
  LatLng _userLatLng;

  Stream<LatLng> get cameraTarget => _cameraTarget;

  Stream<bool> get isMapIdle => _isMapIdle;

  Stream<String> get currentAddress => _currentAddress;

  LatLng _searchPin;

  LatLng get searchPin => _searchPin;

  Set<googleMaps.Polygon> _serviceAreaSet = Set();

  Set<googleMaps.Polygon> get serviceAreaSet => _serviceAreaSet;

  Stream<bool> get moveToCurrentLocation => _moveToCurrentLocation;

  googleMaps.LatLng get userLatLng => googleMaps.LatLng(_userLatLng.lat, _userLatLng.lng);

  @override
  dispose() {
    _isMapIdle.close();
    _moveToCurrentLocation.close();
    _currentAddress.close();
    _cameraTarget.close();
    return super.dispose();
  }
}

class BounceMapOutState extends BaseViewOutState {}
