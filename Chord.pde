//This class right now is made up of three strings to correspond to the notes in the chord, and an integer type
//it has a method to print the chord, get the chord as a string with or without note names, and play the chord as an arpeggio

color[] chordColors = {#ff0000, #8802D1, #0000ff, #ff00ff, #000000, #FF8103, #13715B};

class Chord{
  int type;
  String root;
  String third;
  String fifth;
  color COLOR;
  
   //default constructor creates c major
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
  
  //draws the name of the chord on the top left 
  void draw(){
   fill(COLOR);
   textSize(20);
   textAlign(LEFT, TOP);
   text(getChordString(), 10, 10);
  }
  
  //creates a note object for each note in the chord and plays them one at a time
  void playChord(){
    Note one = new Note(root, 1);
    Note three = new Note(third, 3);
    Note five = new Note(fifth, 5);
    println("playing");
    one.playNote(g.delayFlag, g.reverbFlag);
    delay(500);
    three.playNote(g.delayFlag, g.reverbFlag);
    delay(500);
    five.playNote(g.delayFlag, g.reverbFlag);
  }
}