/*
*  Game Class Sketch
*  Version 1.0
*  Game Design Final Project(SPR 2016)
*
*  Created by Chris Menedes, Renee Esess, and Kwan Holloway
*
*/

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

//powerup states
final int DELAY = 0;
final int PANNING = 1;

//The following variables are global and not members of the game for convenience
Player player; // player object
ArrayList<Bullet> bullets;  //arraylist of active bullets 
ArrayList<Note> notes; //arraylist of the notes on the screen

Button start;
Button b1, b2, b3, b4; // buttons for the possible chords to learn
Button contButton1, contButton2; // button for continue in explanation screen
Button playAgainBtn, masterBtn; //buttons to play again 

class Game{
  int state; //playing, choosing chords...
  int mode; //beginner or master
  
  int wait = 10; //powerup time length 10 seconds
  
  int timeA; //time the powerup starts
  boolean delayFlag, panningFlag = false; //the powerup assigned at the beginning of the game will be true
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
    start = new Button(); b1 = new Button(); b2 = new Button(); b3 = new Button(); b4 = new Button(); contButton1 = new Button(); contButton2 = new Button(); // button for continue in explanation screen
    playAgainBtn = new Button(); 
    masterBtn = new Button(); 
  }
  
  void loadStartScreen(){
      background(100);
      textAlign(CENTER);
      textFont(title1);
      fill(30);
      text("CHORDLAND",width/2,height/2 - 20);
      textFont(title, 16);
      fill(200);
      
      text("Chordland will teach you the basics about chords in music.",width/2, height/2 + 20);
      text("Chords are groups of 3 or more musical notes that are in harmony.",width/2, height/2 + 40);
      
      start = new Button(width/2 - 75, height-150 , 150, 50, "START");
      start.draw(#000000);
      //text(" Press 'Z' to begin!", width/2, height/2 +80);
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
        playAgainBtn.draw(#000000);
      }
      fill(240);
      textSize(16);
      text("You've mastered " + chordsMastered + " chords and got " + incorrect + " incorrect." , width/2, height/2 + 50);
  }
  
  void chooseChords(){
    background(#999999);
    loadChordButtons();
  }
  //Instructions for second screen
  void explain2(){
    background(#7597AD);
    textAlign(CENTER);
    textSize(15);
    fill(0);
    text("Use 'A' and 'D' or the left and right arrow keys to move player.", width/2, 120);
    text(" Aim guitar with mouse, and click/use SPACE to shoot at notes!", width/2, 140);
    text(" Use 'Q' to quit the game.", width/2, 160);
    text("Use 'P' to utilize a given power-up once per round.",width/2, 180);
    text("To begin, click the continue button below! Good Luck!",width/2, 200);
    contButton2 = new Button(200, 220, 100, 50, "Continue...");
    contButton2.draw(#0000ff);
  }
  //Instructions for first screen
  void explain1(){
    background(#7597AD);
    textAlign(CENTER);
    textSize(15);
    fill(0);
    text("Your goal is to shoot the notes displayed", width/2, 140);
    text("in the upper left corner of the screen.",width/2, 160);
    text("Hitting a correct note will play its sound.",width/2, 180);  
    contButton1 = new Button(200, 220, 100, 50, "Continue...");
    contButton1.draw(#0000ff);
  }
  
  //this is for the transition between chords
  void transition(){
    background(#ffffff);
    fill(c.COLOR);
    textAlign(CENTER, CENTER);
    textSize(20);
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
       if(panningFlag) text("Press p to activate panning and speed up bullets", 3*width/5, 10, 200, 100);
       if(delayFlag) text("Press p to activate delay and slow down notes", 3*width/5, 10, 200, 100);
     }
     if(powerupFlag){
       fill(#000000);
       if(panningFlag) text("PANNING TIME: " + (wait - ((millis() - timeA) / 1000)), 3.5*width/5, 10, 200, 100);
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
    playAgainBtn.draw(#0000ff);
    masterBtn.draw(#0000ff);
  }

  //Loads buttons for chord set choices.
  //more can be added for any key stored
  void loadChordButtons(){
    textAlign(CENTER);
    textSize(18);
    text("Which chords do you want to master now? ", width/2, 50);
    b1 = new Button(10, 100, width-20, 50, "Key of C Major/ A minor: C, d, e, F, G, a, b");
    b1.draw(#0000ff);
    b2 = new Button(10, 170, width-20, 50, "Key of D Major/ B minor: D, e, f#, G, A, b, c#");
    b2.draw(#0000ff);      
    b3 = new Button(10, 240, width-20, 50, "Key of G Major/ e minor: G, a, b, C, D, e, f#");
    b3.draw(#0000ff);
    b4 = new Button(10, 310, width-20, 50, "Key of A Major/ f# minor: A, b, c#, D, E, f#, g#");
    b4.draw(#0000ff);
  }
  
  //changes chord after player finishes round
  void changeChord(){
    //reset variables
    powerupUsed = false;
    if(powerupFlag) undoPowerup();
    chordsMastered ++;
    shots = 25;
    noteSpeed += 0.2;//increases note speed as game progresses 
    if(chordsLeft.size() <= 0 ){
      winner = true;
      state = GAMEOVER;
    }
    else{
      Integer r = (int)random(chordsLeft.size());//random index into chordsLeft array
      c = k.getChord(chordsLeft.get(r));//value of element in array represents chord in scale
      k.fillNotes(chordsLeft.get(r));//creates note for each note in key
      c.COLOR = chordColors[chordsLeft.get(r) - 1];//each chord has associated color
      chordsLeft.remove(chordsLeft.get(r));//removes chord
      //reset variables and transition to next state
      correct = 0;
      timer = 0;
      state = TRANSITION;
    }
  }
  
  //check collision between all notes
  void checkNoteCollide(){
    for(int i = 0; i < notes.size(); i++){
      for(int j = i+1; j < notes.size(); j++){
          notes.get(i).noteCollide(notes.get(j));
      }
    }
    for(int i = 0; i < notes.size(); i++){
      notes.get(i).switched = false;
    }
  }
  
  //checks collision between bullets and notes
  void checkBulletCollide(int i){
    for(int k = 0; k < notes.size(); k++){
      if(bullets.get(i).bulletCollide(notes.get(k))) {
        //if note is in chord, increment correct, play note, and remove note from screen
         if(notes.get(k).note == c.root || notes.get(k).note == c.third || notes.get(k).note == c.fifth){
           correct++; 
           notes.get(k).playNote();
           notes.remove(k);
         }
         //if note is not in chord, increment incorrect, and relocate note on screen
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
  
  //resets all variables when new game is started
  void resetVars(){  
    bullets.clear();//delete all bullets
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
  
  //randomly loads a delay or panning powerup
  void loadPowerUp(){
   int powerup = (int)random(0,2);
   switch(powerup){
     case DELAY:
      println("DELAY LOADED");   
      delayFlag = true;
      break;
    case PANNING:
      println("PANNING LOADED");   
      panningFlag = true;
      break;
   }
  }
  
  //checks if power-up time is finished
 boolean timeUp(){
    return ((millis() - timeA)/(1000)) > wait;
  }
  
  //activates powerups
 void setPowerup(){
    g.powerupUsed = true;
    g.powerupFlag = true;
    g.timeA = millis();//sets start time to current time on computer clock
   if(panningFlag){
     println("Panning activated");
     speed*=2;//increase bullet speed
   }
   if(delayFlag) {
     println("Delay activated");
     noteSpeed--;//slow notes down
   }
 }
 
 //deactivates powerups
 void undoPowerup(){
     if(panningFlag) {
       speed/=2;//return to normal bullet speed
     }
     if(delayFlag) {
       noteSpeed++;//return to normal note speed
     }
     powerupFlag = false;
 }
 
 //if time is up, powerup is deactivated
 void checkPowerupTimer(){
   if(timeUp()){
     println("time up");
     undoPowerup();
   }
  }
}