import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget pop_up_dialog(BuildContext context) {
  var lang = AppLocalizations.of(context);
  return AlertDialog(

    backgroundColor: Colors.white70,
    title: Text(
            lang!.infoHeadLine),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            lang.info),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(lang.closeButton),
      ),
    ],
  );
}
