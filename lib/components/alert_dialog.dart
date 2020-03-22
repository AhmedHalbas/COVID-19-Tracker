import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

showAlertDialog(BuildContext context,
    {String title, String content, Function onPressed}) {
  // set up the buttons
  Widget cancelButton = FlatButton(child: Text("OK"), onPressed: onPressed);

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      cancelButton,
    ],
  );

  // show the dialog

  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  });
}
