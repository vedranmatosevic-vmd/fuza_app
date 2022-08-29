import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuza_app/size_config.dart';

import '../../../components/player_card.dart';
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
      stream: repository.getPlayersStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
        return _buildList(context, snapshot.data?.docs ?? []);
      }
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical:  getProportionalScreenHeight(20.0)),
      children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final player = Player.fromSnapshot(snapshot);
    return PlayerCard(player: player);
  }
}
