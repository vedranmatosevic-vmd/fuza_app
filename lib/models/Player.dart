import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  String? id;
  final String name;
  final String lastName;
  final DateTime? bDay;
  final String? image;

  Player({
    this.id,
    required this.name,
    required this.lastName,
    required this.bDay,
    this.image = ""
  });

  factory Player.fromSnapshot(DocumentSnapshot snapshot) {
    final newPlayer = Player.fromJson(snapshot.data() as Map<String, dynamic>);
    newPlayer.id = snapshot.reference.id;
    return newPlayer;
  }

  factory Player.fromJson(Map<String, dynamic> json) => _playerFromJson(json);

  Map<String, dynamic> toJson() => _playerToJson(this);

  @override
  String toString() {
    return '$name $lastName';
  }

  bool equals(String value) {
    return value == toString();
  }

  String bDayToString() {
    return "${bDay?.day}.${bDay?.month}.${bDay?.year}.";
  }

  String bDayToStringFormat() {
    return "${bDay?.day}.${bDay?.month}.${bDay?.year}";
  }

}

Player _playerFromJson(Map<String, dynamic> json) {
  return Player(
    name: json['name'] as String,
    lastName: json['lastName'] as String,
    image: json['image'] as String?,
    bDay: (json['bDay'] as Timestamp).toDate()
  );
}

Map<String, dynamic> _playerToJson(Player instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lastName': instance.lastName,
      'image': instance.image,
      'bDay': instance.bDay,
    };