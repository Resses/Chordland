/*
*  Chord Class Sketch
*  Version 1.0
*  Game Design Final Project(SPR 2016)
*
*  Created by Chris Menedes, Renee Esess, and Kwan Holloway
*
*/
//This class is made up of three strings to correspond to the notes in the chord, and an integer type
//it has a method to print the chord, get the chord as a string with or without note names, and play the chord as an arpeggio

color[] chordColors = {#ff0000, #8802D1, #0000ff, #ff00ff, #000000, #FF8103, #13715B};

class Chord{
  int type;
  String root;
  String third;
  String fifth;
  color COLOR;
  
   //default constructor creates C Major
   Chord(){
    this.root = "C";
    this.third = "E";
    this.fifth = "G";
    this.type = MAJOR;
   }
   
  //constructor that accepts all note names and type 
  Chord(String root, String third, String fifth, int type){
   this.root = root;
   this.third = third;
   this.fifth = fifth;
   this.type = type;
  }

  //returns string that corresponds to the final int of the type
  // aka the type of chord it is
  String getTypeString(int t){
    switch(t){
      case DIMINISHED:
        return "Diminished";
      case MINOR: 
        return "Minor";
      case MAJOR:
      default:
        return "Major";
    }
  }
  
  // gets a string representation of the chord
  //if in master mode, only returns the name of the chord
  //else, returns the name of the chord and the notes in it
  String getChordString(){
    fill(COLOR);
    if(g.mode == MASTER){
      return(root + " " + getTypeString(type));
    }
    else{
      return((root + " " + getTypeString(type) + " : " + root + " " + third + " "  + fifth));
    }
  }
  
  // displays chord in upper left of screen
  void draw(){
   fill(COLOR);
   textSize(20);
   textAlign(LEFT, TOP);
   text(getChordString(), 10, 10);
  }
  
  //creates a note object for each note in the chord and plays them one at a time to simulate a natural arpeggiated chord
  void playChord(){
    Note one = new Note(root, 1);
    Note three = new Note(third, 3);
    Note five = new Note(fifth, 5);
    println("playing");
    one.playNote(g.delayFlag, g.panningFlag);
    delay(500);
    three.playNote(g.delayFlag, g.panningFlag);
    delay(500);
    five.playNote(g.delayFlag, g.panningFlag);
  }
}