//This class right now is made up of three strings to correspond to the notes in the chord, and an integer type
//it has a method to print the chord
class Chord{
  int type;
  String root;
  String third;
  String fifth;
  //String seventh;
   
  Chord(String root, String third, String fifth, int type){
   this.root = root;
   this.third = third;
   this.fifth = fifth;
   this.type = type;
  }
  
  String getTypeString(int t){
    switch(t){
      case MINOR: 
        return "Minor";
      case MAJOR:
      default:
        return "Major";
    }
  }
  
  void printChord(){
    print(root + " " + getTypeString(type) + " : " + root + " " + third + " "  + fifth);
  }
}
