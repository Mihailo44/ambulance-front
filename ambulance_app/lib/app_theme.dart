import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AppTheme {
  static const ui.Size? minButtonSize = ui.Size(140, 56);
  //static const ui.Size? minTileButtonSize = ui.Size(110, 49);

  static ThemeData get theme {
    return ThemeData().copyWith(
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: Colors.amber,
        toolbarHeight: 60,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.amber,
        elevation: 20,
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 253, 253, 247),
      textTheme: ThemeData().textTheme.copyWith(
            headlineLarge: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            headlineMedium: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            bodyLarge: const TextStyle(
              fontSize: 26,
              height: 1.3,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              letterSpacing: 0.6,
              overflow: TextOverflow.visible,
            ),
            bodyMedium: const TextStyle(
              fontSize: 23,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              overflow: TextOverflow.visible,
            ),
            bodySmall: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              overflow: TextOverflow.visible,
            ),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 248, 255, 253),
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
    );
  }
}
