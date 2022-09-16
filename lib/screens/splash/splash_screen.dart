import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuza_app/screens/home/home_screen.dart';
import 'package:fuza_app/screens/login/login_screen.dart';
import '../../size_config.dart';
import 'components/body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> isLoggedIn() async {
    return await FirebaseAuth.instance.authStateChanges().isEmpty;
  }
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      isLoggedIn().then((value) =>
      {
        value ? Navigator.pushNamed(context, HomeScreen.routeName) :
        Navigator.pushNamed(context, LoginScreen.routeName)
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
