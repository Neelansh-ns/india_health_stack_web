import 'package:flutter/material.dart';
import 'package:ui/factory/module/india_healthstack_module.dart';
import 'package:ui/factory/view_model/bounce_ltr_view_factory.dart';
import 'package:ui/navigation/navigation_service.dart';
import 'package:ui/navigation/service_locator.dart';
import 'package:ui/services/navigation/router.dart';
import 'package:ui/services/navigation/routes.dart';
import 'package:oktoast/oktoast.dart';

void main() async {
  print('INIT MAIN');
  WidgetsFlutterBinding.ensureInitialized();
  print('INIT MAIN after ensureInitialized');
  runApp(IndiaHealthStackApp());


  setUpServices();
  IndiaHealthStackModule();
  await ViewFactory().initialise();
}

class IndiaHealthStackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "India Health Stack",
        builder: (context, child) => BounceThemeWrapper(
          child: child,
        ),
        navigatorObservers: [routeObserver],
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: generateRoute,
        onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => Scaffold(
              backgroundColor: Colors.black12,
              body: Center(
                  child: Container(
                    child: Text('Are you lost!!'),
                  )),
            ),
            settings: settings),
//      routes: {
//        '/homee': (context) => HomePage(),
//      },
        initialRoute: Routes.EntryRouteWidget,
//      home: EntryRouteWidget(),
      ),
    );
  }
}

class BounceThemeWrapper extends StatefulWidget {
  final Widget child;

  BounceThemeWrapper({@required this.child});

  @override
  _BounceThemeWrapperState createState() => _BounceThemeWrapperState();
}

class _BounceThemeWrapperState extends State<BounceThemeWrapper> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('INIT MAIN in EntryRouteWidget');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bounce LTR",
//      navigatorKey: locator<NavigationService>().navigatorKey,
//      onGenerateRoute: generateRoute,
      theme: ThemeData(
        primaryColor: Color(0xffff4c5a),
        accentColor: Color(0xffff4c5a),
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
      ),
      home: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          body: Container(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

