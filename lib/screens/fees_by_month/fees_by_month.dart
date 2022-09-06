import 'package:flutter/material.dart';
import 'package:fuza_app/size_config.dart';

import 'components/body.dart';

class FeesByMonth extends StatelessWidget {
  const FeesByMonth({Key? key, required this.month}) : super(key: key);

  final int month;

  @override
  Widget build(BuildContext context) {
    return Body(month: month);
  }
}