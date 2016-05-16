import ddf.minim.*;
import ddf.minim.ugens.*;

AudioPlayer songPlayer;
Minim minim;

Minim min = new Minim(this);
AudioOutput out = min.getLineOut();
Waveform saw = Waves.sawh( 15 );
float maxAmp = 0.8 ,attTime = .001, decTime = 0.6, susLvl = 0.2, relTime = 0.4;

/* SOUND */

//import processing.sound.*;

//SawOsc sawOsc = new SawOsc(this);
//Env env = new Env(this);
//Reverb reverb = new Reverb(this);
//Delay delay = new Delay(this);
    
// Times and levels for the ASR envelope
//float attackTime = 0.001;
//float sustainTime = 0.4;
//float sustainLevel = 0.2;
//float releaseTime = 0.2;

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
//void func(){
//  int A = 69;
//  println(midiToFreq(A));
  
//}
/* SOUND STUFF END */
  
class ToneInstrument implements Instrument
{
  // create all variables that must be used througout the class
  Oscil osc, LFO;
  ADSR  adsr;
  Pan pan;
  Delay myDelay; 

  boolean isDelay;
  boolean isReverb;

  // constructor for this instrument
  ToneInstrument( float frequency, float amplitude, boolean isDelay, boolean isReverb )
  {    
    // create new instances of any UGen objects as necessary
    osc = new Oscil( frequency, amplitude, saw );
    adsr = new ADSR(maxAmp, attTime, decTime, susLvl, relTime);
    this.isDelay = isDelay;
    this.isReverb = isReverb;
    
    // patch everything together up to the final output
     osc.patch(adsr);
     if(isDelay){
       myDelay = new Delay( 0.4, 0.5, true, true );
       adsr.patch(myDelay);
     }
     else if(isReverb){
       pan = new Pan(0);
       LFO = new Oscil(10, 0.5, Waves.SINE);
       adsr.patch(pan);
       LFO.patch(pan.pan);
     }
  }
  
  // every instrument must have a noteOn( float ) method
  public void noteOn( float dur )
  {
    // turn on the ADSR
    adsr.noteOn();
    // patch to the output
    if(isDelay) myDelay.patch(out);
    else if(isReverb) pan.patch(out);
    else adsr.patch(out);
   }
  
  // every instrument must have a noteOff() method
  public void noteOff()
  {
    // tell the ADSR to unpatch after the release is finished
    adsr.unpatchAfterRelease(out);
    //if(isDelay) myDelay.unpatch(out);
    if(isReverb) pan.unpatch(out);
    // call the noteOff 
    adsr.noteOff();
  }
}