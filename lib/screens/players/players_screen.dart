import 'package:flutter/material.dart';

import '../../style.dart';
import 'components/body.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.colorLightGray,
      body: Body(),
    );
  }
}
