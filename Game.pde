class Game {
  int[][] board;
  boolean turn; // false = black, true = white

  boolean blackCastle;
  boolean whiteCastle;
  boolean whiteCheck;
  boolean blackCheck;

  HashMap<Integer, ArrayList<Integer>> pieceLocation;

  Game(int[][] board, boolean turn, boolean blackCastle, boolean whiteCastle) {
    this.board = board;
    this.turn = turn;
    this.blackCastle = blackCastle;
    this.whiteCastle = whiteCastle;
    this.pieceLocation = new HashMap<Integer, ArrayList<Integer>>();
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {

        if (this.pieceLocation.containsKey(Integer.valueOf(board[i][j]))) {
          this.pieceLocation.get(board[i][j]).add(i + 8*j);
        } else {
          ArrayList<Integer> currList = new ArrayList<>();
          currList.add(i + j*8);
          this.pieceLocation.put(board[i][j], currList);
        }
      }
    }

    whiteCheck = isCheck(true, this); // checking whites check firstly
    blackCheck = isCheck(false, this);
  }

  void makeMove(int source, int dest) {
    int sX = source%8;
    int sY = source/8;
    int dX = dest%8;
    int dY = dest/8;
    if (Piece.isNone(board[sX][sY])) {
      return;
    }
    // The source is not none and they are are oppositePieces
    // Now we take the piece dPiece by sPiece
    int sPiece = board[sX][sY], dPiece = board[dX][dY];
    board[dX][dY] = sPiece;
    board[sX][sY] = Piece.None;

    changePosition(sPiece, source, dest); // change the position of the piece
    removePiece(dPiece, dest); // remove the dest Position piece
    
    this.turn = !this.turn;
    
    this.blackCheck = isCheck(false, this);
    
    this.whiteCheck = isCheck(true, this);
  }


  void changePosition(int piece, int oldPos, int newPos) {
    // If the HashMap haves the piece
    if (pieceLocation.containsKey(piece)) {
      // remove the oldPos and add new
      pieceLocation.get(piece).remove(Integer.valueOf(oldPos));
      pieceLocation.get(piece).add(Integer.valueOf(newPos));
      return;
    }

    println("This Board Does Have this Piece");
  }

  void removePiece(int piece, int oldPos) {
    // If the HashMap haves the piece
    if (pieceLocation.containsKey(piece)) {
      // remove the oldPos and add new
      pieceLocation.get(piece).remove(Integer.valueOf(oldPos));
      return;
    }

  }

  Game copy() {
    int newBoard[][] = new int[8][8];
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        newBoard[i][j] = board[i][j];
      }
    }
    Game newGame = new Game(newBoard, turn, blackCastle, whiteCastle);
   
    newGame.blackCheck = isCheck(false, newGame);
    newGame.whiteCheck = isCheck(true, newGame);
    return newGame;
  }

  // Moves

  ArrayList<Integer> getMoves(int pos, int piece) {
    ArrayList<Integer> moves;
    if (Piece.isKing(piece)) {
      moves = kingMoves(piece, pos);
    } else if (Piece.isQueen(piece)) {
      moves = queenMoves(piece, pos);
    } else if (Piece.isRook(piece)) {
      moves = rookMoves(piece, pos);
    } else if (Piece.isBishop(piece)) {
      moves = bishopMoves(piece, pos);
    } else if (Piece.isKnight(piece)) {
      moves = knightMoves(piece, pos);
    } else
      moves = pawnMoves(piece, pos);
      
      // remove the check piece  
      ArrayList<Integer> removeMoves = new ArrayList<>();
      for(int move : moves){
        Game newGame = this.copy();
        newGame.makeMove(pos, move);
        if(newGame.turn){ // now its white's turn
          if(newGame.blackCheck){
            removeMoves.add(move);
          }
        }else{
          if(newGame.whiteCheck){ // if after black's move black have check then that move cannot be played.
            removeMoves.add(move);
          }
        }
      }
      
      for(int move : removeMoves){
        moves.remove(Integer.valueOf(move));
      }
      
      return moves;
  }

  ArrayList<Integer> pawnMoves(int piece, int pos) {
    // get the moves of a pawn if a position in the given position
    int x = pos%8;
    int y = pos/8;
    ArrayList<Integer> moves = new ArrayList<>();
    if (y == 1 && Piece.isBlack(piece)) {

      if (posCheck(x, y+1)) {
        if (board[x][y+1] == Piece.None) {
          moves.add(x + (y+1)*8);
          if (board[x][y+2] == Piece.None) {
            moves.add(x + (y+2)*8);
          }
        }
      }
    } else if (y == 6 && Piece.isWhite(piece)) {

      if (posCheck(x, y-1)) {
        if (board[x][y-1] == Piece.None) {
          moves.add(x + (y-1)*8);
          if (board[x][y-2] == Piece.None) {
            moves.add(x + (y-2)*8);
          }
        }
      }
    } else {
      if (posCheck(x, y-1) && Piece.isWhite(piece) && Piece.isNone(board[x][y-1])) {
        moves.add(x + (y-1)*8);
      } else if (posCheck(x, y+1) && Piece.isBlack(piece) && Piece.isNone(board[x][y+1])) {
        moves.add(x + (y+1)*8);
      }
    }
    if (Piece.isBlack(piece)) {
      if (posCheck(x+1, y+1) && Piece.isOpposite(piece, board[x+1][y+1])) {
        moves.add(x+1 + (y+1)*8);
      }
      if (posCheck(x-1, y+1) && Piece.isOpposite(piece, board[x-1][y+1])) {
        moves.add(x-1 + (y+1)*8);
      }
    } else {
      if (posCheck(x-1, y-1) && Piece.isOpposite(piece, board[x-1][y-1])) {
        moves.add(x-1 + (y-1)*8);
      }
      if (posCheck(x+1, y-1) && Piece.isOpposite(piece, board[x+1][y-1])) {
        moves.add(x+1 + (y-1)*8);
      }
    }

    return moves;
  }

  ArrayList<Integer> knightMoves(int piece, int pos) {

    int x = pos%8;
    int y = pos/8;
    ArrayList<Integer> moves = new ArrayList<>();
    if (posCheck(x-2, y-1)) {

      if (board[x-2][y-1] == Piece.None || Piece.isOpposite(piece, board[x-2][y-1])) {
        moves.add(x-2 + (y-1)*8);
      }
    }
    if (posCheck(x-1, y-2)) {

      if (board[x-1][y-2] == Piece.None || Piece.isOpposite(piece, board[x-1][y-2])) {
        moves.add(x-1 + (y-2)*8);
      }
    }
    if (posCheck(x-2, y+1)) {

      if (board[x-2][y+1] == Piece.None || Piece.isOpposite(piece, board[x-2][y+1])) {
        moves.add(x-2 + (y+1)*8);
      }
    }
    if (posCheck(x-1, y+2)) {

      if (board[x-1][y+2] == Piece.None || Piece.isOpposite(piece, board[x-1][y+2])) {
        moves.add(x-1 + (y+2)*8);
      }
    }
    if (posCheck(x+1, y-2)) {

      if (board[x+1][y-2] == Piece.None || Piece.isOpposite(piece, board[x+1][y-2])) {
        moves.add(x+1 + (y-2)*8);
      }
    }
    if (posCheck(x+2, y-1)) {

      if (board[x+2][y-1] == Piece.None || Piece.isOpposite(piece, board[x+2][y-1])) {
        moves.add(x+2 + (y-1)*8);
      }
    }
    if (posCheck(x+1, y+2)) {

      if (board[x+1][y+2] == Piece.None || Piece.isOpposite(piece, board[x+1][y+2])) {
        moves.add(x+1 + (y+2)*8);
      }
    }
    if (posCheck(x+2, y+1)) {

      if (board[x+2][y+1] == Piece.None || Piece.isOpposite(piece, board[x+2][y+1])) {
        moves.add(x+2 + (y+1)*8);
      }
    }


    return moves;
  }

  ArrayList<Integer> bishopMoves(int piece, int pos) {
    int x = pos%8;
    int y = pos/8;
    ArrayList<Integer> moves = new ArrayList<>();
    // #1 TOP RIGHT DIAGONAL
    int k = 1;
    while (posCheck(x + k, y - k)) {
      int currPiece = board[x + k][y - k];
      if (Piece.isOpposite(piece, currPiece)) {
        moves.add(x + k + (y - k)*8);
        break;
      } else if (Piece.isNone(currPiece)) {
        moves.add(x + k + (y - k)*8);
      } else {
        break;
      }
      k++;
    }

    // #2 TOP LEFT DIAGONAL
    k = 1;
    while (posCheck(x - k, y - k)) {
      int currPiece = board[x - k][y - k];
      if (Piece.isOpposite(piece, currPiece)) {
        moves.add(x - k + (y - k)*8);
        break;
      } else if (Piece.isNone(currPiece)) {
        moves.add(x - k + (y - k)*8);
      } else {
        break;
      }
      k++;
    }
    // #3 BOTTOM LEFT DIAGONAL
    k = 1;
    while (posCheck(x - k, y + k)) {
      int currPiece = board[x - k][y + k];
      if (Piece.isOpposite(piece, currPiece)) {
        moves.add(x - k + (y + k)*8);
        break;
      } else if (Piece.isNone(currPiece)) {
        moves.add(x - k + (y + k)*8);
      } else {
        break;
      }
      k++;
    }
    // #4 BOTTOM RIGHT DIAGONAL
    k = 1;
    while (posCheck(x + k, y + k)) {
      int currPiece = board[x + k][y + k];
      if (Piece.isOpposite(piece, currPiece)) {
        moves.add(x + k + (y + k)*8);
        break;
      } else if (Piece.isNone(currPiece)) {
        moves.add(x + k + (y + k)*8);
      } else {
        break;
      }
      k++;
    }

    return moves;
  }

  ArrayList<Integer> rookMoves(int piece, int pos) {
    int x = pos%8;
    int y = pos/8;
    ArrayList<Integer> moves = new ArrayList<>();

    // #1 BOTTOM DIAGONAL
    int k = 1;
    while (posCheck(x, y + k)) {
      int currPiece = board[x][y + k];
      if (Piece.isOpposite(piece, currPiece)) {
        moves.add(x + (y + k)*8);
        break;
      } else if (Piece.isNone(currPiece)) {
        moves.add(x + (y + k)*8);
      } else {
        break;
      }
      k++;
    }

    // #2 TOP  DIAGONAL
    k = 1;
    while (posCheck(x, y - k)) {
      int currPiece = board[x][y - k];
      if (Piece.isOpposite(piece, currPiece)) {
        moves.add(x + (y - k)*8);
        break;
      } else if (Piece.isNone(currPiece)) {
        moves.add(x + (y - k)*8);
      } else {
        break;
      }
      k++;
    }
    // #3  LEFT DIAGONAL
    k = 1;
    while (posCheck(x - k, y)) {
      int currPiece = board[x - k][y];
      if (Piece.isOpposite(piece, currPiece)) {
        moves.add(x - k + y*8);
        break;
      } else if (Piece.isNone(currPiece)) {
        moves.add(x - k + y*8);
      } else {
        break;
      }
      k++;
    }
    // #4 RIGHT DIAGONAL
    k = 1;
    while (posCheck(x + k, y)) {
      int currPiece = board[x + k][y];
      if (Piece.isOpposite(piece, currPiece)) {
        moves.add(x + k + y*8);
        break;
      } else if (Piece.isNone(currPiece)) {
        moves.add(x + k + y*8);
      } else {
        break;
      }
      k++;
    }


    return moves;
  }

  ArrayList<Integer> queenMoves(int piece, int pos) {
    ArrayList<Integer> moves = bishopMoves(piece, pos);
    moves.addAll(rookMoves(piece, pos));
    return moves;
  }

  ArrayList<Integer> kingMoves(int piece, int pos) {
    int x = pos%8;
    int y = pos/8;
    ArrayList<Integer> moves = new ArrayList<>();


    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (posCheck(x + i, y + j)) {
          int currPiece = board[x+i][y+j];
          if (Piece.isNone(currPiece) || Piece.isOpposite(currPiece, piece)) {
            moves.add(x + i + (y + j)*8);
          }
        }
      }
    }
    return moves;
  }
}


void gameRendering(Game g) {
  // Board Rendering
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      fill(boardColors[i][j]);
      rect(i*squareSize, j*squareSize, squareSize, squareSize);
      if (game.board[i][j]!=0)
      image(images.get(g.board[i][j]), i*squareSize, j*squareSize, squareSize, squareSize);
    }
  }
  //
}
