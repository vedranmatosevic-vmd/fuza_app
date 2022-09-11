import 'package:flutter/material.dart';

import '../../../style.dart';

class FeeActions extends StatelessWidget {
  const FeeActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              color: Style.colorBlack,
              size: 32,
            )
        )
      ],
    );
  }
}