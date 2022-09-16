import 'package:flutter/material.dart';

import '../../../style.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Center(
          child: Text('Futsal škola Zagi', style: Style.getTextStyle(context, StyleText.headlineFourMedium)),
        ),
      )
    );
  }
}
