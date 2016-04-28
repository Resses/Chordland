//this is for chords in key of c major. Temporary...

final int C = 1;
final int D = 2;
final int E = 3;
final int F = 4;
final int G = 5;
final int A = 6;
final int B = 7;

char []notes = {'C','D','E','F','G','A','B'};

final int MAJOR = 0;
final int MINOR = 1;

class Chord{
  char key = 'c';
  int type;
  char root;
  char third;
  char fifth;
  //char seventh;
   
  Chord(int root){
    if(root == 1 || root == 3 || root == 5){
      type = MAJOR;
    }
    else type = MINOR;
    root --; //subtracting one to correspond with elements in the array
    this.root = notes[root];
    third = notes[(root+2) % 7];
    fifth = notes[(root+4) % 7];
    printChord();
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
