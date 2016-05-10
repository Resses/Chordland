/**
  * Note.pde    
  * Game Design
  * Professor Kletenik
  */
//import Sound;
//import oscp5;

float noteSpeed = 2;

class Note {
    
  PVector pos;
  PVector vel; //speed 
  String note;
  float pitch;
  int max_x = 500, min_x = 0, max_y= 500, min_y = 0;
  int rad = 18; // radius
  int midi;
  float frequency;

  boolean switched = false;
  
  //constructor
  //Note(){
  //  this.note = "placeholder";
  //  this.pos = new PVector(30,30);
  //  this.vel = new PVector(noteSpeed,noteSpeed);
  //}
  ////constructor
  //Note(String note){
  //  this.note = note;
  //  this.pos = getRandomLoc();
  //  this.vel = new PVector(noteSpeed,noteSpeed);
  //}
  Note (String note){
    this.note = note;
  }
  //constructor
  Note(String note, PVector posi){
    this.note = note;
    this.pos = posi;
    this.vel = new PVector(noteSpeed,noteSpeed);
    this.midi =  noteToInt(note);
    this.frequency = midiToFreq(midi);
  }
  void updatePos(){
  // Update the position of the shape
    pos.x = pos.x + ( vel.x  );
    pos.y = pos.y + ( vel.y );
  }
  void relocate(){
    pos = getNewLoc(notes, notes.size());
  }
  void collide(){
   // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
    if ((pos.x > width-rad && vel.x > 0)|| (pos.x < rad && vel.x <0)) {
      //xdirection *= -1;
      vel.x = -vel.x;
    }
    // 
    if ((pos.y > height-130 && vel.y >0) || (pos.y < rad && vel.y <0) ) {
      //ydirection *= -1;
      vel.y = -vel.y;
    }

   }
  
  void noteCollide(Note scnd){
    //Tests to see if the notes collide
    if(dist(pos.x,pos.y,scnd.pos.x,scnd.pos.y) < (rad*2)){
//      println("collided");
      if(!switched){
        vel.x = -vel.x;
        vel.y = -vel.y;
        switched = true;
      }
      if(!scnd.switched){
        scnd.vel.x = -scnd.vel.x;
        scnd.vel.y = -scnd.vel.y;
        scnd.switched = true;
      }
     /* xdirection *= -1;
      ydirection *= -1;
      scnd.xdirection *= -1;
      scnd.ydirection *= -1; */
    }
  }
  
  boolean isEqual(Note scnd){
    //return if they have the same position or not
    return (pos.x == scnd.pos.x && pos.y == scnd.pos.y) ? true : false;
  }
  
 /* PVector getPos();//returns position of note
  PVector getDiameter();//returns diameter of note
  char getNote();
  */
  //float getPitch();
  void playSound(){
    
  }
  //void slowDown();
  //void doublePoints();
  
  void draw(){
    noFill();
    ellipseMode(RADIUS);
    //updatePos();
    ellipse(pos.x, pos.y, rad, rad);
    textAlign(CENTER,CENTER);
    textSize(24);
    text(note, pos.x, pos.y);
  }

   int noteToInt(String n){
     int note = C;
     switch(n){
       case "C": note = C; break;
       case "D": note = D; break;
       case "E": note = E; break;
       case "F": note = F; break;
       case "G": note = G; break;
       case "A": note = A; break;
       case "B": note = B; break;
       case "F#": note = Fs; break;
       case "Gb": note = Gb; break;
       case "Db": note = Db; break;
       case "C#": note = Cs; break;
       case "Ab": note = Ab; break;
       case "Eb": note = Eb; break;
       case "Bb": note = Bb; break;
     }
     return note;
   }
  void playNote(){
    sawOsc.play(frequency,0.9);
  // levels we defined earlier
    env.play(sawOsc, attackTime, sustainTime, sustainLevel, releaseTime);
  }
}