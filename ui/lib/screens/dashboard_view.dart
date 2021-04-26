import 'package:ui/factory/core/base_view.dart';
import 'package:ui/factory/core/base_view_out_state.dart';
import 'package:ui/factory/core/base_view_state.dart';

class DashboardView
    extends BaseView<DashboardViewState, DashboardViewOutState> {
  @override
  initializeOutState() {
    return DashboardViewOutState();
  }

  @override
  initializeState() {
    return DashboardViewState();
  }
}

class DashboardViewState extends BaseViewState {}

class DashboardViewOutState extends BaseViewOutState {}
