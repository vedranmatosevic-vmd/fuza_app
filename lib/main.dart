import 'package:flutter/material.dart';
import 'package:fuza_app/routes.dart';
import 'package:fuza_app/screens/home/home_screen.dart';
import 'package:fuza_app/screens/login/login_screen.dart';
import 'package:fuza_app/screens/splash/splash_screen.dart';
import 'theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Futsal škola Zagi',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}