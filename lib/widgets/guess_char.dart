import 'package:flutter/material.dart';

class GuessChar extends StatelessWidget {
  final String char;
  final bool isGuessed;

  const GuessChar(this.char, this.isGuessed);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Column(
        children: [
          Text(
            isGuessed ? char : "",
            style: theme.textTheme.headline6!.copyWith(fontSize: 24.0),
          ),
          Container(
            color: char != " " ? theme.primaryColor : Colors.transparent,
            width: 30,
            height: 2,
          )
        ],
      ),
    );
  }
}
