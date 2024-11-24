<<<<<<< HEAD
import 'package:ambulance_app/services/inactivity_service.dart';
import 'package:flutter/material.dart';

class MyNavigationObserver extends NavigatorObserver{
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    InactivityService().resetTimer();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    InactivityService().resetTimer();
  }
}
=======
import 'package:flutter/material.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();
>>>>>>> main
