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
      );

  static ThemeData get darkTheme => _commonThemeData.copyWith(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(brightness: Brightness.light),
        scaffoldBackgroundColor: Colors.grey[900],
        indicatorColor: Colors.white,
        canvasColor: Colors.black,
        textTheme: Typography.whiteCupertino,
        iconTheme: IconThemeData(color: Colors.white),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: Colors.grey[400],
        ),
      );
}
