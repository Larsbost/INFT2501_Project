import 'package:flutter/material.dart';
import 'package:inft2501_prosjekt/pages/home.dart';
import 'package:inft2501_prosjekt/pages/hangman_game.dart';


void main() {
  runApp(const Hangman());
}

class Hangman extends StatelessWidget {
  const Hangman({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/home",
      routes: {
        '/home' : (context) => Home(),
        '/hangman' : (context) =>  Hangman()
      },
    );
  }

}