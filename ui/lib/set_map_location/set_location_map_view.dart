import 'dart:async';

import 'package:entities/lat_lng.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui/factory/core/base_view.dart';
import 'package:ui/factory/core/base_view_out_state.dart';
import 'package:ui/factory/core/base_view_state.dart';
import 'package:ui/factory/view_model/india_health_stack_view_factory.dart';
import 'package:ui/map/india_health_stack_map_view.dart';
import 'package:use_case/maps_location/get_adress_from_lat_long_usecase.dart';

class SetLocationOnMapView extends BaseView<SetLocationOnMapState, BaseViewOutState> {
  final IndiaHealthStackMapView _indiaHealthStackMapView = ViewFactory().get<IndiaHealthStackMapView>();
  GetAddressFromLatLongUseCase _getAddressFromLatLongUseCase;

  SetLocationOnMapView(this._getAddressFromLatLongUseCase);

  @override
  SetLocationOnMapState initializeState() {
    return SetLocationOnMapState();
  }

  onOpen(List<List<LatLng>> polygonPoints) {
    _indiaHealthStackMapView.init(polygonPoints, LatLng(12.932117, 77.580824));
    state._subscription = _indiaHealthStackMapView.state.cameraTarget.listen((latLng) async {
//      print('serviceAreaPolyLinesList:  ${_indiaHealthStackMapView.state.serviceAreaPolyLinesList}');
      if (latLng == null) {
        state._isMapIdle.add(false);
        state._currentAddress.add('');
        state.presentLatLng = null;
      } else {
        // bool result = RayCastHelper.isLatLngInside(polygonPoints, LatLng(latLng.lat, latLng.lng));
        // state._isUnderServiceableArea.add(result);
        if (true) {
          String _address = await _getAddressFromLatLongUseCase.execute(latLng.lat, latLng.lng);
          print('Got the address: $_address');
          print(_address);
          state.presentLatLng = latLng;
          state._currentAddress.add(_address);
        }
        // print('Raycast: $result');
      }
    });

    _indiaHealthStackMapView.state.isMapIdle.listen((event) {
      print('map $event');
      state._isMapIdle.add(event);
    });
  }

  @override
  BaseViewOutState initializeOutState() {
    return SetLocationOnMapOutState();
  }

  void refreshAllStates() {
    state.presentLatLng = null;
    state._currentAddress.add('');
    state._isMapIdle.add(null);
    state._isUnderServiceableArea.add(null);
    state._subscription?.cancel();
  }
}

class SetLocationOnMapState extends BaseViewState {
  StreamSubscription<LatLng> _subscription;
  LatLng presentLatLng;
  BehaviorSubject<String> _currentAddress = BehaviorSubject.seeded('');
  BehaviorSubject<bool> _isMapIdle = BehaviorSubject();

  Stream<String> get currentAddress => _currentAddress;

  String get currentAddressValue => _currentAddress.value;

  BehaviorSubject<bool> _isUnderServiceableArea = BehaviorSubject();

  Stream<bool> get isUnderServiceableArea => _isUnderServiceableArea;

  Stream<bool> get isMapIdle => _isMapIdle;

  Stream<bool> get isButtonActivated =>
      Rx.combineLatest2(_isMapIdle, _isUnderServiceableArea, (a, b) => a && b);
}

class SetLocationOnMapOutState extends BaseViewOutState {}
