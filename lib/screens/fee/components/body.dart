import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fuza_app/models/MembershipFee.dart';
import 'package:fuza_app/screens/fees_by_month/fees_by_month.dart';

import '../../../repository/data_repository.dart';
import '../../../size_config.dart';
import '../../../style.dart';
import 'fee_actions.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.fee}) : super(key: key);

  final MembershipFee fee;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
        child: Column(
          children: <Widget>[
            SizedBox(height: getProportionalScreenHeight(16.0)),
            const FeeActions(),
            SizedBox(height: getProportionalScreenHeight(24.0),),
            Text(
              fee.players[0].toString(),
              style: Style.getTextStyle(context, StyleText.headlineThreeMedium, StyleColor.black),
            ),
            FeeForm(fee: fee)
          ],
        ),
      ),
    );
  }
}

class FeeForm extends StatefulWidget {
  const FeeForm({
    Key? key,
    required this.fee
  }) : super(key: key);

  final MembershipFee fee;

  @override
  State<FeeForm> createState() => _FeeFormState();
}

class _FeeFormState extends State<FeeForm> {
  final DataRepository repository = DataRepository();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  late bool switchValue;

  @override
  void initState() {
    switchValue = widget.fee.bankAccount!;
    _monthController.text = widget.fee.month.toString();
    _amountController.text = widget.fee.value.toString();
    _remarkController.text = widget.fee.description.toString();
    super.initState();
  }

  @override
  void dispose() {
    _monthController.dispose();
    _amountController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          SizedBox(height: getProportionalScreenHeight(12.0)),
          buildSwitchField(context),
          SizedBox(height: getProportionalScreenHeight(12.0),),
          buildMonthFormField(context),
          SizedBox(height: getProportionalScreenHeight(12.0),),
          buildAmountFormField(context),
          SizedBox(height: getProportionalScreenHeight(12.0),),
          buildRemarkFormField(context),
          Spacer(),
          TextButton(
            onPressed: () {
              MembershipFee newFee = MembershipFee(
                id: widget.fee.id,
                value: int.parse(_amountController.text),
                players: widget.fee.players,
                dateOfPayment: widget.fee.dateOfPayment,
                bankAccount: switchValue,
                description: _remarkController.text,
                month: int.parse(_monthController.text)
              );
              repository.updateMembershipFee(newFee);
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: getProportionalScreenHeight(22.0)),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Style.colorBlue,
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Text(
                'Spremi',
                textAlign: TextAlign.center,
                style: Style.getTextStyle(context, StyleText.bodyTwoMedium, StyleColor.white),
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              showAlertDialog(context);
            },
            icon: const Icon(
              Icons.delete,
              color: Style.colorGray,
            ),
            label: Text(
              'Obriši',
              style: Style.getTextStyle(context, StyleText.bodyThreeRegular, StyleColor.darkGray),
            ),
          ),
          SizedBox(height: getProportionalScreenHeight(20.0)),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        "Potvrdi",
        style: Style.getTextStyle(context, StyleText.bodyThreeRegular, StyleColor.blue),
      ),
      onPressed:  () {
        repository.deleteMembershipFee(widget.fee);
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
    Widget continueButton = TextButton(
      child: Text(""
        "Natrag",
        style: Style.getTextStyle(context, StyleText.bodyThreeRegular),
      ),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Potvrdi brisanje",
        style: Style.getTextStyle(context, StyleText.bodyTwoMedium)
      ),
      content: Text(
        "Jeste li sigurni da želite obrisati članarinu?",
        style: Style.getTextStyle(context, StyleText.bodyThreeRegular)
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Row buildSwitchField(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Račun:',
            style: Style.getTextStyle(context, StyleText.bodyThreeRegular, StyleColor.darkGray),
          ),
          Switch(
              value: switchValue,
              onChanged: (value) {
                setState(() {
                  switchValue = value;
                });
              }
          )
        ],
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
}
