import 'package:flutter/material.dart';

import 'color.dart';

class ThemeX {
  static final _floatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: ColorsX.primary,
  );

  static final _bottomNavigationBarTheme = BottomNavigationBarThemeData(
    selectedItemColor: ColorsX.bluePurple,
    selectedLabelStyle: TextStyle(fontFamily: 'Girl'),
    unselectedLabelStyle: TextStyle(fontFamily: 'Girl'),
  );

  static const colorScheme = ColorScheme.light(
    primary: ColorsX.primary,
  );

  static final global = ThemeData.from(colorScheme: colorScheme).copyWith(
    // textTheme: TextTheme(
    //   subtitle1: TextStyle(
    //     fontFamily: 'Girl',
    //     color: Colors.black,
    //   ),
    //   button: TextStyle(fontFamily: 'Girl'),
    // ),
    appBarTheme: AppBarTheme(
      elevation: .4,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    floatingActionButtonTheme: _floatingActionButtonTheme,
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
    iconTheme: IconThemeData(
      color: ColorsX.grey,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.black,
        onSurface: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        primary: ColorsX.primary,
        onPrimary: Colors.black,
      ),
    ),
  );
}
