class Player {
  final String name;
  final String lastName;
  final DateTime? bDay;

  Player({
    required this.name,
    required this.lastName,
    required this.bDay
  });

  factory Player.fromJson(Map<String, dynamic> json) => _playerFromJson(json);

  Map<String, dynamic> toJson() => _playerToJson(this);

  @override
  String toString() {
    return 'Player<$name $lastName>';
  }
}

Player _playerFromJson(Map<String, dynamic> json) {
  return Player(
    name: json['name'] as String,
    lastName: json['lastName'] as String,
    bDay: (json['bDay'] as Timestamp)
  )
}