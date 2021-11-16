import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inft2501_prosjekt/pages/win.dart';
import 'package:inft2501_prosjekt/widgets/pop_up_dialog.dart';
import '../models/game_model.dart';
import '../models/char_model.dart';
import '../widgets/char_keyboard.dart';
import '../widgets/show_correct_guessed_char.dart';
import '../models/guessed_char_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "dart:math";
import 'loose.dart';

class Hangman extends StatefulWidget {
  const Hangman({Key? key}) : super(key: key);

  @override
  State<Hangman> createState() => _HangmanState();
}

class _HangmanState extends State<Hangman> {
  final Game game = Game();
  var guessedChars = <GuessedChar>[];
  var alphabets = <Character>[];

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 25),
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/hangman_lives/${6 - game.lives}.png',
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Wrap(
                children: [
                  ...guessedChars
                      .map((guessedChar) => CorrectGuessedChar(
                          guessedChar.char, guessedChar.isGuessed))
                      .toList()
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  ...alphabets
                      .map((char) => CharKeyboard(char.char, char.isChoose,
                          char.isInWord, charButtonClick))
                      .toList()
                ],
              ),
            ),
            const SizedBox(height: 45),
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
                const SizedBox(
                  width: 25,
                ),
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

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getWord(context);
    });
  }

  void getWord(BuildContext context) {
    var lang = AppLocalizations.of(context);
    final _random = Random();

    String chars = lang!.alphabet;
    List<String> alphabet = chars.split(",");
    String word = lang.words;
    List<String> words = word.split(",");

    String randomWord = words[_random.nextInt(words.length)];
    setState(() => game.word = randomWord);

    setState(() {
      for (int i = 0; i < game.word.length; i++) {
        guessedChars.add(GuessedChar(game.word[i], false));
      }
      setState(() => alphabet.forEach((char) => alphabets.add(
          Character(char.toUpperCase(), false, game.word.contains(char)))));
    });
  }



  void charButtonClick(String buttonChar) {
    bool isContains = false;

    setState(() {
      for (int i = 0; i < game.word.length; i++) {
        if (game.word[i].toUpperCase() == buttonChar) {
          guessedChars[i].isGuessed = true;
          isContains = true;
        }
      }

      alphabets
          .where((letter) => letter.char == buttonChar)
          .toList()[0]
          .isChoose = true;

      if (!isContains) {
        game.lives--;
      }
      if (game.lives <= 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Loose()));
      }
      if (guessedChars.where((element) => element.isGuessed == false).isEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Win()));
      }
    });
  }
}
