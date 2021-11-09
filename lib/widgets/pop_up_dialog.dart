import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget pop_up_dialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: Colors.white70,
    title: const Text('Hvordan spille?'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
            "Her kommer beskrivelsen av spillet å være. Plis gjør boksen litt finere a, din tøs"),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Lukk'),
      ),
    ],
  );
}
