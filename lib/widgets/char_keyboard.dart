import 'package:flutter/material.dart';

class CharKeyboard extends StatelessWidget {

  final String char;
  final bool isChoose;
  final bool isContainsInWord;
  final Function buttonClick;

  const CharKeyboard(this.char,this.isChoose,this.isContainsInWord,this.buttonClick);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextButton(
         child: Text(char),
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            primary: isChoose ? isContainsInWord ? Colors.white : Colors.transparent : Colors.white,
            backgroundColor: isChoose ? isContainsInWord ? Colors.amber : Colors.transparent : Colors.black26,
            textStyle: const TextStyle(
              fontSize: 30,
              )),
        onPressed: () {
          buttonClick(char);
        },
      ),
    );
  }
}