import 'package:flutter/material.dart';

showAlertDialog(BuildContext context,
    {String title, String content, String buttonText, Function onPressed}) {
  // set up the buttons
  Widget Button = FlatButton(child: Text(buttonText), onPressed: onPressed);

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      Button,
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
