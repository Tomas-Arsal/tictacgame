import 'package:flutter/material.dart';

import 'gameLogic.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String activePlayer = 'X';
bool gameOver = false;
int turn = 0;
String result = '';
Game game = Game();

bool isSwatched = false;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var med = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ?
              Column(
                  children: [
                    ...firstMethod(),
                    extend(context),
                    ...secondMethod(),
                  ],

            )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [  
                        ...firstMethod(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ...secondMethod(),],
                    ),
                  ),
                  extend(context),
                ],
              ),
      ),
    );
  }

  List firstMethod() {
    return [
      SwitchListTile.adaptive(
        value: isSwatched,
        onChanged: (newValue) {
          isSwatched = newValue;
        },
        title: const Text(
          'Turn on/of two player',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      Text(
        'it\'s $activePlayer turn'.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 50,
        ),
        textAlign: TextAlign.center,
      ),
    ];
  }

  Expanded extend(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1.0,
        children: List.generate(
            9,
            (index) => InkWell(
                  onTap: gameOver ? null : () => _onTop(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        Player.PlayerX.contains(index)
                            ? 'X'
                            : Player.PlayerO.contains(index)
                                ? 'O'
                                : '',
                        style: TextStyle(
                          color: Player.PlayerX.contains(index)
                              ? Colors.blue
                              : Colors.pink,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }

  List secondMethod() {
    return [
      Text(
        result,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
        ),
        textAlign: TextAlign.center,
      ),
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            Player.PlayerX = [];
            Player.PlayerO = [];
            activePlayer = 'X';
            gameOver = false;
            turn = 0;
            result = '';
          });
        },
        icon: const Icon(Icons.replay),
        label: const Text('Repeat The Game'),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).splashColor),
        ),
      ),
    ];
  }

  _onTop(int index) async {
    game.playGamer(index, activePlayer);
    if (Player.PlayerX.isEmpty ||
        !Player.PlayerX.contains(index) && Player.PlayerO.isEmpty ||
        !Player.PlayerO.contains(index)) ;
    game.playGamer(index, activePlayer);
    updateState();
    if (!isSwatched && !gameOver && result != 9)
      await game.autoPlay(activePlayer);
  }

  void updateState() {
    setState(() {
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';
      turn++;
      String WinnerPlayer = game.checkWinner();
      if (WinnerPlayer != '') {
        gameOver = true;
        result = '$WinnerPlayer It\'s The Winner';
      } else if (!gameOver && turn == 9) {
        result = 'It\'s Draw';
      }
      ;
    });
  }
}
