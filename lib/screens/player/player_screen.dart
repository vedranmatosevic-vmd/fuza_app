import 'package:flutter/material.dart';

import '../../models/Player.dart';
import '../../style.dart';
import 'components/body.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  static String routeName = "/player";

  @override
  Widget build(BuildContext context) {
    final player = ModalRoute.of(context)!.settings.arguments as Player;
    return Scaffold(
      body: Body(player: player),
    );
  }
}
