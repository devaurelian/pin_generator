import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showSnackBar(ScaffoldState scaffoldState, String text) {
  print('showSnackBar: $text');
  scaffoldState.showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<void> copyToClipboard(ScaffoldState scaffoldState, String text) async {
//  await Clipboard.setData(ClipboardData(text: text))
//      .then((_) => showSnackBar(scaffoldState, 'Copied to clipboard'))
//      .catchError(
//          (Object error) => showSnackBar(scaffoldState, 'Error $error'));

  try {
    await Clipboard.setData(ClipboardData(text: text));
    showSnackBar(scaffoldState, 'Copied to clipboard');
  } catch (error) {
    showSnackBar(scaffoldState, 'Error $error');
  }
}

//void copyToClipboard(BuildContext context, String text) {
//  Clipboard.setData(ClipboardData(text: text))
//      .then((_) => showSnackBar(context, 'Copied to clipboard'))
//      .catchError((Object error) => showSnackBar(context, 'Error $error'));
//}
