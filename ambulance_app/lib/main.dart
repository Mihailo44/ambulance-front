import 'package:ambulance_app/model/users/basic_user_info.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'dart:ui' as ui;


void main() {
  
  WidgetsFlutterBinding.ensureInitialized();

  String ACCESS_TOKEN = "pk.eyJ1IjoibWlraTQ0IiwiYSI6ImNtMzF5Ym02YzB4MzgyaXM0emI1MDU5ZzgifQ._9G9OUHeitpJ3PNfC2h05A";
  print(ACCESS_TOKEN);
  MapboxOptions.setAccessToken(ACCESS_TOKEN);

  runApp(
    const MyApp(),
  );
}

String accessTokenExpiry = "";
String accessToken = "";
BasicUserInfo? basicUser;
User? loggedUser;

enum Screen{
  victimsScreen,
  allBases,
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  static const ui.Size? minButtonSize = ui.Size(120,45);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Zovi Hitnu",
      //routerConfig: kIsWeb ? router : null,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Colors.amber,
          toolbarHeight: 60,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.amber,
          elevation: 20,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 249, 249, 243),
        textTheme: ThemeData().textTheme.copyWith(
          bodyLarge: const TextStyle(
            fontSize: 26,
            height: 1.3,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            letterSpacing: 0.6,
            //overflow: TextOverflow.ellipsis,
          ),
          bodyMedium: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
          bodySmall: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 3,
              foregroundColor: Colors.blueAccent,
              padding: const EdgeInsets.all(12.0),
              minimumSize: minButtonSize,
              overlayColor: const Color.fromARGB(255, 117, 168, 254),
              animationDuration: const Duration(milliseconds: 100),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
        ),
      ),
    );
  }
}
