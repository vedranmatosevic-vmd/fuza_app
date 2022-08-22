import 'package:flutter/material.dart';

import '../../style.dart';
import 'components/body.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.colorLightGray,
      body: Body(),
    );
  }
}
