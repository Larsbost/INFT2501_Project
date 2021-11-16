import 'package:flutter/material.dart';

class CorrectGuessedChar extends StatelessWidget {
  final String char;
  final bool isGuessed;

  const CorrectGuessedChar(this.char, this.isGuessed);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Column(
        children: [
          Text(
            isGuessed ? char : "",
            style: const TextStyle(fontSize: 24,)
          ),
          Container(
            height: 2,
            width: 30,
            color: char != " " ? Colors.black : Colors.transparent,
          )
        ],
      ),
    );
  }
}
