/*
*  Key Class Sketch
*  Version 1.0
*  Game Design Final Project(SPR 2016)
*
*  Created by Chris Menedes, Renee Esess, and Kwan Holloway
*
*/

//This class will accept an integer corresponding to the correct key, and integer corresponding to major and minor.
//It will use these to get the notes in the scale
//It has a method to return a chord in the scale

//integers that represent one octave of midi values
final int C = 60;
final int D = 62;
final int E = 64;
final int F = 65;
final int G = 67;
final int A = 69;
final int B = 71;

final int Cb = 71;
final int Fs = 66; 
final int Gb = 66;
final int Db = 61;
final int Cs = 61;
final int Ab = 68;
final int Eb = 63;
final int Bb = 70;

final int MAJOR = 0;
final int MINOR = 1;
final int DIMINISHED = 2;

class Key{
  int currentKey;
  int type;
  String []scale;  
  
  //constructor
  Key(int k, int t){
    currentKey = k;
    type = t;
    getScale();
  }
    
  //sets the key's scale with corresponding notes
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
      case Fs:
        String []fs = {"F#", "G#", "A#", "B", "C#", "D#", "E#"}; 
        scale = fs;  
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

  //accepts num in scale for root of chord
   void fillNotes(int r){
     notes.clear();
     // the last parameter helps with getting the right octave. 
     //if were playing chord c major : c-e-g, c will be 1, e will be 3 and g will be 5
      for(int i = 0; i < scale.length; i ++){
          if(i+1 == r) 
           notes.add(new Note(scale[i], getNewLoc(notes, notes.size()) , 1));
          else if (i+1 == (r+2)%7 ) {
           notes.add(new Note(scale[i], getNewLoc(notes, notes.size()) , 3));
          }
          else if (i+1 == (r+4)%7){
           notes.add(new Note(scale[i], getNewLoc(notes, notes.size()) , 5));
          }
          else{
           notes.add(new Note(scale[i], getNewLoc(notes, notes.size()) , 0));
          }
      } 
   }
}