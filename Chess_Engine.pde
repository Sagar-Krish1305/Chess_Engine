import java.util.*;
color lightColor, darkColor, selectColor, availMovesColor;
int squareSize;

HashMap<Integer, PImage> images = new HashMap<Integer, PImage>();


Game game;
color[][] boardColors;


void settings(){
  size(600,600);
  //strokeWeight(2);
  game = FENGame("rnbqkbnr/ppp2ppp/8/3p4/3P4/8/PPP2PPP/R1BQKBNR b KQkq - 0 5"); // 
  //Checkmated : rnbqkbnr/pppp1p1p/8/4p3/4P3/8/PPP2PPP/R1BQKBNR b KQkq - 0 6
  //Original : rnbqkbnr/ppp1pppp/8/3p4/3P4/8/PPP2PPP/R1BQKBNR b KQkq - 0 5
  darkColor = color(random(80,128));
  lightColor = color(random(196,255));
  selectColor = color(255,204,0);
  availMovesColor = color(51,153,255);
  squareSize = width/8; // Cover the Board
  
   boardColors = new color[8][8];// Colors
   for(int i = 0 ; i < 8 ; i++){
     for(int j = 0 ; j < 8 ; j++){
       if((i+j)%2==0){
         boardColors[i][j] = lightColor;
       }else{
         boardColors[i][j] = darkColor;
       }
     }
   }
   
  for(int i = 9 ; i <= 14 ; i++){ 
    images.put(i,  loadImage("assets/" + i + "_.png"));
  }
  
  for(int i = 17 ; i <= 23 ; i++){ 
    images.put(i,  loadImage("assets/" + i + "_.png"));
  }
  
}

void draw(){
  if(game.blackCheck){
    int pos = game.pieceLocation.get(Piece.Black | Piece.King).get(0);
    boardColors[pos%8][pos/8] = color(255,0,0);
  }else{
    int pos = game.pieceLocation.get(Piece.Black | Piece.King).get(0);
    boardColors[pos%8][pos/8] = ((pos%8 + pos/8)%2==0 ? lightColor:darkColor);
  }
  if(game.whiteCheck){
    int pos = game.pieceLocation.get(Piece.White | Piece.King).get(0);
    boardColors[pos%8][pos/8] = color(255,0,0);
  }else{
    int pos = game.pieceLocation.get(Piece.White | Piece.King).get(0);
    boardColors[pos%8][pos/8] = ((pos%8 + pos/8)%2==0 ? lightColor:darkColor);
  }
  
  gameRendering(game);
  
  
}

int sourceX = -1, sourceY = -1;
boolean clickChecker = false; // if clicked then true
ArrayList<Integer> availMoves;
int pawnChangedPiece = -1;
void mousePressed(){
  if(clickChecker){
    
    int destX = (int)map(mouseX, 0, width, 0, 8);
    int destY = (int)map(mouseY, 0, height, 0, 8);
    if(availMoves.contains(destX + destY * 8)){
     game.makeMove(sourceX + sourceY * 8, destX + destY * 8);
     println("WhiteCheckmate: " + isCheckmate(true, game));
     println("BlackCheckmate: " + isCheckmate(false, game));
    }
    clickChecker = !clickChecker;
    boardColors[sourceX][sourceY] = (sourceX + sourceY)%2==0?lightColor:darkColor;
    // Render Available Pos to Original
    for(int pos : availMoves){
      boardColors[pos%8][pos/8] = (pos%8 + pos/8)%2==0 ? lightColor:darkColor;
    }
      
  }else{
    sourceX = (int)map(mouseX, 0, width, 0, 8);
    sourceY = (int)map(mouseY, 0, height, 0, 8);
    int piece = game.board[sourceX][sourceY];
    
    if(!Piece.isNone(piece) && ((Piece.isBlack(piece) && game.turn==false) || (Piece.isWhite(piece) && game.turn==true))){
      
      boardColors[sourceX][sourceY] = selectColor;
      // Render Available Pos
      
      availMoves = game.getMoves(sourceX + sourceY * 8, piece);
      for(int pos : availMoves){
        boardColors[pos%8][pos/8] = availMovesColor;
      }
      clickChecker = !clickChecker;
    }
  }
  
  
  
}
