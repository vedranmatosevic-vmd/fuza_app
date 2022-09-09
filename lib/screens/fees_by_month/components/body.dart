import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuza_app/constants.dart';

import '../../../models/MembershipFee.dart';
import '../../../repository/data_repository.dart';
import '../../../size_config.dart';
import '../../../style.dart';
import 'header.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.month
  }) : super(key: key);

  final int month;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final DataRepository repository = DataRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10.0)),
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: repository.getMemberShipFeesByMonthStream(widget.month),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const LinearProgressIndicator();
              return _buildList(context, snapshot.data?.docs ?? []);
            }
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    List<MembershipFee> membershipFees = <MembershipFee>[];

    for (var element in snapshot!) {
      membershipFees.add(MembershipFee.fromSnapshot(element));
      debugPrint("Vedran... element: ${MembershipFee.fromSnapshot(element).value}");
    }

    membershipFees.sort((a, b) => b.dateOfPayment.millisecondsSinceEpoch.compareTo(a.dateOfPayment.millisecondsSinceEpoch));

    return Column(
      children: <Widget>[
        SizedBox(height: getProportionalScreenHeight(MediaQuery.of(context).viewPadding.top + 20.0),),
        const Header(),
        SizedBox(height: getProportionalScreenHeight(24.0),),
        Text(
          'Članarine za ${months[widget.month - 1]}',
          style: Style.getTextStyle(context, StyleText.headlineThreeMedium, StyleColor.black),
        ),
        SizedBox(height: getProportionalScreenHeight(24.0),),
        ...List.generate(membershipFees.length, (index) => FeeCard(membershipFee: membershipFees[index])),
        SizedBox(height: getProportionalScreenHeight(50.0)),
      ],
    );
  }
}

class FeeCard extends StatelessWidget {
  const FeeCard({
    Key? key,
    required this.membershipFee,
  }) : super(key: key);

  final MembershipFee membershipFee;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionalScreenHeight(8.0),),
        Row(
          children: [
            Icon(
              membershipFee.bankAccount! ? Icons.credit_card_outlined : Icons.attach_money_outlined,
              size: 20,
              color: Style.colorBlue,
            ),
            SizedBox(width: getProportionateScreenWidth(4.0),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10.0), vertical: getProportionalScreenHeight(6.0)),
              decoration: BoxDecoration(
                color: Style.colorUltraLightBlue,
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    membershipFee.dateOfPaymentToString(),
                    style: Style.getTextStyle(context, StyleText.bodyThreeBold, StyleColor.blue),
                  ),
                  Row(
                    children: [
                      Text(
                        '${membershipFee.value} kn',
                        style: Style.getTextStyle(context, StyleText.bodyThreeRegular, StyleColor.blue),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(6.0),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  membershipFee.players[0].toString(),
                  style: Style.getTextStyle(context, StyleText.bodyThreeMedium),
                ),
                Text(
                  membershipFee.players[0].bDayToString(),
                  style: Style.getTextStyle(context, StyleText.bodyThreeRegular, StyleColor.darkGray),
                )
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Style.colorBlue,
              )
            )
          ],
        ),
        SizedBox(height: getProportionalScreenHeight(8.0),),
        Divider(
          height: getProportionalScreenHeight(1.0),
          color: Style.colorGray,
        )
      ],
    );
  }
}