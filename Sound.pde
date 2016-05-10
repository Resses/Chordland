import ddf.minim.*;
AudioPlayer songPlayer;
Minim minim;
 

/* SOUND */

  import processing.sound.*;

// Oscillator and envelope 
SawOsc sawOsc = new SawOsc(this);
Env env = new Env(this);

// Times and levels for the ASR envelope
float attackTime = 0.001;
float sustainTime = 0.4;
float sustainLevel = 0.2;
float releaseTime = 0.2;

// This is an octave in MIDI notes.
int[] midiSequence = { 
  60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72
}; 

// Set the duration between the notes
int duration = 200;
// Set the note trigger
int trigger = 0; 

// An index to count up the notes
int noteIndex = 0;
  
//calculates the respective frequency of a MIDI note
//will accept and integer that represents a MIDI note
float midiToFreq(int note) {
  return (pow(2, ((note-69)/12.0)))*440; 
}
void func(){
  int A = 69;
  println(midiToFreq(A));
  
}
/* SOUND STUFF END */
  