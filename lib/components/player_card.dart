import 'package:flutter/material.dart';
import 'package:fuza_app/screens/player/player_screen.dart';
import 'package:fuza_app/screens/players/players_screen.dart';

import '../models/Player.dart';
import '../size_config.dart';
import '../style.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({Key? key, required this.player}) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(getProportionateScreenWidth(10.0), 0, getProportionateScreenWidth(10.0), getProportionalScreenHeight(10.0)),
      child: Container(
        decoration: BoxDecoration(
            color: Style.colorWhite,
            borderRadius: BorderRadius.circular(12.0)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, PlayerScreen.routeName, arguments: player);
            },
            child: Row(
              children: <Widget>[
                Container(
                  width: 34.0,
                  height: 34.0,
                  decoration: BoxDecoration(
                      color: Style.colorLightGray,
                      borderRadius: BorderRadius.circular(27.0)
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 32.0,
                    color: Style.colorWhite,
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(12.0),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${player.name} ${player.lastName}",
                      style: Style.getTextStyle(context, StyleText.bodyThreeRegular, StyleColor.black),
                    ),
                    SizedBox(height: getProportionalScreenHeight(4.0),),
                    Text(
                      player.bDay != null ? "${player.bDay?.day}.${player.bDay?.month}.${player.bDay?.year}" : "",
                      style: Style.getTextStyle(context, StyleText.bodyFourRegular, StyleColor.darkGray),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Style.colorBlue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
