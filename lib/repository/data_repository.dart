import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Player.dart';

class DataRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection('players');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addPlayer(Player player) {
    return collection.add(player.toJson());
  }

  void updatePlayer(Player player) async {
    await collection.doc(player.id).update(player.toJson());
  }

  void deletePlayer(Player player) async {
    await collection.doc(player.id).delete();
  }
}