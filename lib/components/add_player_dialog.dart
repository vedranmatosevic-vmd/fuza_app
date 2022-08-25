import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuza_app/models/Player.dart';
import 'package:fuza_app/repository/data_repository.dart';
import 'package:fuza_app/size_config.dart';
import 'package:intl/intl.dart';

import '../style.dart';

class AddPlayerDialog extends StatefulWidget {
  const AddPlayerDialog({Key? key}) : super(key: key);

  @override
  State<AddPlayerDialog> createState() => _AddPlayerDialogState();
}

class _AddPlayerDialogState extends State<AddPlayerDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bDayController = TextEditingController();
  String? name;
  String? lastName;
  DateTime? bDay;

  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Dodaj igrača',
        style: Style.getTextStyle(
            context, StyleText.headlineThreeMedium, StyleColor.black),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            SizedBox(height: getProportionalScreenHeight(32.0),),
            buildNameFormField(context),
            SizedBox(height: getProportionalScreenHeight(16.0),),
            buildLastNameFormField(context),
            SizedBox(height: getProportionalScreenHeight(16.0),),
            buildBDayFormField(context),
            SizedBox(height: getProportionalScreenHeight(32.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    debugPrint("Vedran... name: $name last name: $lastName");
                    DateTime newBDay = DateFormat("dd.MM.yyyy").parse(_bDayController.text);
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
      ),
    );
  }

  TextField buildBDayFormField(BuildContext context) {
    return TextField(
      controller: _bDayController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Datum rođenja',
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
        helperText: 'Npr. 11.09.2001',
        helperMaxLines: 1,
        helperStyle: Style.getTextStyle(context, StyleText.bodyFourRegular, StyleColor.gray),
      ),
      minLines: 1,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      cursorColor: Style.colorDarkGray,
      style: Style.getTextStyle(
          context, StyleText.bodyTwoRegular, StyleColor.darkGray),
    );
  }

  TextField buildLastNameFormField(BuildContext context) {
    return TextField(
      controller: _lastNameController,
      decoration: InputDecoration(
        labelText: 'Prezime',
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
      minLines: 1,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      cursorColor: Style.colorDarkGray,
      style: Style.getTextStyle(
          context, StyleText.bodyTwoRegular, StyleColor.darkGray),
    );
  }

  TextField buildNameFormField(BuildContext context) {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Ime',
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
      minLines: 1,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      cursorColor: Style.colorDarkGray,
      style: Style.getTextStyle(
          context, StyleText.bodyTwoRegular, StyleColor.darkGray),
    );
  }
}
