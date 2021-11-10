import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inft2501_prosjekt/widgets/pop_up_dialog.dart';
import 'package:inft2501_prosjekt/pages/main_menu.dart';
import '../models/game.dart';
import '../widgets/click_on_char_button.dart';
import '../widgets/guess_char.dart';
import '../models/guessed_char.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Hangman extends StatefulWidget {
  const Hangman({Key? key}) : super(key: key);

  @override
  State<Hangman> createState() => _HangmanState();
}


class _HangmanState extends State<Hangman> {

  final Game game = Game(lives: 10, word: "Hangman");
  var guessedLetters = <GuessedChar>[];
  var clickAlphabetLetters = <String>[];

  @override
  Widget build(BuildContext context) {

    var lang = AppLocalizations.of(context);
    clickAlphabetLetters ()=> lang!.alphabet.split("");

    final theme = Theme.of(context);
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: guessedLetters.isEmpty
            ? const Center(
                child: Text("Generating word..."),
              )
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    height: deviceHeight * 0.2,
                    width: double.infinity,
                    color: theme.primaryColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 25.0,),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Image.asset(
                              'assets/images/${10 - game.lives}.png',
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
                  Divider(
                    color: theme.primaryColor,
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
                        ...this
                            .guessedLetters
                            .map((letter) =>
                                GuessedChar(letter.char, letter.isGuessed))
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
                        ...this
                            .clickAlphabetLetters
                            .map((letter) => ClickOnCharButton(
                                letter.title,
                                letter.isChoose,
                                letter.isContainsInWord,
                                alphabetClickOnCharButton))
                            .toList()
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  //----------------| Get random word or word from user typing|---------------------
  Future getWord(BuildContext context) async {
    try {
      String routeWord = (ModalRoute.of(context).settings.arguments as String);
      if (routeWord == "") {
        Map map = await _randomWordApi.getWord();
        setState(() => game.word = map['word']);
      } else {
        setState(() => game.word = routeWord);
      }

      setState(() {
        for (int i = 0; i < this.game.word.length; i++) {
          guessedLetters.add(GuessLetterModel(this.game.word[i], false));
        }

        //if word contains space mark it as guessed
        for (var element in guessedLetters) {
          element.char == " "
            ? element.isGuessed = true
            : element.isGuessed = false;
        }
        getAlphabet();
      });

    } catch (e) {}
  }


  //----------------| get alphabel and setup it into list |---------------------
  void getAlphabet() => setState(() => AlphabetLetter.alphabet.forEach(
      (letter) => this.clickAlphabetLetters.add(AlphabetLetter(
          letter.toUpperCase(), false, this.game.word.contains(letter)))));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getWord(context);
    });
  }

  //---------------------| handle alphabet letter click |------------------------------
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
      this
          .clickAlphabetLetters
          .where((letter) => letter.title == title)
          .toList()[0]
          .isChoose = true;

      //bad letter click - not contains in the word
      if (!isContains) {
        game.lives--;
      }

      //game lose
      if (game.lives <= 0) {
        //lose();
      }
      //win the game
      if (guessedLetters.where((element) => element.isGuessed == false).isEmpty){
        //win();
        }
    });
  }

  //====================================================================================
/*

  //lose game
  void lose() =>
      Navigator.pushReplacementNamed(context, LoseScreen.routeName, arguments: {
        "score": this.game.score,
        "word": (ModalRoute.of(context).settings.arguments as String),
        "guessedWord": game.word
      });

  //win game
  void win() {
    checkHighScore();
    Navigator.pushReplacementNamed(context, WinScreen.routeName, arguments: {
      "score": this.game.score,
      "word": (ModalRoute.of(context).settings.arguments as String),
      "guessedWord": game.word
    });
  }
*/

}

/*
class _HangmanState extends State<Hangman> {

  Game game = Game(word: "Hangman", lives: 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}*/
