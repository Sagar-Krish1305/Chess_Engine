static class Piece{
  
  static int White = 16;
  static int Black = 8;
  
  static int None = 0;
  final static int Pawn = 1;
  final static int Knight = 2;
  final static int Bishop = 3;
  final static int Rook = 4;
  final static int Queen = 5;
  final static int King = 6;
  
  static boolean isNone(int piece){
    return piece==0;
  }
  static boolean isWhite(int piece){
    // 00 000 
    return  !isNone(piece)  && ((White & piece)==White);
  }
  
  static boolean isBlack(int piece){
    // 00 000 
    return !isNone(piece) && ((Black & piece)==Black);
  }
  
  static boolean isPawn(int piece){ 
    return (7 & piece)==Pawn;
  }
  
  static boolean isKnight(int piece){
    return (7 & piece)==Knight;
  }
  
  static boolean isBishop(int piece){
    return (7 & piece)==Bishop;
  }
  
  static boolean isRook(int piece){ 
    return (7 & piece)==Rook;
  }
  
  static boolean isQueen(int piece){
    return (7 & piece)==Queen;
  }
  
  static boolean isKing(int piece){
    return (7 & piece)==King;
  }
  
  static boolean isOpposite(int piece1, int piece2){
    return !isNone(piece1) && !isNone(piece2) && (isWhite(piece1) ^ isWhite(piece2));
  }
}
