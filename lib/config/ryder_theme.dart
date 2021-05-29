import 'package:flutter/material.dart';

abstract class RyderTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.amber,
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 7.0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 5.0,
          shadowColor: Colors.black.withAlpha(10),
        ),
      ),
    );
  }

  static ThemeData get darkTheme => lightTheme.copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
      );
}
