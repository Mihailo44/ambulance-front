import 'package:ambulance_app/navigation/routes.dart';
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
      title: "Ambulance App",
      routerConfig: kIsWeb ? router : null,
    );
  }
}
