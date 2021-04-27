import 'package:ui/factory/core/base_view.dart';
import 'package:ui/factory/core/base_view_out_state.dart';
import 'package:ui/factory/core/base_view_state.dart';

class DetailsPageView extends BaseView<DetailsPageViewState, DetailsPageViewOutState> {
  @override
  DetailsPageViewOutState initializeOutState() {
    return DetailsPageViewOutState();
  }

  @override
  DetailsPageViewState initializeState() {
    return DetailsPageViewState();
  }

   onOpen() {

   }
}

class DetailsPageViewOutState extends BaseViewOutState {}

class DetailsPageViewState extends BaseViewState {}
