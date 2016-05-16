//game states
final  int GAMEOVER = -1;
final int STARTSCREEN = 0;
final int PLAY = 1;
final int CHOOSECHORDS = 2;
final int TRANSITION = 3;
final int EXPLANATION1 = 4;
final int EXPLANATION2 = 5;

//game modes
final int BEGINNER = 1;
final int MASTER = 2;

final int DELAY = 0;
final int REVERB = 1;

//The following variables are global and not members of the game for convenience
Player player; // player object
ArrayList<Bullet> bullets;  //arraylist of active bullets 
ArrayList<Note> notes; //arraylist of the notes on the screen

Button b1, b2, b3, b4; // buttons for the possible chords to learn
Button contButton1, contButton2; // button for continue in explanation screen
Button playAgainBtn, masterBtn; //buttons to play again 

class Game{
  int state; //playing, choosing chords...
  int mode; //beginner or master
  
  int wait = 10; //powerup time length 10 seconds
  
  int timeA; //time the powerup starts
  boolean delayFlag, reverbFlag = false; //the powerup assigned at the beginning of the game will be true
  boolean powerupFlag = false; // if the power up is active
  boolean powerupUsed = false; // if the power up was already used for this round
  ArrayList<Integer>chordsLeft; // used to assure each chord is given only once
  int chordsMastered; // number of chords mastered
  Key k; //the key that the player chooses to learn 
  Chord c;   //The current chord to be played
  
  int timer = 0; //for transition screen
  int correct, incorrect; //number of correct and incorrect notes
  int shots; // number of bullets left
  boolean winner;

  //constructor: game starts with start screen in beginner mode. All variables are initialized
  Game(){
    state = STARTSCREEN; 
    mode = BEGINNER;
    player = new Player();
    bullets = new ArrayList <Bullet> ();
    notes = new ArrayList <Note> ();
    //chordsleft start with numbers 1-7 which are all the possible roots that a chord can start with because there are 7 notes in the scale
    //To get a random chord, the root is chosen from a member of chordsLeft, and then that member is deleted from the list
    chordsLeft = new ArrayList<Integer>();
    for(int i = 1; i < 8; i++){
      chordsLeft.add(i);
    }
    chordsMastered = -1; //this will become 0 when first chord is assigned, and incremented after each chord is mastered
    c = new Chord("C","E","G",MAJOR);
    correct = 0;
    incorrect = 0;
    shots = 25;
    winner = false;
    loadPowerUp(); //assigns random powerup for the game 
    //create buttons with default constructor to avoid null pointers
    b1 = new Button(); b2 = new Button(); b3 = new Button(); b4 = new Button(); contButton1 = new Button(); contButton2 = new Button(); // button for continue in explanation screen
    playAgainBtn = new Button(); 
    masterBtn = new Button(); 
  }
  
  void loadStartScreen(){
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
  }
  
  void loadGameOverScreen(){
      background(0);
      fill(240);
      textAlign(CENTER);
      textSize(32);
      if(winner){
        if(g.mode == BEGINNER){
          text("MASTER!" , width/2, height/2);
        }
        else if (g.mode == MASTER){
          text("ROCK ON!" , width/2, height/2 - 20);
          textSize(16);
          text("You've mastered master mode!" , width/2, height/2 + 20);
        }
        loadWinnerButtons();
      }
      else{
        text("Game Over", width/2, height/2);
        textSize(16);
        playAgainBtn = new Button(width/2 - 75, height-150 , 150, 50, "Play again");
        playAgainBtn.draw();
      }
      fill(240);
      textSize(16);
      text("You've mastered " + chordsMastered + " chords and got " + incorrect + " incorrect." , width/2, height/2 + 50);
  }
  
