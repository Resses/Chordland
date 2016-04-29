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
  PVector vel; //speed 
  int d = 100;
  String note;
  float pitch;
  int rad = 35; // radius
  int xdirection = 1;  // Left or Right
  int ydirection = 1;  // Top to Bottom
  
  //constructor
  Note(String note, PVector pos){
    this.note = note;
    this.pos = pos;
    this.vel = new PVector(2,3);
  }
    
  void updatePos(){
  // Update the position of the shape
  pos.x = pos.x + ( vel.x * xdirection );
  pos.y = pos.y + ( vel.y * ydirection );
  
  }
  
  void collide(){
   // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
    if (pos.x > width-rad || pos.x < rad) {
      xdirection *= -1;
    }
    if (pos.y > height-rad || pos.y < rad) {
      ydirection *= -1;
    }

   }
  
  void noteCollide(Note scnd){
    
    //Tests to see if the notes collide
    if(dist(pos.x-rad,pos.y-rad,scnd.pos.x-rad,scnd.pos.y-rad) < (rad*2)){
      xdirection *= -1;
      ydirection *= -1;
      scnd.xdirection *= -1;
      scnd.ydirection *= -1;
    }
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
    updatePos();
    ellipse(pos.x, pos.y, rad, rad);
    textAlign(CENTER,CENTER);
    textSize(18);
    text(note, pos.x, pos.y);
  }

}