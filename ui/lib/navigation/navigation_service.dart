import 'package:flutter/material.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replaceRoute(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replaceCompleteRoute(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false, arguments: arguments);
  }

  bool goBack<T extends Object>({T result, String until}) {
    print("goBack called : ${navigatorKey.currentState.context.widget.toStringShort()} $result");
    if (navigatorKey.currentState.canPop()) {
      navigatorKey.currentState.pop(result);
      return true;
    }
  }

  void goBackToInitialRoute<T extends Object>() {
    if (navigatorKey.currentState.canPop())
      return navigatorKey.currentState.popUntil((route) => route.isFirst);
  }

  ///not being used
  void goBackContinuously({@required int count}) {
    int startCount = 0;

    navigatorKey.currentState.popUntil((route) {
      return startCount++ == count;
    });
  }

  Future<dynamic> pushAndRemoveUntil<T extends Object>(String routeName, String routeUntil) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, ModalRoute.withName(routeUntil));
  }
}