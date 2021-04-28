import 'package:entities/india_health_stack_repo.dart';
import 'package:ui/factory/core/base_view.dart';
import 'package:ui/factory/core/base_view_out_state.dart';
import 'package:ui/factory/core/base_view_state.dart';
import 'package:ui/screens/dashboard_view.dart';
import 'package:ui/screens/details_page/details_page_view.dart';
import 'package:use_case/maps_location/get_adress_from_lat_long_usecase.dart';
import 'package:ui/set_map_location/set_location_map_view.dart';
import 'package:use_case/maps_location/get_state_list_usecase.dart';
import 'package:use_case/maps_location/get_city_list_usecase.dart';
import 'package:use_case/maps_location/get_hospital_data_list.dart';
import 'package:use_case/maps_location/get_hospital_details_usecase.dart';
class HealthDataModule {
  IndiaHealthStackRepo _indiaHealthStackRepo;

  HealthDataModule(this._indiaHealthStackRepo);

  BaseView<BaseViewState, BaseViewOutState> dashBoardView() {
    return DashboardView( GetStateListUseCase(_indiaHealthStackRepo),
        GetCityListUseCase(_indiaHealthStackRepo),
        GetHospitalListUseCase(_indiaHealthStackRepo));
  }

  BaseView<BaseViewState, BaseViewOutState> getSetLocationOnMapView() {
    return SetLocationOnMapView(GetAddressFromLatLongUseCase(_indiaHealthStackRepo));
  }

  BaseView<BaseViewState, BaseViewOutState> detailsPageView() {
    return DetailsPageView(GetHospitalDetailsUseCase(_indiaHealthStackRepo));
  }
}
