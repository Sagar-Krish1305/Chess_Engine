class GameOver extends PApplet{ 
  String s;
  GameOver(String s){
    this.s = s;
    PApplet.runSketch(new String[]{"GameOver"}, this);
  }
  
  void settings(){
    size(200,200);
    
  }
  
  void draw(){
    background(0);
    textSize(20);
    stroke(255);
    text(s, 60, 100);
  }
  
}
