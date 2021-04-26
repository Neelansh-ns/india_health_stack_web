import 'package:entities/india_health_stack_repo.dart';
import 'package:ui/factory/core/base_view.dart';
import 'package:ui/factory/core/base_view_out_state.dart';
import 'package:ui/factory/core/base_view_state.dart';
import 'package:ui/screens/dashboard_view.dart';
import 'package:use_case/maps_location/get_adress_from_lat_long_usecase.dart';
import 'package:ui/set_map_location/set_location_map_view.dart';
class HealthDataModule {
  IndiaHealthStackRepo _indiaHealthStackRepo;

  HealthDataModule(this._indiaHealthStackRepo);

  BaseView<BaseViewState, BaseViewOutState> dashBoardView() {
    return DashboardView();
  }

  BaseView<BaseViewState, BaseViewOutState> getSetLocationOnMapView() {
    return SetLocationOnMapView(GetAddressFromLatLongUseCase(_indiaHealthStackRepo));
  }
}
