/*
*  Sound File with ToneInstrument Class Sketch
*  Version 1.0
*  Game Design Final Project(SPR 2016)
*
*  Created by Chris Menedes, Renee Esess, and Kwan Holloway
*
*/

//import Minim library for sound needs
import ddf.minim.*;
import ddf.minim.ugens.*;

AudioPlayer songPlayer;
Minim minim;

Minim min = new Minim(this);//create minim object
AudioOutput out = min.getLineOut();//create audio output object
Waveform saw = Waves.sawh( 15 );//create saw wave with 15 harmonics
//set envelope parameters
float maxAmp = 0.8 ,attTime = .001, decTime = 0.6, susLvl = 0.2, relTime = 0.4;

//calculates the respective frequency of a MIDI note
float midiToFreq(int note) {
  return (pow(2, ((note-69)/12.0)))*440; 
}

class ToneInstrument implements Instrument
{
  // create all variables that must be used througout the class
  Oscil osc, LFO;//create basic oscillator and low frequency oscillator
  ADSR  adsr;//adsr envelope
  Pan pan;
  Delay myDelay; 

  boolean isDelay;
  boolean isPanning;

  // constructor for this instrument
  ToneInstrument( float frequency, float amplitude, boolean isDelay, boolean isPanning )
  {    
    // create new instances of any UGen objects as necessary
    osc = new Oscil( frequency, amplitude, saw );
    adsr = new ADSR(maxAmp, attTime, decTime, susLvl, relTime);
    this.isDelay = isDelay;
    this.isPanning = isPanning;
    
    // patch everything together up to the final output
     osc.patch(adsr);//add envelope to oscillator
     //if delay is activated, add delay to patch
     if(isDelay){
       myDelay = new Delay( 0.4, 0.5, true, true );
       adsr.patch(myDelay);
     }
     //if pan is activated, add pan to patch
     else if(isPanning){
       pan = new Pan(0);
       LFO = new Oscil(10, 0.5, Waves.SINE);//LFO  frequency controls pan rate
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
    else if(isPanning) pan.patch(out);
    else adsr.patch(out);
   }
  
  // every instrument must have a noteOff() method
  public void noteOff()
  {
    // tell the ADSR to unpatch after the release is finished
    adsr.unpatchAfterRelease(out);
    //if(isDelay) myDelay.unpatch(out);
    if(isPanning) pan.unpatch(out);
    // call the noteOff 
    adsr.noteOff();
  }
}