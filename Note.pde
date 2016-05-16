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
  Note (String note, int numInChord){
    this.note = note;
    this.midi =  noteToInt(note);
    checkOctave(numInChord);
    this.frequency = midiToFreq(midi);
  }
  //constructor
  Note(String note, PVector posi, int numInChord){
    this.note = note;
    this.pos = posi;
    this.vel = new PVector(noteSpeed,noteSpeed);
    this.midi =  noteToInt(note);
    checkOctave(numInChord);
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
  
  //thirds midi needs to be > firsts
  //fifths midi needs to be > third
  void checkOctave(int numInChord){
    int thirdMidi = noteToInt(g.c.third);
    int fifthMidi = noteToInt(g.c.fifth);
    if(numInChord == 3 || numInChord == 5){
      //compare third to first
      if(thirdMidi < noteToInt(g.c.root)){
        thirdMidi += 12;
      }
      if(fifthMidi < thirdMidi){
        fifthMidi += 12;
      }
    }
    if(numInChord == 3){
      midi = thirdMidi;
    }
    if(numInChord == 5){
      midi = fifthMidi;
    }
    
  } 

//this play function is called during the changing chords 
 void playNote(boolean isDelay, boolean ispanning){
    out.playNote(0, 1.0, new ToneInstrument(frequency, 0.9, isDelay, ispanning));
 }
 void playNote(){
    //playnote parameters are start time in seconds from now, duration, and instrument
    //the instrument accepts frequency, amplitude, isDelay and ispanning
    if(g.powerupFlag){
      if(g.delayFlag){
        out.playNote(0, 1.0, new ToneInstrument(frequency, 0.9, true, false));
      }
      else if (g.panningFlag){
        out.playNote(0, 1.0, new ToneInstrument(frequency, 0.9, false, true));
      }
    }
    else{
      //no power up
      out.playNote(0, 0.3, new ToneInstrument(frequency, 0.9, false, false));
    }
    
    //SOUND LIB
    //sawOsc.play();
    //env.play(sawOsc, attackTime, sustainTime, sustainLevel, releaseTime);
    //sawOsc.freq(frequency);
    //sawOsc.amp(0.9);
    //sawOsc.pan(map(mouseX, 0, width, -1.0, 1.0));
    //delay.process(sawOsc, 5);
    //delay.time(0.5);
  }
  ////converts string to midi note, to be converted to frequency
  //int noteToMidi(Note tempNote) {
  //    return int(tempNote.note);  
  //}

}