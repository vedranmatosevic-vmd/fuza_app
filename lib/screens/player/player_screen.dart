import 'package:flutter/material.dart';

import '../../style.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  static String routeName = "/player";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.colorBlue,
        title: Text(
          "Futsal škola Zagi",
        ),
        actions: <Widget>[
        ],
      ),
    );
  }
}
