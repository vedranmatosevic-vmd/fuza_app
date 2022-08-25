import 'package:flutter/material.dart';
import 'package:fuza_app/screens/member_fee/components/section_title.dart';
import 'package:fuza_app/size_config.dart';

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
              Column(
                children: [
                  const SectionTitle(title: 'Članarine po mjesecima',),
                  SizedBox(height: getProportionalScreenHeight(16.0),),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // ...List.generate(demoExercises.length, (index) => ExerciseCard(exercise: demoExercises[index])),
                        // SizedBox(width: getProportionateScreenWidth(20.0),)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}