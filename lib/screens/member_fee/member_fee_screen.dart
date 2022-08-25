import 'package:flutter/material.dart';

import '../../style.dart';
import 'components/add_membership_fee_dialog.dart';
import 'components/body.dart';

class MemberFeeScreen extends StatefulWidget {
  const MemberFeeScreen({Key? key}) : super(key: key);

  @override
  State<MemberFeeScreen> createState() => _MemberFeeScreenState();
}

class _MemberFeeScreenState extends State<MemberFeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.colorBlue,
        title: Text(
          "Futsal škola Zagi",
          style: Style.getTextStyle(context, StyleText.bodyTwoMedium, StyleColor.white),
        ),
        actions: <Widget>[
          buildIActions()
        ],
      ),
      backgroundColor: Style.colorLightGray,
      body: Body(),
    );
  }

  IconButton buildIActions() {
    return IconButton(
        onPressed: () {
          _addMembershipFee();
        },
        icon: const Icon(
          Icons.add,
          color: Style.colorWhite,
        )
    );
  }

  void _addMembershipFee() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return const AddMembershipFeeDialog();
      },
    );
  }
}
