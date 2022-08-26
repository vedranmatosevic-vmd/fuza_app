import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuza_app/models/MembershipFee.dart';
import 'package:fuza_app/models/Player.dart';
import 'package:fuza_app/screens/member_fee/components/section_title.dart';
import 'package:fuza_app/size_config.dart';

import '../../../repository/data_repository.dart';
import '../../../style.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: getProportionalScreenHeight(20.0)),
          child: Column(
            children: <Widget>[
              MembershipFeesByMonths()
            ],
          ),
        ),
      )
    );
  }
}

class MembershipFeesByMonths extends StatefulWidget {
  const MembershipFeesByMonths({
    Key? key,
  }) : super(key: key);

  @override
  State<MembershipFeesByMonths> createState() => _MembershipFeesByMonthsState();
}

class _MembershipFeesByMonthsState extends State<MembershipFeesByMonths> {
  final DataRepository repository = DataRepository();
  final numOfMonths = 11;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: repository.getMemberShipFeesStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
        return _buildList(context, snapshot.data?.docs ?? []);
      }
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    List<MembershipFee>? membershipFees;
    snapshot?.forEach((element) {
      membershipFees?.add(MembershipFee.fromSnapshot(element));
      debugPrint("Vedran... element: ${MembershipFee.fromSnapshot(element).value}");
    });
    return Column(
        children: [
          const SectionTitle(title: 'Članarine po mjesecima',),
          SizedBox(height: getProportionalScreenHeight(16.0),),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(numOfMonths, (index) => MembershipFeeByMonthCard(membershipFees: membershipFees!,)),
                SizedBox(width: getProportionateScreenWidth(20.0),)
              ],
            ),
          ),
        ],
      );
  }
}

class MembershipFeeByMonthCard extends StatelessWidget {
  const MembershipFeeByMonthCard({Key? key, required this.membershipFees}) : super(key: key);

  final List<MembershipFee> membershipFees;

  @override
  Widget build(BuildContext context) {
    var sum = 0;

    for (var element in membershipFees) {
      sum += element.value;
    }

    return Card(
      color: Style.colorLightGray,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('Sum: $sum'),
      ),
    );
  }
}
