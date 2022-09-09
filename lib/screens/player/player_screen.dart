import 'package:flutter/material.dart';

import '../../style.dart';
import 'components/body.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  static String routeName = "/player";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.colorLightGray,
      body: Body(),
    );
  }
}
