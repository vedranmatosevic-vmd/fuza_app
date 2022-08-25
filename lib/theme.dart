import 'package:flutter/material.dart';
import 'package:fuza_app/style.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ).copyWith(colorScheme: ThemeData().colorScheme.copyWith(
    primary: Style.colorDarkGray
  ));
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ),
  );
}