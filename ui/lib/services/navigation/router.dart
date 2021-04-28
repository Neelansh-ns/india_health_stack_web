import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui/screens/details_page/details_page_widget.dart';
import 'package:ui/services/navigation/routes.dart';
import 'package:entities/navigation/string_extentions.dart';
import 'package:ui/set_map_location/set_location_on_map_widget.dart';
import 'package:ui/screens/dashboard_widget.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData;
  switch (routingData.route) {
    case Routes.EntryRouteWidget:
      return MaterialPageRoute(
          builder: (context) => DashboardWidget(), settings: settings);
    case Routes.selectLocation:
      var parameters = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (context) => SetLocationOnMapWeb(null), settings: settings);
    case Routes.detailsPage:
      String uniqueId;
      var parameters = settings.arguments as Map<String, dynamic>;
      if (routingData["uniqueID"] == null) {
        print(routingData["uniqueID"]);
        uniqueId = parameters["uniqueID"];
      } else {
        print(routingData["uniqueID"]);
        uniqueId = routingData["uniqueID"];
      }
      return MaterialPageRoute(
          builder: (context) => DetailsPageWidget(uniqueId),
          settings: settings);
    // case Routes.IFrameScreen:
    //   var parameters = settings.arguments as Map<String, dynamic>;
    //   return MaterialPageRoute(
    //       builder: (context) => IFrameScreen(parameters['url']), settings: settings);

    ///Default case will be handled by onUnknownRoute in MaterialApp

//    default:
//      var paymentsRoute = payments.generateRoute(settings);
//      if (paymentsRoute != null) return paymentsRoute;
//      var bfRoute = bf.generateRoute(settings);
//      if (bfRoute != null) return bfRoute;
//      return MaterialPageRoute(
//        settings: settings,
//        builder: (context) => Scaffold(
//          body: Center(
//            child: Text('No path for ${settings.name}'),
//          ),
//        ),
//      );
  }
}
