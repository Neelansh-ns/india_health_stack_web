import 'package:rxdart/rxdart.dart';
import 'package:ui/factory/core/base_view.dart';
import 'package:ui/factory/core/base_view_out_state.dart';
import 'package:ui/factory/core/base_view_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:use_case/maps_location/get_state_list_usecase.dart';
import 'package:use_case/maps_location/get_city_list_usecase.dart';
import 'package:use_case/maps_location/get_hospital_data_list.dart';
import 'package:entities/hospital_entity.dart';

class DashboardView
    extends BaseView<DashboardViewState, DashboardViewOutState> {

  DashboardView(this._getStateListUseCase,this._getCityListUseCase,this._getHospitalListUseCase);

  GetStateListUseCase _getStateListUseCase;
  GetCityListUseCase _getCityListUseCase;
  GetHospitalListUseCase _getHospitalListUseCase;

  @override
  initializeOutState() {
    return DashboardViewOutState();
  }

  @override
  initializeState() {
    return DashboardViewState();
  }

  void onOpen() async {
    state._stateList.add(await _getStateListUseCase.execute()) ;
  }

   selectedState(String value) async{
    print(value);
    state._selectedState.add(value);
    state._cityList.add(await _getCityListUseCase.execute(1)) ;
   }

  void selectedCity(String value) {
    state.selectedCity = value;

    _loadHospitalBasedOnSelectedCity(value);
  }

   _loadHospitalBasedOnSelectedCity(String value) async{
     state._hospitalData.add(await _getHospitalListUseCase.execute(1));
   }
}

class DashboardViewState extends BaseViewState {
  BehaviorSubject<List<String>> _stateList = BehaviorSubject() ;
  BehaviorSubject<List<HospitalEntity>> _hospitalData = BehaviorSubject() ;
  Stream <List<HospitalEntity>>  get  hospitalData  =>  _hospitalData;
  BehaviorSubject<List<String>> _cityList = BehaviorSubject() ;
  BehaviorSubject<String> _selectedState =  BehaviorSubject();
  Stream <List<String>>  get cityList => _cityList;
 Stream <List<String>>  get stateList => _stateList;
  String get selectedState => _selectedState.value;

  String  selectedCity ;
}

class DashboardViewOutState extends BaseViewOutState {}
