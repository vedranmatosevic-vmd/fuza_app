import 'package:flutter/material.dart';
import 'package:fuza_app/screens/fee/fee_screen.dart';
import 'package:fuza_app/screens/home/home_screen.dart';
import 'package:fuza_app/screens/login/login_screen.dart';
import 'package:fuza_app/screens/player/player_screen.dart';
import 'package:fuza_app/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  PlayerScreen.routeName: (context) => PlayerScreen(),
  FeeScreen.routeName: (context) => FeeScreen(),
};