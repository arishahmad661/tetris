import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';


List<List<Tetromino?>> gameBoard = List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  Piece currentPiece = Piece(type: Tetromino.L);
  int currentScore = 0;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    currentPiece.initialixePiece();

    Duration frameRate = Duration(milliseconds: 250);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate){
    Timer.periodic(
      frameRate,
        (timer){
        setState(() {
          clearLines();
          checkLanding();
          if(gameOver == true){
            timer.cancel();
            showGameOverDialogBox();
          }
          currentPiece.movePiece(Direction.down);
        });
        }
    );
  }

  void showGameOverDialogBox(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Game Over'),
          content: Text('Your score is: $currentScore'),
          actions: [
            TextButton(
                onPressed: (){
                  resetGame();
                  Navigator.pop(context);
                  },
                child: Text('Play Again')
            )
          ],
        ),
    );
  }

  void resetGame(){
    gameBoard = List.generate(colLength, (i) => List.generate(rowLength, (j) => null));
    gameOver = false;
    currentScore = 0;
    createNewPiece();
    startGame();
  }

  bool checkCollision(Direction direction){
    for(int i = 0; i < currentPiece.position.length; i++){
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;
      if(direction == Direction.left){
        col -= 1;
      }else if(direction == Direction.rigth){
        col += 1;
      }else if(direction == Direction.down){
        row += 1;
      }
      if(row >= colLength || col < 0 || col >= rowLength){
        return true;
      }
      if(row >= 0 && gameBoard[row][col] != null){
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if(checkCollision(Direction.down) || checkLanded()){
      for(int i = 0; i < currentPiece.position.length; i++){
        int row = (currentPiece.position[i]/rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if(row >= 0 && col >= 0){
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  bool checkLanded() {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;
      if (row + 1 < colLength && row >= 0 && gameBoard[row + 1][col] != null) {
        return true; // collision with a landed piece
      }
    }

    return false; // no collision with landed pieces
  }

  void createNewPiece(){
    Random rand = Random();
    Tetromino  randomType = Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initialixePiece();

    if(isGameOver()){
      gameOver = true;
    }
  }

  void moveLeft(){
    if(!checkCollision(Direction.left)){
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight(){
    if(!checkCollision(Direction.rigth)){
      setState(() {
        currentPiece.movePiece(Direction.rigth);
      });
    }
  }

  void rotatePiece(){
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void clearLines(){
    for(int row = colLength - 1; row >= 0; row--){
      bool rowIsFull = true;
      for(int col = 0; col < rowLength; col++){
        if(gameBoard[row][col] == null){
          rowIsFull = false;
          break;
        }
      }
      if(rowIsFull){
        for(int r = row; r > 0; r--){
          gameBoard[r] = List.from(gameBoard[r-1]);
        }
        gameBoard[0] = List.generate(row, (index) => null);
        currentScore++;
      }
    }
  }

  bool isGameOver(){
    for(int col = 0; col < rowLength; col++){
      if(gameBoard[0][col] != null){
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: rowLength * colLength,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: rowLength),
                    itemBuilder: (context, index) {
                      int row = (index/rowLength).floor();
                      int col = index % rowLength;
                      if (currentPiece.position.contains(index)) {
                        return Pixel(
                          color: currentPiece.color,
                          child: index,
                        );
                      }else if(gameBoard[row][col] != null){
                        final  Tetromino? tetrominoType = gameBoard[row][col];
                        return Pixel(
                          color: tetrominoColors[tetrominoType],
                          child: '',
                        );
                      }
                      else {
                        return Pixel(
                          color: Colors.grey[900],
                          child: index,
                        );
                      }
                    }),
              ),
              Text('Score: '+ currentScore.toString(), style: TextStyle(color: Colors.white),),
              Padding(
                padding: const EdgeInsets.only(bottom: 50, top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: (){moveLeft();}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
                    IconButton(onPressed: (){rotatePiece();}, icon: Icon(Icons.rotate_right, color: Colors.white,)),
                    IconButton(onPressed: (){moveRight();}, icon: Icon(Icons.arrow_forward, color: Colors.white,)),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
