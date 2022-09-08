import 'package:cloud_firestore/cloud_firestore.dart';

import 'Player.dart';

class MembershipFee {
  String? id;
  final int value;
  final List<Player> players;
  final DateTime dateOfPayment;
  final String? description;
  final int month;

  MembershipFee({
    this.id,
    required this.value,
    required this.players,
    required this.dateOfPayment,
    required this.description,
    required this.month
  });

  factory MembershipFee.fromSnapshot(DocumentSnapshot snapshot) {
    final newMembershipFee = MembershipFee.fromJson(snapshot.data() as Map<String, dynamic>);
    newMembershipFee.id = snapshot.reference.id;
    return newMembershipFee;
  }

  factory MembershipFee.fromJson(Map<String, dynamic> json) => _membershipFeeFromJson(json);

  Map<String, dynamic> toJson() => _membershipFeeToJson(this);

  @override
  String toString() {
    return 'Membership Fee<$dateOfPayment>';
  }

  String dateOfPaymentToString() {
    return "${dateOfPayment.day}.${dateOfPayment.month}.";
  }
}

MembershipFee _membershipFeeFromJson(Map<String, dynamic> json) {
  return MembershipFee(
    value: json['value'] as int,
    dateOfPayment: (json['dateOfPayment'] as Timestamp).toDate(),
    description: json['description'] as String,
    month: json['month'] as int,
    players: _convertPlayers(json['players'] as List<dynamic>)
  );
}

List<Player> _convertPlayers(List<dynamic> playerMap) {
  final players = <Player>[];

  for (final player in playerMap) {
    players.add(Player.fromJson(player as Map<String, dynamic>));
  }

  return players;
}

Map<String, dynamic> _membershipFeeToJson(MembershipFee instance) => <String, dynamic>{
  'value': instance.value,
  'dateOfPayment': instance.dateOfPayment,
  'description': instance.description,
  'month': instance.month,
  'players': _playerList(instance.players),
};

List<Map<String, dynamic>>? _playerList(List<Player>? players) {
  if (players == null) {
    return null;
  }
  final playerMap = <Map<String, dynamic>>[];
  for (var player in players) {
    playerMap.add(player.toJson());
  }
  return playerMap;
}