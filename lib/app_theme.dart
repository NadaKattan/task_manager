import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xff5D9CEC);
  static const Color lightBackground = Color(0xffDFECDB);
  static const Color darkBackground = Color(0xff060E1E);
  static const Color red = Color(0xffEC4B4B);
  static const Color green = Color(0xff61E757);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff363636);
  static const Color navBlack = Color(0xff141922);
  static const Color grey = Color(0xffC8C9CB);
  static ThemeData lightThemeData = ThemeData(
      primaryColor: primary,
      textTheme: const TextTheme(
        headlineSmall:
            TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: white),
        titleLarge:
            TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: black),
        labelMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: black,
        ),
      ),
      scaffoldBackgroundColor: lightBackground,
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: white,
        selectedItemColor: primary,
        unselectedItemColor: grey,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: CircleBorder(side: BorderSide(width: 4, color: white)),
      ));
  static ThemeData darkThemeData = ThemeData(
    primaryColor: primary,
    textTheme: const TextTheme(
        headlineSmall:
            TextStyle(fontSize: 25, fontWeight: FontWeight.w400, color: black),
        titleLarge:
            TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: black)),
    scaffoldBackgroundColor: darkBackground,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: navBlack,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: navBlack,
      selectedItemColor: primary,
      unselectedItemColor: white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(side: BorderSide(width: 4, color: navBlack)),
    ),
  );
}
