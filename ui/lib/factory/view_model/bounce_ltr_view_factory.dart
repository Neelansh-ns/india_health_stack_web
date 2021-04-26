import 'package:ui/factory/core/base_view.dart';
import 'package:ui/factory/module/india_healthstack_module.dart';
import 'package:ui/map/bounce_map_new_view.dart';
import 'package:ui/screens/dashboard_view.dart';
import 'package:ui/set_map_location/set_location_map_view.dart';

class ViewFactory {
  final _app = IndiaHealthStackModule();

  static final ViewFactory _instance = ViewFactory._();

  initialise() async {
    return await _app.initialise();
  }

  factory ViewFactory() {
    return _instance;
  }

  ViewFactory._();

  final Map<Type, BaseView> _viewMap = Map();

  T get<T>() {
    if (_viewMap.containsKey(T)) {
      return _viewMap[T] as T;
    } else {
      BaseView view = _get<T>();
      _viewMap[T] = view;
//      _viewMap.putIfAbsent(T,()=> view);
      return view as T;
    }
  }

  BaseView _get<T>() {
    switch (T) {
      case BounceMapNewView: return _app.mapModule().getMapNewView();
      case DashboardView:
        return _app.healthDataModule().dashBoardView();
      case SetLocationOnMapView:
        return _app.healthDataModule().getSetLocationOnMapView();
      default:
        return throw Exception("View is not created for $T");
    }
  }

  void clearSession() {
    _viewMap.removeWhere((key, value) {
      switch (key) {
        default:
          return true;
      }
    });
  }
}
