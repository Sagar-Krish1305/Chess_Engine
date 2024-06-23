class PawnPromotion extends PApplet{
  
  boolean White;
  int pieces[];
  PawnPromotion(boolean White){
    this.White = White;
    super.runSketch(new String[]{"PawnPromotion"}, this);
  }
  
  void settings(){
    size(300,300);
    pieces = new int[]{Piece.Knight, Piece.Bishop, Piece.Rook, Piece.Queen};
    for(int i = 0 ; i < pieces.length ; i++){
      pieces[i] |= White?Piece.White:Piece.Black;
    }
  }
  
  void draw(){
    background(White?255:0);
    line(width/2, 0, width/2, height);
    line(0, height/2, width, height/2);
    
    for(int i = 0 ; i < 2 ; i++){
      for(int j = 0 ; j < 2 ; j++){
        image(images.get(pieces[i + 2*j]), i*(width/2), j*height/2, width/2, height/2);
      }
    }
  }
  
  void mousePressed(){
    int x = (int)map(mouseX, 0, width, 0, 2);
    int y = (int)map(mouseY, 0, width, 0, 2);
    pawnChangedPiece = pieces[x + y*2];
    surface.setVisible(false);
    //noLoop();
  }
}
