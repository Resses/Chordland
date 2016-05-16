/*
*  Chordland Main Sketch
*  Version 1.0
*  Game Design Final Project(SPR 2016)
*
*  Created by Chris Menedes, Renee Esess, and Kwan Holloway
*
*/

PFont title, title1;
int max_x = 500, min_x = 0, max_y= 500, min_y = 0;
Game g;
  
void setup(){ // initialize all objects and variables
  size(500,500); // size of window
  //create game object
  g = new Game();
  //create fonts
  title = createFont("font", 75, true);
  title1 = createFont("ScorchedEarth.otf", 70, true);
  
  minim = new Minim(this);//instantiate song object
  songPlayer = minim.loadFile("song.mp3");//create player
  songPlayer.play();//play song
}

void draw(){
  switch(g.state) {
    case GAMEOVER:
      g.loadGameOverScreen();
      break;
    case STARTSCREEN: 
      g.loadStartScreen();
      break;
    case PLAY: 
      g.play();
      break;
    case CHOOSECHORDS:
      g.chooseChords();
      break;
    case EXPLANATION1:
      g.explain1();
      break;
    case EXPLANATION2:
      g.explain2();
      break;
    case TRANSITION:
      g.transition();
      break;
  }//end switch
}//end draw

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
    g.state = EXPLANATION1;
    g.mode = BEGINNER;
    g.resetVars();
  }
  // Quit Game
  if(key == 'q' || key == 'Q'){
    g.state = GAMEOVER;
  }
  //Use Powerup
  if((key == 'p' || key == 'P') && g.powerupUsed == false) {
    g.setPowerup();
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
  
 if(key == ' '){
    if(g.state == PLAY){
      player.shoot();
      g.shots--;
    }
  }  
}//end key released 
  
void mousePressed() {
  //Pick C Major
  if(g.state == CHOOSECHORDS){
    if (b1.rectOver) {
      g.k = new Key(C, MAJOR);
      g.changeChord();
    }
    // Pick D Major
    else if(b2.rectOver){
      g.k = new Key(D, MAJOR);
      g.changeChord();    
    }
    //Pick G Major
    else if(b3.rectOver){
      g.k = new Key(G, MAJOR);
      g.changeChord();
    }
  }
  // Shoot Bullet
  else if(g.state == PLAY){
    player.shoot();
    g.shots--;
  }   
  // Go to Explanation screen
  else if (g.state == EXPLANATION1){
    if( contButton1.rectOver){
      g.state = EXPLANATION2; 
    }
  }
  // Go to Choose Chords Screen
  else if (g.state == EXPLANATION2){
    if( contButton2.rectOver){
      g.state = CHOOSECHORDS; 
    }
  }
  // Show Game Over Screen
  else if (g.state == GAMEOVER){
    if( playAgainBtn.rectOver){
      g.mode = BEGINNER;
      g.state = CHOOSECHORDS;
      g.resetVars();
    }
    // Show Master Mode
    else if( masterBtn.rectOver){
      g.mode = MASTER;
      g.resetVars();
      g.changeChord();
    }
  }
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
    if(dist(tempArr.get(i).pos.x, tempArr.get(i).pos.y, randLoc.x, randLoc.y) < (noteRadius * 2)){
      //retun true if location would collide with a location that is already used
      return true;
    }
  }
  //if location is unique
  return false;
}

// returns random location on in bounds of screen
PVector getRandomLoc() {
  return( new PVector(
  ((int)random(noteRadius,(max_x+1-noteRadius))/noteRadius)*noteRadius,
  ((int)random(noteRadius,(max_y+1-125))/noteRadius)*noteRadius));
} // end of getRandomLoc()