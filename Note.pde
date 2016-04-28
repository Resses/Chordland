/**
  * Note.pde    
  * Christopher Menedes, Kwan Holloway, Renee Esses
  * Game Design
  * Professor Kletenik
  */
//import Sound;
//import oscp5;

class Note {
    
  PVector pos;
  PVector vel;
  int d = 100;
  String note;
  float pitch;
  
  //constructor
  Note(String note, PVector pos){
    this.note = note;
    this.pos = pos;
  }
 /* PVector getPos();//returns position of note
  PVector getDiameter();//returns diameter of note
  char getNote();
  float getPitch();
  void playSound();
  void slowDown();
  void doublePoints();
  */
  void draw(){
    noFill();
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, 40,30);
    textAlign(CENTER,CENTER);
    textSize(18);
    text(note, pos.x, pos.y);
  }
}
