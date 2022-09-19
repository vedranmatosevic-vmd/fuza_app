import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuza_app/screens/home/home_screen.dart';
import 'package:fuza_app/size_config.dart';

import '../../../service/login_service.dart';
import '../../../style.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginForm()
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginService loginService = LoginService();
  final key = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        children: <Widget>[
          buildUsernameFormField(context),
          SizedBox(height: getProportionalScreenHeight(18.0)),
          buildPasswordFormField(context),
          SizedBox(height: getProportionalScreenHeight(56.0)),
          TextButton(
            onPressed: signIn,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero
            ),
            child: Container(
              width: double.infinity,
              height: getProportionalScreenHeight(56.0),
              decoration: BoxDecoration(
                color: Style.colorBlue,
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Center(
                child: Text(
                  'Prijava',
                  style: Style.getTextStyle(context, StyleText.bodyThreeMedium, StyleColor.white),
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    if (FirebaseAuth.instance.currentUser != null) {
      if (mounted) {
        loginService.setIsLoggedIn(true);
        await Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
      }
    }
  }

  TextFormField buildPasswordFormField(BuildContext context) {
    return TextFormField(
          controller: passwordController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "Lozinka",
            labelStyle: Style.getTextStyle(
                context, StyleText.bodyThreeRegular, StyleColor.black),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Style.colorGray, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Style.colorDarkGray, width: 1.0),
            ),
          ),
        );
  }

  TextFormField buildUsernameFormField(BuildContext context) {
    return TextFormField(
      controller: emailController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Korisničko ime",
        labelStyle: Style.getTextStyle(
            context, StyleText.bodyThreeRegular, StyleColor.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Style.colorGray, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Style.colorDarkGray, width: 1.0),
        ),
      ),
    );
  }
}
