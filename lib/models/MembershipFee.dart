import 'Player.dart';

class MembershipFee {
  final int value;
  final List<Player> players;
  final DateTime dateOfPayment;
  final String? description;

  MembershipFee({
    required this.value,
    required this.players,
    required this.dateOfPayment,
    required this.description
  });

  factory MembershipFee.fromJson(Map<String, dynamic> json) => _membershipFeeFromJson(json);

  Map<String, dynamic> toJson() => _membershipFeeToJson(this);

  @override
  String toString() => 'MembershipFee<${players.name} ${players.lastName}, iznos: $value';
}

MembershipFee _membershipFeeFromJson(Map<String, dynamic> json) {
  return MembershipFee(
    json[""]
  );
}