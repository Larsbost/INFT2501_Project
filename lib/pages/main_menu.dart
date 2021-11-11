import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inft2501_prosjekt/pages/hangman_game.dart';
import 'package:inft2501_prosjekt/widgets/pop_up_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainMenu extends StatefulWidget {
  @override
  State<MainMenu> createState() => _MainMenuState();

  static _MainMenuState? of(BuildContext context) => context.findAncestorStateOfType<_MainMenuState>();

}

class _MainMenuState extends State<MainMenu> {

  late Locale _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }



  late List<bool> isSelected;

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/hangman_txt.png'),
            ),
            const Image(
              image: AssetImage('assets/hangman_logo.png'),
            ),
            TextButton.icon(
              label: Text(lang!.playButton),
              icon: const Icon(Icons.accessibility_new),
              style: TextButton.styleFrom(
                  primary: Colors.black45,
                  backgroundColor: Colors.indigo,
                  elevation: 10,
                  textStyle: const TextStyle(
                      fontSize: 24, fontStyle: FontStyle.italic)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Hangman()));
              },
            ),
            const SizedBox(height: 20.0),
            TextButton.icon(
              label: Text(lang.infoButton),
              icon: const Icon(Icons.info),
              style: TextButton.styleFrom(
                  primary: Colors.black45,
                  backgroundColor: Colors.indigo,
                  elevation: 10,
                  textStyle: const TextStyle(
                      fontSize: 24, fontStyle: FontStyle.italic)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => pop_up_dialog(context),
                );
              },
            ),
            const SizedBox(height: 20.0),
            ToggleButtons(
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'EN',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'NB',
                  ),
                ),
              ],
              // logic for button selection below
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = i == index;
                  }
                  if(index == 0){
                    MainMenu.of(context)!.setLocale(const Locale.fromSubtags(languageCode: 'en'));
                  } else {
                    MainMenu.of(context)!.setLocale(const Locale.fromSubtags(languageCode: 'nb'));
                  }
                });
              },
              isSelected: isSelected,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }
}
