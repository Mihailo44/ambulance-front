import 'package:ambulance_app/app_theme.dart';
<<<<<<< HEAD
import 'package:ambulance_app/navigation/observer.dart';
import 'package:ambulance_app/navigation/routes.dart';
import 'package:ambulance_app/screens/auth/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
=======
import 'package:ambulance_app/main_layout.dart';
import 'package:ambulance_app/model/users/basic_user_info.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/navigation/observer.dart';
import 'package:ambulance_app/navigation/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
>>>>>>> main

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

<<<<<<< HEAD
const storage = FlutterSecureStorage();
=======
String accessTokenExpiry = "";
String accessToken = "";
BasicUserInfo? basicUser;
User? loggedUser;
>>>>>>> main

enum Screen {
  victimsScreen,
  allBases,
}

enum Mode{
  delete,
  create,
  display,
  none,
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return MaterialApp.router(
        title: "Zovi Hitnu",
        //routerConfig: kIsWeb ? router : null,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
      );
    } else {
      return MaterialApp(
<<<<<<< HEAD
        //home: const InactivityWrapper(child: ScaffoldForMobile()),
        home: const LoginPage(),
        navigatorObservers: [MyNavigationObserver()],
=======
        home: const ScaffoldForMobile(),
        navigatorObservers: [routeObserver],
>>>>>>> main
        title: "Zovi Hitnu",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
      );
    }
  }
}
