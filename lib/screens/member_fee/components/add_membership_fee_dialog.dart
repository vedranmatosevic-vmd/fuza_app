import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fuza_app/models/Player.dart';
import 'package:fuza_app/repository/data_repository.dart';
import 'package:fuza_app/size_config.dart';
import 'package:intl/intl.dart';

import '../../../style.dart';

class AddMembershipFeeDialog extends StatefulWidget {
  const AddMembershipFeeDialog({Key? key}) : super(key: key);

  @override
  State<AddMembershipFeeDialog> createState() => _AddMembershipFeeDialogState();
}

class _AddMembershipFeeDialogState extends State<AddMembershipFeeDialog> {
  final DataRepository repository = DataRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bDayController = TextEditingController();
  String? name;
  String? lastName;
  DateTime? bDay;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Dodaj igrača',
        style: Style.getTextStyle(
            context, StyleText.headlineThreeMedium, StyleColor.black),
      ),
      content: StreamBuilder<QuerySnapshot>(
        stream: repository.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();

          return buildSingleChildScrollView(context, snapshot.data?.docs ?? []);
        }
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(BuildContext context, List<DocumentSnapshot>? snapshot) {
    List<String> players = [];
    for (var element in snapshot!) {
      final player = Player.fromSnapshot(element);
      players.add("${player.name} ${player.lastName}");
    }
    String? selectedValue = players[0];
    return SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              SizedBox(height: getProportionalScreenHeight(32.0),),
              buildNameFormField(context),
              DropdownButtonFormField2(
                decoration: InputDecoration(
                    labelStyle: Style.getTextStyle(
                        context, StyleText.bodyThreeRegular, StyleColor.darkGray),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Style.colorGray)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Style.colorDarkGray)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Style.colorGray)),
                ),
                items: players.map((e) => DropdownMenuItem<String>(
                  value: e,
                    child: Text(
                      e,
                    )
                )).toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                  });
                },
              ),
              SizedBox(height: getProportionalScreenHeight(16.0),),
              buildMonthFormField(context),
              SizedBox(height: getProportionalScreenHeight(16.0),),
              buildAmountFormField(context),
              SizedBox(height: getProportionalScreenHeight(32.0),),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      debugPrint("Vedran... name: $name last name: $lastName");
                      DateTime? newBDay = _bDayController.text.isEmpty
                          ? DateFormat("dd.MM.yyyy").parse("1.1.1990")
                          : DateFormat("dd.MM.yyyy").parse(_bDayController.text);
                      if (_nameController.text.isNotEmpty && _lastNameController.text.isNotEmpty) {
                        final newPlayer = Player(name: _nameController.text, lastName: _lastNameController.text, bDay: newBDay);
                        repository.addPlayer(newPlayer);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      'Spremi',
                      style: Style.getTextStyle(context, StyleText.bodyTwoMedium, StyleColor.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        );
  }

  TextField buildMonthFormField(BuildContext context) {
    return TextField(
      controller: _bDayController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Mjesec',
        labelStyle: Style.getTextStyle(
            context, StyleText.bodyThreeRegular, StyleColor.darkGray),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Style.colorGray)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Style.colorDarkGray)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Style.colorGray)),
        suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.calendar_month,
              color: Style.colorDarkGray,
            )),
        counterText: ""
      ),
      minLines: 1,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      maxLength: 2,
      cursorColor: Style.colorDarkGray,
      style: Style.getTextStyle(
          context, StyleText.bodyTwoRegular, StyleColor.darkGray),
    );
  }

  TextField buildAmountFormField(BuildContext context) {
    return TextField(
      controller: _lastNameController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Iznos',
        labelStyle: Style.getTextStyle(
            context, StyleText.bodyThreeRegular, StyleColor.darkGray),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Style.colorGray)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Style.colorDarkGray)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Style.colorGray)),
        suffixText: 'kn',
        suffixStyle: Style.getTextStyle(context, StyleText.bodyTwoRegular, StyleColor.darkGray)
      ),
      minLines: 1,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      cursorColor: Style.colorDarkGray,
      style: Style.getTextStyle(
          context, StyleText.bodyTwoRegular, StyleColor.darkGray),
    );
  }

  TextField buildNameFormField(BuildContext context) {
    return TextField(
      controller: _nameController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Član',
        labelStyle: Style.getTextStyle(
            context, StyleText.bodyThreeRegular, StyleColor.darkGray),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Style.colorGray)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Style.colorDarkGray)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Style.colorGray)),
        suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Style.colorDarkGray,
            )
        )
      ),
      minLines: 1,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      cursorColor: Style.colorDarkGray,
      style: Style.getTextStyle(
          context, StyleText.bodyTwoRegular, StyleColor.darkGray),
    );
  }
}
