//This class right now is made up of three strings to correspond to the notes in the chord, and an integer type
//it has a method to print the chord
class Chord{
  int type;
  String root;
  String third;
  String fifth;
  //String seventh;
   
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
    return((root + " " + getTypeString(type) + " : " + root + " " + third + " "  + fifth));
  }
  
  void draw(){
   //String chordDisplay = printChord();
   fill(COLOR);
   textSize(20);
   textAlign(LEFT, TOP);
   text(getChordString(), 10, 10);

  }
  void playChord(){
    Note one = new Note(root);
    Note three = new Note(third);
    Note five = new Note(fifth);
    one.playNote();
    three.playNote();
    five.playNote();
  }
}