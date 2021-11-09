import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inft2501_prosjekt/pages/hangman_game.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<bool> _selections = List.generate(2, (_) => false);

  @override
  Widget build(BuildContext context) {
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
              label: const Text('Start Spillet!'),
              icon: const Icon(Icons.accessibility_new),
              style: TextButton.styleFrom(
                  primary: Colors.black45,
                  backgroundColor: Colors.indigo,
                  elevation: 10,
                  textStyle: const TextStyle(
                      fontSize: 24, fontStyle: FontStyle.italic)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Hangman())
                );
              },
            ),
            const SizedBox(height: 20.0),
             ToggleButtons(
                children: const <Widget>[
                  Text("NO"),
                  Text("EN")
                ],
                isSelected: _selections,
                onPressed: (int index) {
                  setState(() {
                    _selections[index] = !_selections[index];
                  });
            }),
            TextButton.icon(
              label: const Text('Informasjon'),
              icon: const Icon(Icons.info),
              style: TextButton.styleFrom(
                  primary: Colors.black45,
                  backgroundColor: Colors.indigo,
                  elevation: 10,
                  textStyle: const TextStyle(
                      fontSize: 24, fontStyle: FontStyle.italic)),
              onPressed: () {
                //TODO route til informasjons skriv
              },
            ),
          ],
        ),
      ),
    );
  }
}
