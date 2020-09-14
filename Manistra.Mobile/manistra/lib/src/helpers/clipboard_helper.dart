import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipboardHelper {
  copy(BuildContext context, String text) {
    Clipboard.setData(new ClipboardData(text: text)).then((_) {
      final scaffoldState = Scaffold.of(context);

      scaffoldState.hideCurrentSnackBar();
      scaffoldState.showSnackBar(SnackBar(
        content: Text("Copied to clipboard."),
      ));
    });
  }
}
