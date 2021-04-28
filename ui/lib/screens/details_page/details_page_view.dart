import 'package:entities/hospital_entity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui/factory/core/base_view.dart';
import 'package:ui/factory/core/base_view_out_state.dart';
import 'package:ui/factory/core/base_view_state.dart';
import 'package:use_case/maps_location/get_hospital_details_usecase.dart';

class DetailsPageView extends BaseView<DetailsPageViewState, DetailsPageViewOutState> {

DetailsPageView(this._getHospitalDetailsUseCase);
  GetHospitalDetailsUseCase _getHospitalDetailsUseCase;

  @override
  DetailsPageViewOutState initializeOutState() {
    return DetailsPageViewOutState();
  }

  @override
  DetailsPageViewState initializeState() {
    return DetailsPageViewState();
  }

   onOpen( String index) {
    refreshStates();
    _getHospitalDetailsUseCase.execute(int.parse(index)).then((value) {
      state.hospitalData.add(value);
    });
   }

  void refreshStates() {
    state.hospitalData.add(null);
  }
}
class DetailsPageViewState extends BaseViewState {
  BehaviorSubject<HospitalEntity> hospitalData = BehaviorSubject() ;

}
class DetailsPageViewOutState extends BaseViewOutState {}


