import 'package:flutter/material.dart';

import '../../style.dart';
import 'components/body.dart';

class MemberFeeScreen extends StatelessWidget {
  const MemberFeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.colorLightGray,
      body: Body(),
    );
  }
}