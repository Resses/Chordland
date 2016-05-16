//This class right now is made up of three strings to correspond to the notes in the chord, and an integer type
//it has a method to print the chord

color[] chordColors = {#ff0000, #8802D1, #0000ff, #ff00ff, #000000, #FF8103, #13715B};

class Chord{
  int type;
  String root;
  String third;
  String fifth;
  //String seventh;
  color COLOR;
   
   Chord(){
    this.root = "C";
    this.third = "E";
    this.fifth = "G";
    this.type = MAJOR;
   }
  Chord(String root, String third, String fifth, int type){
   this.root = root;
   this.third = third;
   this.fifth = fifth;
   this.type = type;
  }
  
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
  
  String getChordString(){
    fill(COLOR);
    if(g.mode == MASTER){
      return(root + " " + getTypeString(type));
    }
    else{
      return((root + " " + getTypeString(type) + " : " + root + " " + third + " "  + fifth));
    }
  }
  
  void draw(){
   //String chordDisplay = printChord();
   fill(COLOR);
   textSize(20);
   textAlign(LEFT, TOP);
   text(getChordString(), 10, 10);

  }
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
    //delay(500);
  }
}