import 'package:flutter/material.dart';
import 'package:inft2501_prosjekt/pages/main_menu.dart';
import 'package:inft2501_prosjekt/pages/hangman_game.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const Hangman());
}

class Hangman extends StatelessWidget {
  const Hangman({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('nb', ''), // Spanish, no country code
      ],
      initialRoute: "/home",
      routes: {
        '/home' : (context) => MainMenu(),
        '/hangman' : (context) =>  Hangman()
      },
    );
  }

}