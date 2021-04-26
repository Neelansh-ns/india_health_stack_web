import 'package:get_it/get_it.dart';
import 'package:ui/navigation/bottom_sheet_service.dart';
import 'package:ui/navigation/navigation_service.dart';

GetIt locator = GetIt.instance;

void setUpServices() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => BottomSheetService());
}
