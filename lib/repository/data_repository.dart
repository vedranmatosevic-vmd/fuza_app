import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/MembershipFee.dart';
import '../models/Player.dart';

class DataRepository {
  final CollectionReference playersCollection = FirebaseFirestore.instance.collection('players');
  final CollectionReference membershipFeeCollection = FirebaseFirestore.instance.collection('membership_fees');

  Stream<QuerySnapshot> getPlayersStream() {
    return playersCollection.orderBy("name").snapshots();
  }

  Future<DocumentReference> addPlayer(Player player) {
    return playersCollection.add(player.toJson());
  }

  void updatePlayer(Player player) async {
    await playersCollection.doc(player.id).update(player.toJson());
  }

  void deletePlayer(Player player) async {
    await playersCollection.doc(player.id).delete();
  }

  Stream<QuerySnapshot> getMemberShipFeesStream() {
    return membershipFeeCollection.snapshots();
  }

  Future<DocumentReference> addMembershipFee(MembershipFee membershipFee) {
    return membershipFeeCollection.add(membershipFee.toJson());
  }

  void updateMembershipFee(MembershipFee membershipFee) async {
    await membershipFeeCollection.doc(membershipFee.id).update(membershipFee.toJson());
  }

  void deleteMembershipFee(MembershipFee membershipFee) async {
    await membershipFeeCollection.doc(membershipFee.id).delete();
  }

  Stream<QuerySnapshot> getMemberShipFeesByMonthStream(int month) {
    return membershipFeeCollection.where('month', isEqualTo: month).snapshots();
  }
}