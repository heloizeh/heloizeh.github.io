import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jogo da Velha',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> board = List.filled(9, ""); // Representa o tabuleiro
  String currentPlayer = "X"; // Jogador atual
  String resultMessage = ""; // Mensagem de resultado
  bool isGameOver = false;

  void _handleTap(int index) {
    if (board[index] == "" && !isGameOver) {
      setState(() {
        board[index] = currentPlayer;
        if (_checkWinner()) {
          resultMessage = "Jogador $currentPlayer venceu!";
          isGameOver = true;
        } else if (!board.contains("")) {
          resultMessage = "Empate!";
          isGameOver = true;
        } else {
          currentPlayer = currentPlayer == "X" ? "O" : "X";
        }
      });
    }
  }

  bool _checkWinner() {
    // Combinações vencedorasgit
    List<List<int>> winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winConditions) {
      if (board[condition[0]] == currentPlayer &&
          board[condition[1]] == currentPlayer &&
          board[condition[2]] == currentPlayer) {
        return true;
      }
    }
    return false;
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, "");
      currentPlayer = "X";
      resultMessage = "";
      isGameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogo da Velha"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Tabuleiro
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 colunas
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              padding: EdgeInsets.all(20),
              itemCount: 9,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => _handleTap(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: board[index] == "X" ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Mensagem de resultado
          if (resultMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                resultMessage,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          // Botão de reiniciar
          ElevatedButton(
            onPressed: _resetGame,
            child: Text("Reiniciar Jogo"),
          ),
        ],
      ),
    );
  }
}
