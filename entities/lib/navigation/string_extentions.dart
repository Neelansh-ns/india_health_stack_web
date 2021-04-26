import 'package:entities/navigation/routing_data.dart';

extension StringExtention on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    print('queryParameters: ${uriData.queryParameters} path: ${uriData.path}');
    return RoutingData(queryParameters: uriData.queryParameters, route: uriData.path);
  }
}
