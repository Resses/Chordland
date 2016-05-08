/*
  Chordland main sketch
  Authors: Christopher Menedes, Kwan Holloway, Renee Esses
*/


/*  MAX STUFF FOR SOUND  */

// load the P5 libraries:
import oscP5.*;
import netP5.*;

// create the objects we need for oscp5:
OscP5 oscP5;
NetAddress myRemoteLocation;

// we want to send
     // the type of powerup(reverb, delay, modulation)
     // pitch

import ddf.minim.*;
AudioPlayer songPlayer;
Minim minim;
 
  
  
PFont title, title1;
int x,y, weight;
int gameState;
int rad = 24;
int max_x = 500, min_x = 0, max_y= 500, min_y = 0;
int correct, incorrect;
String roundStats;

//game states
final  int GAMEOVER = -1;
final int STARTSCREEN = 0;
final int PLAY = 1;
final int CHOOSECHORDS = 2;

Player player;
ArrayList<Bullet> bullets;
ArrayList<Note> notes;
int shots;
Key k;
ArrayList<Integer>chordsLeft; 
int chordsMastered;
Button b1, b2, b3;
Chord c;
boolean winner;

void setup(){
  size(500,500);
  //load font for score keeping
  oscP5 = new OscP5(this,12000);//start oscP5
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
  //Note chord [] = new Note();
  player = new Player();
  gameState = STARTSCREEN;
  correct = 0;
  incorrect = 0;
  shots = 0;
  winner = false;
  title = createFont("font",75,true);
  title1 = createFont("ScorchedEarth.otf",70,true);
  bullets = new ArrayList <Bullet> ();
  notes = new ArrayList <Note> ();
  chordsLeft = new ArrayList<Integer>();
  for(int i = 1; i < 8; i++){
    chordsLeft.add(i);
  }
  chordsMastered = -1;
  //c = new Chord();//global chord variable, default constructor
  c = new Chord("C","E","G",MAJOR);
  minim = new Minim(this);//instantiate song object
  songPlayer = minim.loadFile("song.mp3");//create player
  songPlayer.play();//play song
  
}

