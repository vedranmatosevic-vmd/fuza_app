import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuza_app/models/MembershipFee.dart';
import 'package:fuza_app/models/Player.dart';
import 'package:fuza_app/screens/fees_by_month/fees_by_month.dart';
import 'package:fuza_app/screens/member_fee/components/section_title.dart';
import 'package:fuza_app/size_config.dart';

import '../../../constants.dart';
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
  final sortedMonths = <int>[8,9,10,11,12,1,2,3,4,5,6,7];
  final numOfMonths = 11;

  late ScrollController controller;
  final selectedItemKey = GlobalKey();

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

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
    List<MembershipFee> membershipFees = <MembershipFee>[];

    for (var element in snapshot!) {
      membershipFees.add(MembershipFee.fromSnapshot(element));
      debugPrint("Vedran... element: ${MembershipFee.fromSnapshot(element).value}");
    }

    membershipFees.sort((b, a) => a.dateOfPayment.compareTo(b.dateOfPayment));

    if (controller.positions.isNotEmpty) {
      controller.position.ensureVisible(
          selectedItemKey.currentContext!.findRenderObject()!,
          alignment: 0.25,
          duration: const Duration(milliseconds: 500));
    }

    return Column(
        children: [
          const SectionTitle(title: 'Članarine po mjesecima',),
          SizedBox(height: getProportionalScreenHeight(16.0),),
          SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                SizedBox(width: getProportionateScreenWidth(4.0),),
                ...List.generate(sortedMonths.length, (index) => MembershipFeeByMonthCard(
                  membershipFees: membershipFees,
                  month: sortedMonths[index],
                  itemKey: sortedMonths[index] == DateTime.now().month ? selectedItemKey : null,
                )),
                SizedBox(width: getProportionateScreenWidth(20.0),)
              ],
            ),
          ),
        ],
      );
  }
}

class MembershipFeeByMonthCard extends StatelessWidget {
  const MembershipFeeByMonthCard({Key? key, required this.membershipFees, required this.month, this.itemKey}) : super(key: key);

  final List<MembershipFee> membershipFees;
  final int month;
  final GlobalKey? itemKey;

  @override
  Widget build(BuildContext context) {

    var sumInCash = 0;
    var count = 0;
    var sumInBank = 0;
    var year = month > 7 && month <= 12 ? DateTime.now().year : DateTime.now().year + 1;

    for (var element in membershipFees) {
      if (element.month == month) {
        if (element.bankAccount!) {
          sumInBank += element.value;
        } else {
          sumInCash += element.value;
        }
        count++;
      }
    }

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FeesByMonth(month: month)));
      },
      child: Padding(
        key: itemKey,
        padding: EdgeInsets.only(left: getProportionateScreenWidth(16.0)),
        child: Container(
          width: getProportionateScreenWidth(320.0),
          padding: EdgeInsets.all(getProportionateScreenWidth(16.0)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getProportionateScreenWidth(20.0)),
              color: Style.colorWhite
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${months[month - 1]}, $year.',
                    style: Style.getTextStyle(context, StyleText.headlineThreeMedium, StyleColor.extraDarkGray),
                  )
                ],
              ),
              SizedBox(height: getProportionalScreenHeight(16.0),),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Račun',
                        style: Style.getTextStyle(context, StyleText.bodyThreeMedium, StyleColor.extraDarkGray),
                      ),
                      SizedBox(height: getProportionalScreenHeight(4.0)),
                      Text(
                        '${sumInBank.toStringAsFixed(2)} HRK',
                        style: Style.getTextStyle(context, StyleText.bodyThreeRegular, StyleColor.darkGray),
                      ),
                      SizedBox(height: getProportionalScreenHeight(4.0)),
                      Text(
                          '${(sumInBank / 7.53).toStringAsFixed(2)} EUR',
                        style: Style.getTextStyle(context, StyleText.bodyThreeRegular, StyleColor.darkGray),
                      ),
                      SizedBox(height: getProportionalScreenHeight(12.0)),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gotovina',
                        style: Style.getTextStyle(context, StyleText.bodyThreeMedium, StyleColor.extraDarkGray),
                      ),
                      SizedBox(height: getProportionalScreenHeight(4.0)),
                      Text(
                        '${sumInCash.toStringAsFixed(2)} HRK',
                        style: Style.getTextStyle(context, StyleText.bodyThreeRegular, StyleColor.darkGray),
                      ),
                      SizedBox(height: getProportionalScreenHeight(4.0)),
                      Text(
                        '${(sumInCash / 7.53).toStringAsFixed(2)} EUR',
                        style: Style.getTextStyle(context, StyleText.bodyThreeRegular, StyleColor.darkGray),
                      ),
                      SizedBox(height: getProportionalScreenHeight(12.0)),
                    ],
                  ),
                ],
              ),
              Divider(
                height: getProportionalScreenHeight(1.0),
                color: Style.colorLightGray,
              ),
              SizedBox(height: getProportionalScreenHeight(16.0),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(4.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.account_balance_sharp,
                              color: Style.colorBlue,
                            ),
                            SizedBox(width: getProportionateScreenWidth(10.0),),
                            Text(
                              '${(sumInBank + sumInCash).toStringAsFixed(2)} HRK / ${((sumInBank + sumInCash) / 7.53).toStringAsFixed(2)} EUR',
                              style: Style.getTextStyle(context, StyleText.bodyFiveRegular, StyleColor.extraDarkGray),
                            )
                          ],
                        ),
                        SizedBox(height: getProportionalScreenHeight(12.0),),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.assessment_outlined,
                              color: Style.colorBlue,
                            ),
                            SizedBox(width: getProportionateScreenWidth(10.0),),
                            Text(
                              '$count',
                              style: Style.getTextStyle(context, StyleText.bodyFiveRegular, StyleColor.extraDarkGray),
                            )
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(12.0), vertical: getProportionalScreenHeight(10.0)),
                      decoration: BoxDecoration(
                          color: Style.colorBlue,
                          borderRadius: BorderRadius.circular(getProportionateScreenWidth(64.0))
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/ic_arrow_right.svg",
                        width: getProportionateScreenWidth(20.0),
                        height: getProportionalScreenHeight(20.0),
                        color: Style.colorWhite,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
