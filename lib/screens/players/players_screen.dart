import 'package:flutter/material.dart';

import '../../components/add_player_dialog.dart';
import '../../style.dart';
import 'components/body.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({Key? key}) : super(key: key);

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.colorBlue,
        title: Text(
          "Futsal škola Zagi",
          style: Style.getTextStyle(context, StyleText.bodyTwoMedium, StyleColor.white),
        ),
        actions: <Widget>[
          buildIActions()
        ],
      ),
      backgroundColor: Style.colorLightGray,
      body: Body(),
    );
  }

  IconButton buildIActions() {
    return IconButton(
            onPressed: () {_addPlayer();},
            icon: const Icon(
              Icons.add,
              color: Style.colorWhite,
            )
        );
  }

  void _addPlayer() {
    showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return const AddPlayerDialog();
        },
    );
  }
}