void draw(){
  switch(gameState) {
    case GAMEOVER:
      background(0);
      fill(240);
      textAlign(CENTER);
      textSize(32);
      if(winner){
        text("MASTER!" , width/2, height/2);
      }
      else{
      text("Game Over", width/2, height/2);
      }
      textSize(16);
//      text("You got " + correct + " correct and " + incorrect + " incorrect.", width/2, height/2 + 50);
      text("You've mastered " + chordsMastered + " chords and got " + incorrect + " incorrect." , width/2, height/2 + 50);

      break;
      
    case STARTSCREEN: 
    //title screen info
      textAlign(CENTER);
      textFont(title1);
      fill(255);
      text("CHORDLAND",width/2,height/2 - 20);
      textFont(title, 16);
      fill(0);
      text("Use 'A' and 'D' or the left and right arrow keys to move player.", width/2, height/2 + 20);
      text(" Aim guitar with mouse, and click to shoot at notes!", width/2, height/2 +40);
      text(" Press 'Q' to quit the game.", width/2, height/2 +60);
      text(" Press 'Z' to begin!", width/2, height/2 +80);
      break;
    
    case PLAY: 
      //gameplay
      background(#cce6ff);
      textSize(14);
      text("Correct: " + correct, 10, 40);
      text("Incorrect: " + incorrect, 10, 60);
      text("Chords Mastered: " + chordsMastered, 10, 80);
//      text("shots: " + shots, 10, 70);
      checkNoteCollide(); //checks for notes colliding with each other
      for(int i = 0; i < notes.size(); i++){
        notes.get(i).collide(); //checks for notes colliding with the screen boundaries
        notes.get(i).updatePos();
        notes.get(i).draw(); 
      }  
      for(int i = bullets.size() - 1; i >= 0; i--){
        println("There are " +  bullets.size() + " bullets");
        if(bullets.get(i).inBounds()){
          bullets.get(i).draw();
          //check bullet collisions
          checkBulletCollide(i);
        }
        else{
          bullets.remove(i); //remove bullet when out of bounds of screen
        }  
      }
      c.draw();//lets us display the chord on the screen
      fill(0);
      rect(0,385,500,10);
      player.draw();
      break;
      
   case CHOOSECHORDS:
     background(#999999);
     loadButtons();
     break;
  
  }//end switch
}//end draw


void mouseDragged(){
  x = mouseX;
  y = mouseY;
}

void keyPressed(){
  if (key == CODED){
    if (keyCode == RIGHT){
      player.moveRight = true;
    }         
    if (keyCode == LEFT){
      player.moveLeft = true;
    }
  }
  // move right
  if (key == 'd' || key == 'D'){
    player.moveRight = true;
  }
  // move left
  if(key == 'a' || key == 'A'){
    player.moveLeft = true; 
  }
  //Start Game
  if(key == 'z' || key == 'Z'){
    gameState = CHOOSECHORDS;
  }
  // Quit Game
  if(key == 'q' || key == 'Q'){
    gameState = GAMEOVER;
  }
  
}//end key pressed 
   
void keyReleased(){
  if (key == CODED){
    if (keyCode == RIGHT){
      player.moveRight = false;
    } 
    if (keyCode == LEFT){
      player.moveLeft = false;
    }
  }
  if (key == 'd' || key == 'D'){
    player.moveRight = false;
  }
  if(key == 'a' || key == 'A'){
    player.moveLeft = false; 
  }
}//end key released 
  
void mousePressed() {
  if(gameState == CHOOSECHORDS){
    if (b1.rectOver) {
      k = new Key(C, MAJOR);
      changeChord();
      gameState = PLAY;
    }
    else if(b2.rectOver){
      k = new Key(D, MAJOR);
      changeChord(); 
      gameState = PLAY;
   
    }
    else if(b3.rectOver){
      k = new Key(G, MAJOR);
      changeChord();
      gameState = PLAY;
    }
  }
  else if(gameState == PLAY){
    player.shoot();
    shots++;
  }    
}   

void changeChord(){
  chordsMastered ++;
  if(chordsLeft.size() <= 0 ){
    winner = true;
    gameState = GAMEOVER;
  }
  else{
    k.fillNotes();
    Integer r = (int)random(chordsLeft.size());
    c = k.getChord(chordsLeft.get(r));
    println("Changing chord to " + chordsLeft.get(r) + ". Size is " + chordsLeft.size());
    chordsLeft.remove(chordsLeft.get(r));
    println("After removing, size is " + chordsLeft.size());
    correct = 0;
//    incorrect = 0;
  }
}

void checkNoteCollide(){
  //check collision between all notes
  for(int i = 0; i < notes.size(); i++){
    for(int j = i+1; j < notes.size(); j++){
//      if(!(notes.get(i).isEqual(notes.get(j)))){
        notes.get(i).noteCollide(notes.get(j));
//      }
    }
  }
  for(int i = 0; i < notes.size(); i++){
    notes.get(i).switched = false;
  }
}
void checkBulletCollide(int i){
    for(int k = 0; k < notes.size(); k++){
      if(bullets.get(i).bulletCollide(notes.get(k))) {
         //println("BULLET COLLISION");
         if(notes.get(k).note == c.root || notes.get(k).note == c.third || notes.get(k).note == c.fifth){
           correct++; 
           notes.remove(k);
         }
         else{
           incorrect++;
            notes.get(k).relocate();
         }
         bullets.remove(i);
         if(correct == 3){ //if you get three correct, the chord changes
           changeChord();
         }
         if(incorrect == 8){
           gameState = GAMEOVER;
         }
         break;
       }
    }
}
void loadButtons(){
    textAlign(CENTER);
    textSize(18);
    text("Which chords do you want to master now? ", width/2, 50);
    b1 = new Button(10, 100, width-20, 50, "Key of C Major/ A minor: C, d, e, F, G, a, b");
    b1.draw();
    b2 = new Button(10, 170, width-20, 50, "Key of D Major/ B minor: D, e, f#, G, A, b, c#");
    b2.draw();      
    b3 = new Button(10, 240, width-20, 50, "Key of G Major/ e minor: G, a, b, C, D, e, f#");
    b3.draw();
}


/**Returns a new location that is unique 
*/
PVector getNewLoc(ArrayList<Note> arr, int arrSize){
  PVector temp = getRandomLoc();
  //while it's not unique, try a new loc
  while(isLocUsed(temp,arr,arrSize)){
    temp = getRandomLoc();
  }
  //otheriwse return the unique location
  return temp;
}

// Checks to see if a location exists in the given collection
boolean isLocUsed(PVector randLoc, ArrayList<Note> tempArr, int tempSize){
  //check for randLoc
  for(int i = 0; i < tempSize; i++){
    if(dist(tempArr.get(i).pos.x, tempArr.get(i).pos.y, randLoc.x, randLoc.y) < (tempArr.get(i).rad * 2)){
      //retun true if location would collide with a location that is already used
      return true;
    }
  }
  //if location is unique
  return false;
}

PVector getRandomLoc() {
  return( new PVector(
  ((int)random(rad,(max_x+1-rad))/rad)*rad,
  ((int)random(rad,(max_y+1-125))/rad)*rad));
} // end of getRandomLoc()