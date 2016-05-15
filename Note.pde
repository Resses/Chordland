/**
  * Note.pde    
  * Game Design
  * Professor Kletenik
  */

float noteSpeed = 2;
int noteRadius = 18; // radius

class Note {
    
  PVector pos;
  PVector vel; //speed 
  String note;
  float pitch;
  int max_x = 500, min_x = 0, max_y= 500, min_y = 0;
  int midi;
  float frequency;

  boolean switched = false;
  
  //constructor
  Note (String note, int numInScale){
    this.note = note;
    this.midi =  noteToInt(note);
    checkOctave(numInScale);
    this.frequency = midiToFreq(midi);
  }
  //constructor
  Note(String note, PVector posi, int numInScale){
    this.note = note;
    this.pos = posi;
    this.vel = new PVector(noteSpeed,noteSpeed);
    this.midi =  noteToInt(note);
    checkOctave(numInScale);
    this.frequency = midiToFreq(midi);
  }
  void updatePos(){
  // Update the position of the shape
    if(vel.x < 0){vel.x = -noteSpeed;}
    else{vel.x = noteSpeed;}
    if(vel.y<0){vel.y = -noteSpeed;}
    else{vel.y = noteSpeed;}
    pos.x = pos.x + ( vel.x  );
    pos.y = pos.y + ( vel.y );
  }
  void relocate(){
    pos = getNewLoc(notes, notes.size());
  }
  void collide(){
   // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
    if ((pos.x > width-noteRadius && vel.x > 0)|| (pos.x < noteRadius && vel.x <0)) {
      //xdirection *= -1;
      vel.x = -vel.x;
    }
    // 
    if ((pos.y > height-130 && vel.y >0) || (pos.y < noteRadius && vel.y <0) ) {
      //ydirection *= -1;
      vel.y = -vel.y;
    }

   }
  
  void noteCollide(Note scnd){
    //Tests to see if the notes collide
    if(dist(pos.x,pos.y,scnd.pos.x,scnd.pos.y) < (noteRadius*2)){
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
    ellipse(pos.x, pos.y, noteRadius, noteRadius);
    textAlign(CENTER,CENTER);
    textSize(24);
    fill(g.c.COLOR);
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
  
  //void checkOctave(int noteInScale){
  //  println("IN check octave");
  //  if(noteInScale == 3){
  //    //compare to first
  //    if(midi < noteToInt(g.c.root)){
  //      midi +=12;
  //      println("changing midi");
  //    }
  //  }
  //  if(noteInScale == 5){
  //    //compare third to first
  //    if(noteToInt(g.c.third) < noteToInt(g.c.root)){
  //      midi +=12;
  //      println("changing midi");
  //    }
  //  }
  //}
  
  void checkOctave(int numInScale){
    println("IN check octave");
    if(numInScale == 3){
      if(noteToInt(g.c.fifth) <= noteToInt(g.c.root)){
        midi+=12;
        println("changing midi");
      }
    }
    if(numInScale == 5){
      if(midi <= noteToInt(g.c.root)){
        midi+=12;
        println("changing midi");
      }
    }
  }
  
  ////converts string to midi note, to be converted to frequency
  //int noteToMidi(Note tempNote) {
  //    return int(tempNote.note);  
  //}

}