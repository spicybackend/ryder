import 'package:flutter/material.dart';

abstract class RyderTheme {
  static ThemeData get _commonThemeData => ThemeData(
        primarySwatch: Colors.amber,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 7.5,
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

  static ThemeData get lightTheme => _commonThemeData.copyWith(
        brightness: Brightness.light,
        splashColor: Colors.white24,
        highlightColor: Colors.amber.shade300,
      );

  static ThemeData get darkTheme => _commonThemeData.copyWith(
        brightness: Brightness.dark,
        splashColor: Colors.black26,
        highlightColor: Colors.amber.shade600,
        appBarTheme: AppBarTheme(brightness: Brightness.light),
        scaffoldBackgroundColor: Colors.grey[900],
        indicatorColor: Colors.white,
        canvasColor: Colors.black,
        textTheme: Typography.whiteCupertino,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.grey[200],
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: Colors.grey[400],
        ),
        snackBarTheme: SnackBarThemeData(
          contentTextStyle: TextStyle(color: Colors.white),
        ),
      );
}
