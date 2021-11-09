import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inft2501_prosjekt/widgets/pop_up_dialog.dart';
import 'package:inft2501_prosjekt/pages/main_menu.dart';
import '../models/game.dart';
import '../widgets/click_on_char_button.dart';
import '../widgets/guess_char.dart';


class Hangman extends StatefulWidget {

  @override
  State<Hangman> createState() => _HangmanState();
}

class _HangmanState extends State<Hangman> {

  Game game = Game(word: "Hangman", lives: 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}