  void chooseChords(){
    background(#999999);
    loadChordButtons();
  }
  
  void explain1(){
    background(#7597AD);
    textAlign(CENTER);
    textSize(15);
    fill(0);
    text("Welcome to Chordland!",width/2, 160);
    text("Chordland will teach you the basics about chords in music.",width/2, 180);
    text("Chords are groups of 3 or more musical notes that are in harmony.",width/2, 200);
    contButton1 = new Button(200, 220, 100, 50, "Continue...");
    contButton1.draw();
  }
  
  void explain2(){
    background(#7597AD);
    textAlign(CENTER);
    textSize(15);
    fill(0);
    text("Your goal is to shoot the correct notes!",width/2, 140);
    text("Correct notes are displayed in the upper left of the screen.",width/2, 160);
    text("Hitting correct notes will play the chord!",width/2, 180);
    text("To begin, click the continue button below! Good Luck!",width/2, 200);
    contButton2 = new Button(200, 220, 100, 50, "Continue...");
    contButton2.draw();
  }
  
  //this is for the transition between chords
  void transition(){
    background(#ffffff);
    fill(c.COLOR);
    textAlign(CENTER, CENTER);
    text(c.getChordString(),width/2,height/2);
    timer ++;
    if (timer == 90) c.playChord();
    if (timer == 180) state = PLAY;
  }
  
  //when gamestate is play
  void play(){
      if(powerupFlag) g.checkPowerupTimer(); //check to see if the powerup time is over
      printStats();       //draw game stats
      printPowerup();  //draw power up status
      if(shots <= 0 && bullets.size() == 0) g.state = GAMEOVER; // if the player runs out of shots and all their bullets have exited the screen, game over
      drawNotes();
      drawBullets();
      drawDivider();
      player.draw();
  }
  
  //prints on top left the number of notes hit correct, incorrect, num chords mastered and how many bullets are left
  void printStats(){
      background(#cce6ff);
      c.draw();//display the chord on the screen
      textSize(14);
      fill(c.COLOR);
      text("Correct: " + correct, 10, 40);
      text("Incorrect: " + incorrect, 10, 60);
      text("Chords Mastered: " + chordsMastered, 10, 80);
      text("Bullets Left: " + shots, 10, 100);
  }
 
  void printPowerup(){
     if(!powerupUsed){
       fill(#000000);
       if(reverbFlag) text("Press p to activate reverb and speed up bullets", 3*width/5, 10, 200, 100);
       if(delayFlag) text("Press p to activate delay and slow down notes", 3*width/5, 10, 200, 100);
     }
     if(powerupFlag){
       fill(#000000);
       if(reverbFlag) text("REVERB TIME: " + (wait - ((millis() - timeA) / 1000)), 3.5*width/5, 10, 200, 100);
       if(delayFlag) text("DELAY TIME: " + (wait - ((millis() - timeA) / 1000)), 3.5*width/5, 10, 200, 100);
     
     }
  }
  
  void drawNotes(){
    checkNoteCollide(); //checks for notes colliding with each other
    for(int i = 0; i < notes.size(); i++){
        notes.get(i).collide(); //checks for notes colliding with the screen boundaries
        notes.get(i).updatePos();
        notes.get(i).draw(); 
      }  
  }
  
  void drawBullets(){
    for(int i = bullets.size() - 1; i >= 0; i--){
        //println("There are " +  bullets.size() + " bullets");
        if(bullets.get(i).inBounds()){
          bullets.get(i).draw();
          //check bullet collisions
          checkBulletCollide(i);
        }
        else{
          bullets.remove(i); //remove bullet when out of bounds of screen
        }  
      }
  }
  
  void drawDivider(){
     fill(0);
     rect(0, 385, 500, 10);
  }
  void loadWinnerButtons(){
    fill(#000000);
    textSize(18);
    textAlign(CENTER, CENTER);
    if(mode == BEGINNER){
      playAgainBtn = new Button(width/6, height-150 , 150, 100, "Play again");
      masterBtn = new Button(width/6 + 160, height-150, 150, 100, "MASTER MODE");
    }
    else if(mode == MASTER){
      playAgainBtn = new Button(width/6, height-150 , 150, 100, "Start over and choose new chords");
      masterBtn = new Button(width/6 + 160, height-150, 150, 100, "Play MASTER MODE again");
    }
    playAgainBtn.draw();
    masterBtn.draw();
  }

  //Loads buttons for chord set choices.
  //more can be added for any key stored
  void loadChordButtons(){
    textAlign(CENTER);
    textSize(18);
    text("Which chords do you want to master now? ", width/2, 50);
    b1 = new Button(10, 100, width-20, 50, "Key of C Major/ A minor: C, d, e, F, G, a, b");
    b1.draw();
    b2 = new Button(10, 170, width-20, 50, "Key of D Major/ B minor: D, e, f#, G, A, b, c#");
    b2.draw();      
    b3 = new Button(10, 240, width-20, 50, "Key of G Major/ e minor: G, a, b, C, D, e, f#");
    b3.draw();
    b4 = new Button(10, 310, width-20, 50, "Key of A Major/ f# minor: A, b, c#, D, E, f#, g#");
    b4.draw();
  }
  
  void changeChord(){
    powerupUsed = false;
    if(powerupFlag) undoPowerup();
    chordsMastered ++;
    shots = 25;
    noteSpeed += 0.2; 
    if(chordsLeft.size() <= 0 ){
      winner = true;
      state = GAMEOVER;
    }
    else{
      Integer r = (int)random(chordsLeft.size());
      c = k.getChord(chordsLeft.get(r));
      k.fillNotes(chordsLeft.get(r));
      c.COLOR = chordColors[chordsLeft.get(r) - 1];
      chordsLeft.remove(chordsLeft.get(r));
      correct = 0;
      timer = 0;
      state = TRANSITION;
    }
  }
  
  void checkNoteCollide(){
    //check collision between all notes
    for(int i = 0; i < notes.size(); i++){
      for(int j = i+1; j < notes.size(); j++){
          notes.get(i).noteCollide(notes.get(j));
      }
    }
    for(int i = 0; i < notes.size(); i++){
      notes.get(i).switched = false;
    }
  }
  
  void checkBulletCollide(int i){
    for(int k = 0; k < notes.size(); k++){
      if(bullets.get(i).bulletCollide(notes.get(k))) {
         if(notes.get(k).note == c.root || notes.get(k).note == c.third || notes.get(k).note == c.fifth){
           correct++; 
           notes.get(k).playNote();
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
         break;
       }
    }
  }
  void resetVars(){
    //delete all bullets
    bullets.clear();
    //zero out all scores
    shots = 25;
    incorrect = 0;
    correct = 0;
    chordsLeft.clear();
    for(int i = 1; i < 8; i++){
      chordsLeft.add(i);
    }
    chordsMastered = -1;
    winner = false;
    noteSpeed = 2;
  }
  void loadPowerUp(){
   int powerup = (int)random(0,2);
   switch(powerup){
     case DELAY:
      println("DELAY LOADED");   
      delayFlag = true;
      break;
    case REVERB:
      println("REVERB LOADED");   
      reverbFlag = true;
      break;
   }
  }
  
 boolean timeUp(){
    return ((millis() - timeA)/(1000)) > wait;
  }
  
 void setPowerup(){
    g.powerupUsed = true;
    g.powerupFlag = true;
    g.timeA = millis();
   if(reverbFlag){
     println("reverb activated");
     speed*=2;//increase bullet speed
   }
   if(delayFlag) {
     println("delay activated");
     noteSpeed--;
   }
 }
 void undoPowerup(){
     if(reverbFlag) {
       speed/=2;
     }
     if(delayFlag) {
       noteSpeed++;
     }
     powerupFlag = false;
 }
 
 void checkPowerupTimer(){
   if(timeUp()){
     println("time up");
     undoPowerup();
   }
  }
}