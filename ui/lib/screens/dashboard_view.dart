import 'package:entities/states.dart';
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
    state._stateList.addStream(_getStateListUseCase.execute());
  }

   selectedState(States value) async{
    print(value);
    state._selectedState.add(value);
    state._cityList.add(value.list) ;
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
  BehaviorSubject<List<States>> _stateList = BehaviorSubject() ;
  Stream <List<States>>  get  stateList  =>  _stateList;

  BehaviorSubject<List<Cities>> _cityList = BehaviorSubject() ;
  Stream <List<Cities>>  get cityList => _cityList;

  BehaviorSubject<List<HospitalEntity>> _hospitalData = BehaviorSubject() ;
  BehaviorSubject<States> _selectedState =  BehaviorSubject();
 // Stream <List<String>>  get stateList => _stateList;
  States get selectedState => _selectedState.value;

  String  selectedCity ;
}

class DashboardViewOutState extends BaseViewOutState {}
