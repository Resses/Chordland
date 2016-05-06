//This class will accept an integer corresponding to the correct key, and integer corresponding to major and minor.
//It will use these to get the notes in the scale
//It has a method to return a chord in the scale

//major keys
final int C = 0;
final int D = 1;
final int E = 2;
final int F = 3;
final int G = 4;
final int A = 5;
final int B = 6;

final int Cb = 7;
final int Fs  = 8; //using s instead of # because # causes errors
final int Gb = 9;
final int Db = 10;
final int Cs = 11;
final int Ab = 12;
final int Eb = 13;
final int Bb = 14;

final int MAJOR = 0;
final int MINOR = 1;
final int DIMINISHED = 2;

class Key{
  int currentKey;
  int type;
  String []scale;  
  
  Key(int k, int t){
    currentKey = k;
    type = t;
    getScale();
  }
    
  void getScale(){
    switch(currentKey){
      default:
      case C:
        String []c = {"C", "D", "E", "F", "G", "A", "B"};
        scale = c;
        break;
      case G:
        String []g = {"G", "A", "B", "C", "D", "E", "F#"};
        scale = g;
        break;
      case D:
        String []d = {"D", "E", "F#", "G", "A", "B", "C#"};
        scale = d;
        break;
      case A:
        String []a = {"A", "B", "C#", "D", "E", "F#", "G#"};
        scale = a;
        break;
      case E:
        String []e = {"E", "F#", "G#", "A", "B", "C#", "D#"};
        scale = e;
        break;
      case B:
        String []b = {"B", "C#", "D#","E", "F#", "G#", "A#"};
        scale = b;
        break;
      case Cb:
        String []cb = {"Cb", "Db", "Eb", "Fb", "Gb", "Ab", "Bb"};
        scale = cb;
        break;      
      case Fs:
        String []fs = {"F#", "G#", "A#", "B", "C#", "D#", "E#"}; 
        scale = fs;  
        break;   
      case Gb:
        String []gb = {"Gb", "Ab", "Bb", "Cb", "Db", "Eb", "F"};
        scale = gb;  
       break;     
      case Db:        
        String []db = {"Db", "Eb", "F", "Gb", "Ab", "Bb", "C"};
        scale = db;  
        break;
      case Cs:
        String []cs = {"C#", "D#", "E#", "F#", "G#", "A#", "B#"};
        scale = cs;      
        break; 
      case Ab:
        String []ab = {"Ab", "Bb", "C", "Db", "Eb", "F", "G"};
        scale = ab;  
        break;
      case Eb:
        String []eb = {"Eb", "F", "G", "Ab", "Bb", "C", "D"}; 
        scale = eb;  
        break;   
      case Bb:
        String []bb = {"Bb", "C", "D","Eb", "F", "G", "A"}; 
        scale = bb;  
        break;    
      case F:
        String []f = {"F", "G", "A", "Bb", "C", "D","E"};
        scale = f;  
        break;
    }
  }
  
  //what number chord in the scale for a major key
  //accepts root = # between 1 and 7
  Chord getChord(int root){
     int t;
     String first, third, fifth;
     if(root == 1 || root == 4 || root == 5){
        t = MAJOR;
      }
      else if(root == 7){
        t = DIMINISHED;
      }
      else t = MINOR;
      root --; //subtracting one to correspond with elements in the array
      first = scale[root];
      third = scale[(root+2) % 7];
      fifth = scale[(root+4) % 7];
      return new Chord(first, third, fifth, t);
   }
   
   void fillNotes(){
     notes.clear();
      for(int i = 0; i < scale.length; i ++){
        if(i == 0){
         notes.add(new Note(scale[i], getRandomLoc())); 
        }
        else{
          notes.add(new Note(scale[i], getNewLoc(notes, notes.size())));
        }
      } 
   }
}
