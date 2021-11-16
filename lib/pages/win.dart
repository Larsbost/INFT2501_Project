import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Win extends StatefulWidget {
  const Win({Key? key}) : super(key: key);

  @override
  State<Win> createState() => _WinState();
}

class _WinState extends State<Win> {
  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    String img = "vant";
    if (lang!.infoButton == "Information") {
      img = "win";
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Padding(
              padding: EdgeInsets.all(30),
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
