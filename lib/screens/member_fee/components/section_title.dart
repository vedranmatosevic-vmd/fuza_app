import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../../style.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
      child: Row(
        children: [
          Text(
            title,
            style: Style.getTextStyle(context, StyleText.bodyTwoMedium),
          ),
        ],
      ),
    );
  }
}