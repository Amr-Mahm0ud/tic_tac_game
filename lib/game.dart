import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension ContainsAll on List {
  bool containsAll(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}

extension ContainsTwo on List {
  List containsTwo(int x, int y, int z) {
    if (contains(x) && contains(y)) return [true, z];
    if (contains(z) && contains(y)) return [true, x];
    if (contains(x) && contains(z)) return [true, y];
    return [false, 0];
  }
}

class Game {
  void play(int index, String activePlayer) {
    if (activePlayer == 'X') {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  String checkWinner() {
    String winner = '';
    if (Player.playerX.containsAll(0, 1, 2) ||
        Player.playerX.containsAll(3, 4, 5) ||
        Player.playerX.containsAll(6, 7, 8) ||
        Player.playerX.containsAll(0, 3, 6) ||
        Player.playerX.containsAll(1, 4, 7) ||
        Player.playerX.containsAll(2, 5, 8) ||
        Player.playerX.containsAll(0, 4, 8) ||
        Player.playerX.containsAll(2, 4, 6)) {
      winner = 'X';
    } else if (Player.playerO.containsAll(0, 1, 2) ||
        Player.playerO.containsAll(3, 4, 5) ||
        Player.playerO.containsAll(6, 7, 8) ||
        Player.playerO.containsAll(0, 3, 6) ||
        Player.playerO.containsAll(1, 4, 7) ||
        Player.playerO.containsAll(2, 5, 8) ||
        Player.playerO.containsAll(0, 4, 8) ||
        Player.playerO.containsAll(2, 4, 6)) {
      winner = 'O';
    } else {
      winner = '';
    }
    return winner;
  }

  Future<void> autoPlay(String activePlayer) async {
    int index = 0;
    List emptyCells = [];

    for (int i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
        emptyCells.add(i);
      }
    }
    if (emptyCells.isNotEmpty) {
      //attack
      if (Player.playerO.containsTwo(0, 1, 2)[0] &&
          emptyCells.contains(Player.playerO.containsTwo(0, 1, 2)[1])) {
        index = Player.playerO.containsTwo(0, 1, 2)[1];
      } else if (Player.playerO.containsTwo(3, 4, 5)[0] &&
          emptyCells.contains(Player.playerO.containsTwo(3, 4, 5)[1])) {
        index = Player.playerO.containsTwo(3, 4, 5)[1];
      } else if (Player.playerO.containsTwo(6, 7, 8)[0] &&
          emptyCells.contains(Player.playerO.containsTwo(6, 7, 8)[1])) {
        index = Player.playerO.containsTwo(6, 7, 8)[1];
      } else if (Player.playerO.containsTwo(0, 3, 6)[0] &&
          emptyCells.contains(Player.playerO.containsTwo(0, 3, 6)[1])) {
        index = Player.playerO.containsTwo(0, 3, 6)[1];
      } else if (Player.playerO.containsTwo(1, 4, 7)[0] &&
          emptyCells.contains(Player.playerO.containsTwo(1, 4, 7)[1])) {
        index = Player.playerO.containsTwo(1, 4, 7)[1];
      } else if (Player.playerO.containsTwo(2, 5, 8)[0] &&
          emptyCells.contains(Player.playerO.containsTwo(2, 5, 8)[1])) {
        index = Player.playerO.containsTwo(2, 5, 8)[1];
      } else if (Player.playerO.containsTwo(0, 4, 8)[0] &&
          emptyCells.contains(Player.playerO.containsTwo(0, 4, 8)[1])) {
        index = Player.playerO.containsTwo(0, 4, 8)[1];
      } else if (Player.playerO.containsTwo(2, 4, 6)[0] &&
          emptyCells.contains(Player.playerO.containsTwo(2, 4, 6)[1])) {
        index = Player.playerO.containsTwo(2, 4, 6)[1];
      }
      //defense
      else if (Player.playerX.containsTwo(0, 1, 2)[0] &&
          emptyCells.contains(Player.playerX.containsTwo(0, 1, 2)[1])) {
        index = Player.playerX.containsTwo(0, 1, 2)[1];
      } else if (Player.playerX.containsTwo(3, 4, 5)[0] &&
          emptyCells.contains(Player.playerX.containsTwo(3, 4, 5)[1])) {
        index = Player.playerX.containsTwo(3, 4, 5)[1];
      } else if (Player.playerX.containsTwo(6, 7, 8)[0] &&
          emptyCells.contains(Player.playerX.containsTwo(6, 7, 8)[1])) {
        index = Player.playerX.containsTwo(6, 7, 8)[1];
      } else if (Player.playerX.containsTwo(0, 3, 6)[0] &&
          emptyCells.contains(Player.playerX.containsTwo(0, 3, 6)[1])) {
        index = Player.playerX.containsTwo(0, 3, 6)[1];
      } else if (Player.playerX.containsTwo(1, 4, 7)[0] &&
          emptyCells.contains(Player.playerX.containsTwo(1, 4, 7)[1])) {
        index = Player.playerX.containsTwo(1, 4, 7)[1];
      } else if (Player.playerX.containsTwo(2, 5, 8)[0] &&
          emptyCells.contains(Player.playerX.containsTwo(2, 5, 8)[1])) {
        index = Player.playerX.containsTwo(2, 5, 8)[1];
      } else if (Player.playerX.containsTwo(0, 4, 8)[0] &&
          emptyCells.contains(Player.playerX.containsTwo(0, 4, 8)[1])) {
        index = Player.playerX.containsTwo(0, 4, 8)[1];
      } else if (Player.playerX.containsTwo(2, 4, 6)[0] &&
          emptyCells.contains(Player.playerX.containsTwo(2, 4, 6)[1])) {
        index = Player.playerX.containsTwo(2, 4, 6)[1];
      } else {
        Random rand = Random();
        int randIndex = rand.nextInt(emptyCells.length);
        index = emptyCells[randIndex];
      }
      play(index, activePlayer);
    }
  }
}
