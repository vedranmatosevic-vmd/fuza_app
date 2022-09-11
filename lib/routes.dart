import 'package:flutter/material.dart';
import 'package:fuza_app/screens/fee/fee_screen.dart';
import 'package:fuza_app/screens/home/home_screen.dart';
import 'package:fuza_app/screens/player/player_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  PlayerScreen.routeName: (context) => PlayerScreen(),
  FeeScreen.routeName: (context) => FeeScreen(),
};