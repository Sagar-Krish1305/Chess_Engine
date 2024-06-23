boolean posCheck(int x,int y){
  return (x >= 0 && x <= 7)&&(y >= 0 && y <= 7);
}


void availableMovesRendering(int pos, Game g){
  ArrayList<Integer> moves = g.getMoves(pos, g.board[pos%8][pos/8]);
  
  for(int position : moves){
    boardColors[position%8][position/8] = color(255,0,0);
  }
}


boolean isCheck(boolean white, Game g){
  int piece = Piece.King;
  if(white){
    piece |= Piece.White;
  }else{
    piece |= Piece.Black;
  }
  println(g.pieceLocation.get(piece));
  int pos = g.pieceLocation.get(piece).get(0);
  
  ArrayList<Integer> availPositionOfCheck;
    
    // Check For Knight;
      availPositionOfCheck = g.knightMoves(piece,pos);
        for(int position : availPositionOfCheck){
          int currPiece = g.board[position%8][position/8];
          if(Piece.isOpposite(currPiece, piece) && Piece.isKnight(currPiece)){
            return true;
          }
        }
      availPositionOfCheck.clear();
      availPositionOfCheck = g.rookMoves(piece,pos);
        for(int position : availPositionOfCheck){
          int currPiece = g.board[position%8][position/8];
          if(Piece.isOpposite(currPiece, piece) && (Piece.isQueen(currPiece) || Piece.isRook(currPiece))){
            return true;
          }
        }
      availPositionOfCheck.clear();
      availPositionOfCheck = g.bishopMoves(piece,pos);
        for(int position : availPositionOfCheck){
          int currPiece = g.board[position%8][position/8];
          if(Piece.isOpposite(currPiece, piece) && (Piece.isQueen(currPiece) || Piece.isBishop(currPiece))){
            return true;
          }
        }
      availPositionOfCheck.clear();
      availPositionOfCheck = g.pawnMoves(piece,pos);
        for(int position : availPositionOfCheck){
          int currPiece = g.board[position%8][position/8];
          if(Piece.isOpposite(currPiece, piece) && Piece.isPawn(currPiece)){
            return true;
          }
        }
      availPositionOfCheck.clear();
  
  return false;
}


boolean isCheckmate(boolean white, Game g){
  if(white ? g.whiteCheck : g.blackCheck){ // if there is no currently check then we can't say it as Checkmate
    println("Here");
    return false;
  }
  // Get All the Possible Moves;
    
    int pieceType = (white? Piece.White : Piece.Black);
    for(Integer pos : g.pieceLocation.get(Piece.Pawn | pieceType)){
      if(g.getMoves(pos, Piece.Pawn | pieceType).size() != 0){
        println("Here Pawn");
        return false;
      }
    }
    
    for(Integer pos : g.pieceLocation.get(Piece.Knight | pieceType)){
      if(g.getMoves(pos, Piece.Knight | pieceType).size() != 0){
        println("Here Knight");
        return false;
      }
    }
    
    for(Integer pos : g.pieceLocation.get(Piece.Bishop | pieceType)){
      if(g.getMoves(pos, Piece.Bishop | pieceType).size() != 0){
        println("Here Bishop");
        return false;
      }
    }
    
    for(Integer pos : g.pieceLocation.get(Piece.Rook | pieceType)){
      if(g.getMoves(pos, Piece.Rook | pieceType).size() != 0){
        println("Here Rook");
        return false;
      }
    }
    
    for(Integer pos : g.pieceLocation.get(Piece.Queen | pieceType)){
      if(g.getMoves(pos, Piece.Queen | pieceType).size() != 0){
        println("Here Queen");
        return false;
      }
    }
    
    for(Integer pos : g.pieceLocation.get(Piece.King | pieceType)){
      if(g.getMoves(pos, Piece.King | pieceType).size() != 0){
        println("Here King");
        return false;
      }
    }
    
    return true;
  // 
}
