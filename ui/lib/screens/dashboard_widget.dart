import 'package:flutter/material.dart';
import 'package:ui/factory/view_model/bounce_ltr_view_factory.dart';
import 'package:ui/navigation/navigation_service.dart';
import 'package:ui/navigation/service_locator.dart';
import 'package:ui/screens/dashboard_view.dart';
import 'package:ui/services/navigation/routes.dart';

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final DashboardView _view = ViewFactory().get<DashboardView>();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text('hey I am healthy'),
        ElevatedButton(
            child: Text('Goto map'),
            onPressed: () {
              _navigationService.navigateTo(Routes.selectLocation);
            }),
      ],
    ));
  }
}
