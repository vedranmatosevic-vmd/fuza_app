import 'package:flutter/material.dart';

import '../models/Player.dart';
import '../size_config.dart';
import '../style.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({Key? key, required this.player}) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {},
            child: Row(
              children: <Widget>[
                Container(
                  width: 54.0,
                  height: 54.0,
                  decoration: BoxDecoration(
                      color: Style.colorLightGray,
                      borderRadius: BorderRadius.circular(27.0)
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 42.0,
                    color: Style.colorWhite,
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(12.0),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${player.name} ${player.lastName}",
                      style: Style.getTextStyle(context, StyleText.bodyTwoMedium, StyleColor.black),
                    ),
                    SizedBox(height: getProportionalScreenHeight(4.0),),
                    Text(
                      player.bDay != null ? "${player.bDay?.day}.${player.bDay?.month}.${player.bDay?.year}" : "",
                      style: Style.getTextStyle(context, StyleText.bodyThreeRegular, StyleColor.darkGray),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: Style.colorBlue
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_right,
                    color: Style.colorWhite,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}