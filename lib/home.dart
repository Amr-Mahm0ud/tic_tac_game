import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_game/game.dart';
import 'package:tic_tac_game/main.dart';

bool isDark = false;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  bool twoPlayers = false;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: MediaQuery.of(context).orientation == Orientation.landscape
            ? null
            : AppBar(
                title: const Text('Tic Tac game'),
                actions: [
                  ThemeSwitcher(
                    builder: (context) {
                      return IconButton(
                        onPressed: () {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: isDark ? lightTheme : ThemeData.dark(),
                            isReversed: isDark ? true : false,
                          );
                          isDark = !isDark;
                        },
                        icon: Icon(!isDark ? Icons.dark_mode : Icons.light_mode,
                            size: 25),
                      );
                    },
                  ),
                ],
              ),
        body: SafeArea(
          child: MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(
                  children: [
                    ...firstBlock(),
                    secondBlock(context),
                    ...lastBlock(),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...firstBlock(),
                          ...lastBlock(),
                        ],
                      ),
                    ),
                    secondBlock(context),
                  ],
                ),
        ),
      ),
    );
  }

  Expanded secondBlock(BuildContext context) {
    return Expanded(
      child: GridView(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        children: List.generate(
            9,
            (index) => InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: gameOver ? null : () => _onTab(index),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).cardColor),
                    child: Text(
                      Player.playerX.contains(index)
                          ? 'X'
                          : Player.playerO.contains(index)
                              ? 'O'
                              : '',
                      style: TextStyle(
                          fontSize: 50,
                          color: Player.playerX.contains(index)
                              ? Colors.blue
                              : Colors.red),
                    ),
                  ),
                )),
      ),
    );
  }

  List<Widget> firstBlock() {
    return [
      SwitchListTile.adaptive(
        onChanged: (newVal) {
          setState(() {
            twoPlayers = newVal;
          });
        },
        value: twoPlayers,
        title: const Text(
          'Turn On/Off two Players',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      Text(
        "It's $activePlayer turn".toUpperCase(),
        style: const TextStyle(fontSize: 40),
      ),
    ];
  }

  List<Widget> lastBlock() {
    return [
      Text(
        result,
        style: const TextStyle(fontSize: 40),
      ),
      ElevatedButton.icon(
        label: const Text('Repeat the game'),
        icon: const Icon(Icons.replay),
        onPressed: () {
          setState(() {
            Player.playerX = [];
            Player.playerO = [];
            activePlayer = 'X';
            gameOver = false;
            turn = 0;
            result = '';
          });
        },
      ),
    ];
  }

  _onTab(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.play(index, activePlayer);
      updateState();
    }
    if (!twoPlayers && !gameOver && activePlayer != 'X' && turn != 9) {
      await game.autoPlay(activePlayer);
      updateState();
    }
  }

  void updateState() {
    turn++;
    setState(() {
      activePlayer = activePlayer == 'X' ? 'O' : 'X';
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer == '' && turn == 9) {
        gameOver = true;
        result = "It's Draw";
      } else if (winnerPlayer != '') {
        gameOver = true;
        result = 'The winner is $winnerPlayer';
      }
    });
  }
}
