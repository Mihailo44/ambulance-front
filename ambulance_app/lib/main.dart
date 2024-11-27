import 'package:ambulance_app/app_theme.dart';
import 'package:ambulance_app/navigation/observer.dart';
import 'package:ambulance_app/navigation/routes.dart';
import 'package:ambulance_app/screens/auth/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

const storage = FlutterSecureStorage();

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
        home: const LoginPage(),
        navigatorObservers: [MyNavigationObserver()],
        title: "Zovi Hitnu",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
      );
    }
  }
}
