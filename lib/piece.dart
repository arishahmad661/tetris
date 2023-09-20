import 'package:flutter/material.dart';
import 'package:tetris/board.dart';
import 'package:tetris/values.dart';

class Piece {
  Tetromino type;
  Piece({required this.type});

  List<int> position = [];

  Color get color{
    return tetrominoColors[type] ?? Color(0xFFFFFFF);
  }

  void initialixePiece(){
    switch(type){
      case Tetromino.L:
        position = [-26, -16, -6, - 5];
        break;
      case Tetromino.J:
        position = [-25, -15, -5, -6];
      case Tetromino.I:
        position = [-4, -5, -6, -7];
      case Tetromino.O:
        position = [-15, -16, -5, -6];
      case Tetromino.S:
        position = [-15, -14, -6, -5];
      case Tetromino.Z:
        position = [-17, -16, -6, -5];
      case Tetromino.T:
        position = [-26, -16, -6, -15];
      default:

    }
  }

  void movePiece(Direction direction){
    switch(direction){
      case Direction.down:
        for(int i = 0; i < position.length; i++){
          position[i] += rowLength;
        }
      case Direction.left:
        for(int i = 0; i < position.length; i++){
          position[i] -= 1;
        }
      case Direction.rigth:
        for(int i = 0; i < position.length; i++){
          position[i] += 1;
        }
      default:
    }
  }

  int rotateState = 1;
  List<int> newPosition = [];
  void rotatePiece(){
    List<int> positions = [];
    switch(type){
      case Tetromino.L:
        switch(rotateState){
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
      case Tetromino.J:
        switch(rotateState){
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] +  1,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
      case Tetromino.I:
        switch(rotateState){
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2 ,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
      case Tetromino.O:
        break;
      case Tetromino.S:
      switch(rotateState){
        case 0:
          newPosition = [
            position[1],
            position[1] + 1,
            position[1] + rowLength - 1,
            position[1] + rowLength,
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
        case 1:
          newPosition = [
            position[0] - rowLength,
            position[0],
            position[0] + 1,
            position[0] + rowLength + 1,
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
        case 2:
          newPosition = [
            position[1],
            position[1] + 1,
            position[1] + rowLength - 1,
            position[1] + rowLength,
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
        case 3:
          newPosition = [
            position[0] - rowLength,
            position[0],
            position[0] + 1,
            position[0] + rowLength + 1,
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
      }
      case Tetromino.Z:
        switch(rotateState){
          case 0:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
      case Tetromino.T:
        switch(rotateState){
          case 0:
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if(piecePositionIsValid(newPosition)){
              position = newPosition;
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }

    }
  }

  bool positionIsValid(int position){
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    if(row < 0 || col < 0 || gameBoard[row][col] != null){
      return false;
    }
    return true;
  }

  bool piecePositionIsValid(List<int> piecePosition){
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for(int pos in piecePosition){
      if(!positionIsValid(pos)){
        return false;
      }

      int col = pos % rowLength;

      if(col == 0){
        firstColOccupied = true;
      }
      if(col == rowLength - 1){
        lastColOccupied = true;
      }
    }



    return !(firstColOccupied && lastColOccupied);
  }

}