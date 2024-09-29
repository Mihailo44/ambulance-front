import 'package:ambulance_app/navigation/drawer.dart';
import 'package:ambulance_app/navigation/screen_navigation.dart';
import 'package:ambulance_app/screens/home/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(
    MyApp(),
  );
}

final FlutterSecureStorage secureStorage = FlutterSecureStorage();
String accessToken = "";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Login Demo",
      routerConfig: kIsWeb ? router : null,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget currentScreen = HomePage();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Zovi Hitnu"),
      ),
      body: Center(
        child: currentScreen,
      ),
      drawer: const NavDrawer(),
    );
  }
}
