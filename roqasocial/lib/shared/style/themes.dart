

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roqasocial/shared/style/colors.dart';

ThemeData LightTheme = ThemeData(
  primarySwatch: Colors.indigo,
  scaffoldBackgroundColor: Colors.white,
  fontFamily:'pretty',
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: TextStyle(
      fontFamily:'pretty',
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontFamily: 'pretty',
      fontWeight: FontWeight.w700,
      fontSize: 17,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
        fontFamily: 'pretty',
        fontWeight: FontWeight.w100,
        fontSize: 16,
        color: Colors.black
    ),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleSpacing: 15,
    backwardsCompatibility: false,
    titleTextStyle: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      fontFamily:'pretty',
      color: Colors.black,
    ),
    elevation: 0,
    color: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ),

  ),
);

// ThemeData DarkTheme = ThemeData(
//   primarySwatch: Colors.indigo,
//   scaffoldBackgroundColor: Colors.black54,
//   fontFamily:'pretty',
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     backgroundColor: Colors.black54,
//     type: BottomNavigationBarType.fixed,
//     selectedItemColor: defaultColor,
//     unselectedItemColor: Colors.grey,
//     selectedLabelStyle: TextStyle(
//       fontFamily:'pretty',
//       fontWeight: FontWeight.bold,
//     ),
//   ),
//   textTheme: TextTheme(
//     bodyText1: TextStyle(
//       fontFamily: 'pretty',
//       fontWeight: FontWeight.w700,
//       fontSize: 17,
//       color: Colors.white,
//     ),
//     subtitle1: TextStyle(
//         fontFamily: 'pretty',
//         fontWeight: FontWeight.w600,
//         fontSize: 16,
//         color: Colors.white
//     ),
//   ),
//   appBarTheme: AppBarTheme(
//     iconTheme: IconThemeData(
//       color: Colors.white,
//     ),
//     titleSpacing: 15,
//     backwardsCompatibility: false,
//     titleTextStyle: TextStyle(
//       fontSize: 23,
//       fontWeight: FontWeight.bold,
//       fontFamily:'pretty',
//       color: Colors.white,
//     ),
//     elevation: 0,
//     color: Colors.black54,
//     systemOverlayStyle: SystemUiOverlayStyle(
//       statusBarColor: Colors.white,
//       statusBarIconBrightness: Brightness.dark,
//       systemNavigationBarColor: Colors.white,
//     ),
//
//   ),
// );