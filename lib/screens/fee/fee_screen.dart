import 'package:flutter/material.dart';
import '../../models/MembershipFee.dart';
import 'components/body.dart';

class FeeScreen extends StatelessWidget {
  const FeeScreen({Key? key}) : super(key: key);

  static String routeName = "/fee";

  @override
  Widget build(BuildContext context) {
    final membershipFee = ModalRoute.of(context)!.settings.arguments as MembershipFee;
    return Scaffold(
      body: Body(fee: membershipFee),
    );
  }
}
