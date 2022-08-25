import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuza_app/size_config.dart';

import '../../../models/Player.dart';
import '../../../repository/data_repository.dart';
import '../../../style.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: repository.getStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();

        return _buildList(context, snapshot.data?.docs ?? []);
      }
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
      child: ListView(
        padding: EdgeInsets.only(top:  getProportionalScreenHeight(20.0)),
        children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final player = Player.fromSnapshot(snapshot);
    return PlayerCard(player: player);
  }
}

class PlayerCard extends StatelessWidget {
  const PlayerCard({Key? key, required this.player}) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    "${player.bDay?.day}.${player.bDay?.month}.${player.bDay?.year}",
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
    );
  }
}
