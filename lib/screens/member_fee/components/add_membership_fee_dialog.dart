import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fuza_app/models/MembershipFee.dart';
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
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Nova članarina',
        style: Style.getTextStyle(
            context, StyleText.headlineThreeMedium, StyleColor.black),
      ),
      content: StreamBuilder<QuerySnapshot>(
        stream: repository.getPlayersStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();

          return buildSingleChildScrollView(context, snapshot.data?.docs ?? []);
        }
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(BuildContext context, List<DocumentSnapshot>? snapshot) {
    List<Player> players = [];
    for (var element in snapshot!) {
      final player = Player.fromSnapshot(element);
      players.add(player);
    }
    return SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              SizedBox(height: getProportionalScreenHeight(32.0),),
              // buildNameFormField(context),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField2(
                  hint: Text("Igrač", style: Style.getTextStyle(context, StyleText.bodyThreeRegular, StyleColor.darkGray),),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero
                  ),
                  style: Style.getTextStyle(context, StyleText.bodyThreeRegular, StyleColor.darkGray),
                  buttonHeight: 60,
                  buttonWidth: 160,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                  ),
                  items: players.map((player) => DropdownMenuItem<String>(
                    value: player.toString(),
                    child: Text(
                      player.toString(),
                    )
                  )).toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String?;
                      // TODO VEDRAN find way to save player
                    });
                  },
                ),
              ),
              SizedBox(height: getProportionalScreenHeight(16.0),),
              buildMonthFormField(context),
              SizedBox(height: getProportionalScreenHeight(16.0),),
              buildAmountFormField(context),
              SizedBox(height: getProportionalScreenHeight(16.0),),
              buildRemarkFormField(context),
              SizedBox(height: getProportionalScreenHeight(32.0),),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      debugPrint("Vedran... user: $selectedValue");
                      Player? newPlayer;
                      for (var element in players) {
                        if (element.equals(selectedValue!)) {
                          newPlayer = element;
                        }
                      }
                      final listOfPlayers = <Player>[];
                      listOfPlayers.add(newPlayer!);
                      if (_amountController.text.isNotEmpty && _monthController.text.isNotEmpty) {
                        final newMembershipFee = MembershipFee(
                            value: int.parse(_amountController.text),
                            players: listOfPlayers,
                            dateOfPayment: DateTime.now(),
                            description: _remarkController.text,
                            month: int.parse(_monthController.text)
                        );
                        repository.addMembershipFee(newMembershipFee);
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

  TextField buildRemarkFormField(BuildContext context) {
    return TextField(
              controller: _remarkController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'Napomena',
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
              minLines: 2,
              maxLines: 2,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              cursorColor: Style.colorDarkGray,
              style: Style.getTextStyle(
                  context, StyleText.bodyTwoRegular, StyleColor.darkGray),
            );
  }

  TextField buildMonthFormField(BuildContext context) {
    return TextField(
      controller: _monthController,
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
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      maxLength: 2,
      cursorColor: Style.colorDarkGray,
      style: Style.getTextStyle(
          context, StyleText.bodyTwoRegular, StyleColor.darkGray),
    );
  }

  TextField buildAmountFormField(BuildContext context) {
    return TextField(
      controller: _amountController,
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
}
