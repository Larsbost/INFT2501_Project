import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Loose extends StatefulWidget {
  const Loose({Key? key}) : super(key: key);

  @override
  State<Loose> createState() => _LooseState();
}

class _LooseState extends State<Loose> {
  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    String img = "tapte";
    if(lang!.infoButton == "Information"){
      img = "loose";
    }
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Padding(
              padding: const EdgeInsets.all(30),
              child: Image.asset('assets/$img.png'),

            ),
            const SizedBox(height: 50.0),
            TextButton.icon(
              label: Text(lang.mainMenu),
              icon: const Icon(Icons.album_outlined),
              style: TextButton.styleFrom(
                  primary: Colors.black45,
                  backgroundColor: Colors.indigo,
                  elevation: 10,
                  textStyle: const TextStyle(
                      fontSize: 24, fontStyle: FontStyle.italic)),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

    );
  }
}