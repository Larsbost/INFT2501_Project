import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inft2501_prosjekt/pages/win.dart';
import 'package:inft2501_prosjekt/widgets/pop_up_dialog.dart';
import 'main_menu.dart';
import '../models/game.dart';
import '../models/alphabet.dart';
import '../widgets/click_on_char_button.dart';
import '../widgets/guess_char.dart';
import '../models/guessed_char.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "dart:math";
import 'loose.dart';

class Hangman extends StatefulWidget {
  const Hangman({Key? key}) : super(key: key);

  @override
  State<Hangman> createState() => _HangmanState();
}


class _HangmanState extends State<Hangman> {

  final Game game = Game(lives: 6, word: "Hangman");
  var guessedLetters = <GuessedChar>[];
  var clickAlphabets = <Alphabet>[];

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);

    final theme = Theme.of(context);
    final deviceHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              height: deviceHeight * 0.2,
              width: double.infinity,
              color: Colors.blueGrey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 25.0,),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Image.asset(
                        'assets/hangman_lives/${6 - game.lives}.png',
                      ),
                    ),
                  ),
                  const SizedBox(width: 25.0,),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 10, 0),
              child: Align(
                alignment: Alignment.bottomLeft,
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 2.0,
            ),
            SizedBox(
              height: deviceHeight * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Wrap(
                children: [
                  //setup word in guessLetter widget
                  ...guessedLetters
                      .map((guessedChar) =>
                      GuessChar(
                          guessedChar.char,
                          guessedChar.isGuessed))
                      .toList()
                ],
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  //show alphabet
                  ...clickAlphabets
                      .map((letter) =>
                      ClickOnCharButton(
                          letter.char,
                          letter.isChoose,
                          letter.isInWord,
                          alphabetClickOnCharButton))
                      .toList()
                ],
              ),
            ),
            const SizedBox(height: 45.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  label: Text(lang!.infoButton),
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
                const SizedBox(width: 25.0,),
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
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



  Future getWord(BuildContext context) async {
    var lang = AppLocalizations.of(context);
    final _random = Random();

    String letters = lang!.alphabet;
    List<String> alphabet = letters.split(",");
    String word = lang.words;
    List<String> words = word.split(",");


    try {
      String routeWord = words[_random.nextInt(words.length)];
      setState(() => game.word = routeWord);

      setState(() {
        for (int i = 0; i < game.word.length; i++) {
          guessedLetters.add(GuessedChar(game.word[i], false));
        }

        setState(() =>
            alphabet.forEach(
                    (letter) =>
                    clickAlphabets.add(Alphabet(
                        letter.toUpperCase(), false,
                        game.word.contains(letter)))));
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getWord(context);
    });
  }

  void alphabetClickOnCharButton(String title) {
    bool isContains = false;
    setState(() {
      //set letter as guessed
      for (int i = 0; i < game.word.length; i++) {
        if (game.word[i].toUpperCase() == title) {
          guessedLetters[i].isGuessed = true;
          isContains = true;
        }
      }
      clickAlphabets
          .where((letter) => letter.char == title)
          .toList()[0]
          .isChoose = true;

      //bad letter click - not contains in the word
      if (!isContains) {
        game.lives--;
      }

      //game lose
      if (game.lives <= 0) {
        Navigator.push(context,MaterialPageRoute(builder: (context) => const Loose()));
      }
      //win the game
      if (guessedLetters
          .where((element) => element.isGuessed == false)
          .isEmpty) {
        Navigator.push(context,MaterialPageRoute(builder: (context) => const Win()));
      }
    });
  }
}
