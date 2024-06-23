Game FENGame(String s){
   
   int[][] currBoard = new int[8][8];
   String[] s1 = s.split(" ",0);
   int a = 0, b = 0;
   int bKing = -1, wKing = -1;
   for(int i = 0 ; i < s1[0].length() ; i++){
     
     if(s1[0].charAt(i) == '/'){
       a = 0;
       b++;
     }else if(s1[0].charAt(i) == 'p'){
       currBoard[a][b] = Piece.Black | Piece.Pawn;
       a++;
     }else if(s1[0].charAt(i) == 'P'){
       currBoard[a][b] = Piece.White | Piece.Pawn;
       a++;
     }else if(s1[0].charAt(i) == 'n'){
       
       currBoard[a][b] = Piece.Black | Piece.Knight;
       a++;
     }else if(s1[0].charAt(i) == 'N'){
       currBoard[a][b] = Piece.White | Piece.Knight;
       a++;
     }else if(s1[0].charAt(i) == 'b'){
       
      currBoard[a][b] = Piece.Black | Piece.Bishop;
      a++;
     }else if(s1[0].charAt(i) == 'B'){
       currBoard[a][b] = Piece.White | Piece.Bishop;
       a++;
     }else if(s1[0].charAt(i) == 'q'){
       currBoard[a][b] = Piece.Black | Piece.Queen;
       a++;
     }else if(s1[0].charAt(i) == 'Q'){
       currBoard[a][b] = Piece.White | Piece.Queen;
       a++;
     }else if(s1[0].charAt(i) == 'k'){
       bKing = a + 8*b;
       currBoard[a][b] = Piece.Black | Piece.King;
       a++;
     }else if(s1[0].charAt(i) == 'K'){
       wKing = a + 8*b;
       currBoard[a][b] = Piece.White | Piece.King;
       a++;
     }else if(s1[0].charAt(i) == 'r'){
       currBoard[a][b] = Piece.Black | Piece.Rook;
       a++;
     }else if(s1[0].charAt(i) == 'R'){
       currBoard[a][b] = Piece.White | Piece.Rook;
       a++;
     }else{// num
       int alpha = (int) (s1[0].charAt(i) - '0');
       
       for(int y = 0 ; y < alpha ; y++){
         currBoard[a + y][b] = Piece.None;
         
       }
       a = a + alpha;
     }
     
     
   }
   
   // Setting Up the turn and Castles;
   boolean turn = (s1[1].charAt(0) == 'w');
   boolean blackCastle = true;
   boolean whiteCastle = true;
   
   String str = s1[2];
   if(str.length() == 2){
     if(str.charAt(0) == 'k'){
       blackCastle = true;
      
     }else{
        whiteCastle = true;
     }
   }
   
   
   Game g = new Game(currBoard, turn, blackCastle, whiteCastle);
   return g;
}
