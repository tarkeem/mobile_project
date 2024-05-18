import 'package:flutter/material.dart';

MyDialog(String err,BuildContext context,Color col) {
    final snackBar = SnackBar(
      backgroundColor: col,
  content: Text(err),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);

// Find the Scaffold in the widget tree and use it to show a Snackbar.
ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }