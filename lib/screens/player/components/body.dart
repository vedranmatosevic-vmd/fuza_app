import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fuza_app/screens/player/components/player_actions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../models/Player.dart';
import '../../../repository/data_repository.dart';
import '../../../size_config.dart';
import '../../../style.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.player}) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
        child: Column(
          children: <Widget>[
            SizedBox(height: getProportionalScreenHeight(16.0)),
            const PlayerActions(),
            SizedBox(height: getProportionalScreenHeight(24.0),),
            Text(
              player.toString(),
              style: Style.getTextStyle(context, StyleText.headlineThreeMedium, StyleColor.black),
            ),
            PlayerForm(player: player),
          ],
        ),
      ),
    );
  }
}

class PlayerForm extends StatefulWidget {
  const PlayerForm({Key? key, required this.player}) : super(key: key);

  final Player player;

  @override
  State<PlayerForm> createState() => _PlayerFormState();
}

class _PlayerFormState extends State<PlayerForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bDayController = TextEditingController();

  final DataRepository repository = DataRepository();

  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    String imagePath = FirebaseAuth.instance.currentUser!.email == "ivan.matan2406@gmail.com" ? 'dubravaImages' : 'images';
    final path = 'files/$imagePath/profileImages/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);

    File compressedFile = await FlutterNativeImage.compressImage(pickedFile!.path!, quality: 20);

    setState(() {
      uploadTask = ref.putFile(compressedFile);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download link: $urlDownload');

    Player newPlayer = Player(
        id: widget.player.id,
        name: _nameController.text,
        lastName: _lastNameController.text,
        bDay: DateFormat("dd.MM.yyyy").parse(_bDayController.text),
        image: urlDownload
    );

    repository.updatePlayer(newPlayer);

    setState(() {
      uploadTask = null;
    });
  }

  @override
  void initState() {
    _nameController.text = widget.player.name;
    _lastNameController.text = widget.player.lastName;
    _bDayController.text = widget.player.bDayToStringFormat();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bDayController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          SizedBox(height: getProportionalScreenHeight(22.0),),
          pickedFile == null && widget.player.image!.isEmpty ? InkWell(
            onTap: () {
              selectFile();
            },
            child: Text(
              'Upload photo',
              style: Style.getTextStyle(context, StyleText.bodyFourRegular, StyleColor.black, null, true, true),
            ),
          ) : Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: widget.player.image!.isNotEmpty
                  ? Image.network(
                    widget.player.image!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitWidth,
                  )
                  : Image.file(
                    File(pickedFile!.path!),
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitWidth,
                  ),
            ),
          ),
          SizedBox(height: getProportionalScreenHeight(46.0),),
          buildNameFormField(context),
          SizedBox(height: getProportionalScreenHeight(16.0),),
          buildLastNameFormField(context),
          SizedBox(height: getProportionalScreenHeight(16.0),),
          buildBDayFormField(context),
          SizedBox(height: getProportionalScreenHeight(32.0),),
          const Spacer(),
          TextButton(
            onPressed: () {
              uploadFile();
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
        repository.deletePlayer(widget.player);
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
          "Jeste li sigurni da želite obrisati igrača?",
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
      textCapitalization: TextCapitalization.sentences,
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
      textCapitalization: TextCapitalization.sentences,
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

