import 'dart:math';

class Player {
  static const X = 'X';
  static const O = 'O';
  static const empty = '';

  static List<int> PlayerX = [];
  static List<int> PlayerO = [];
}

extension ContainAll on List {
  bool containAll(int x, int y, [z]) {
    if (z == null)
      return contains(x) && contains(y);
    else
      return contains(x) && contains(y) && contains(z);
  }
}

class Game {
  void playGamer(int index, String activePlayer) {
    if (activePlayer == ('X'))
      Player.PlayerX.add(index);
    else
      Player.PlayerO.add(index);
  }

  String checkWinner() {
    String winner = '';
    if (Player.PlayerX.containAll(0, 1, 2) ||
        Player.PlayerX.containAll(3, 4, 5) ||
        Player.PlayerX.containAll(6, 7, 8) ||
        Player.PlayerX.containAll(0, 3, 6) ||
        Player.PlayerX.containAll(1, 4, 7) ||
        Player.PlayerX.containAll(2, 5, 8) ||
        Player.PlayerX.containAll(0, 4, 8) ||
        Player.PlayerX.containAll(2, 4, 6))
      winner = 'X';
    else if (Player.PlayerO.containAll(0, 1, 2) ||
        Player.PlayerO.containAll(3, 4, 5) ||
        Player.PlayerO.containAll(6, 7, 8) ||
        Player.PlayerO.containAll(0, 3, 6) ||
        Player.PlayerO.containAll(1, 4, 7) ||
        Player.PlayerO.containAll(2, 5, 8) ||
        Player.PlayerO.containAll(0, 4, 8) ||
        Player.PlayerO.containAll(2, 4, 6))
      winner = 'O';
    else
      winner = '';

    return winner;
  }

  Future<void> autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptyCells = [];
    for (var i = 0; i < 9; i++) {
      if (!(Player.PlayerX.contains(i) || Player.PlayerO.contains(i)))
        emptyCells.add(i);
    }

    if (Player.PlayerX.containAll(0, 1) && emptyCells.contains(2))
      index = 2;
    else if (Player.PlayerX.containAll(3, 4) && emptyCells.contains(5))
      index = 5;
    else if (Player.PlayerX.containAll(6, 7) && emptyCells.contains(8))
      index = 8;
    else if (Player.PlayerX.containAll(0, 3) && emptyCells.contains(6))
      index = 6;
    else if (Player.PlayerX.containAll(1, 4) && emptyCells.contains(7))
      index = 7;
    else if (Player.PlayerX.containAll(2, 5) && emptyCells.contains(8))
      index = 8;
    else if (Player.PlayerX.containAll(0, 4) && emptyCells.contains(8))
      index = 8;
    else if (Player.PlayerX.containAll(2, 4) && emptyCells.contains(6))
      index = 6;
    else {
      Random random = Random();
      int indexCells = random.nextInt(emptyCells.length);
      index = emptyCells[indexCells];
      playGamer(index, activePlayer);
    }
  }
}
