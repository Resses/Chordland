/*
  Chordland main sketch
  Authors: Christopher Menedes, Kwan Holloway, Renee Esses
*/


/*  MAX STUFF FOR SOUND 

// load the P5 libraries:
import oscP5.*;
import netP5.*;

// create the objects we need for oscp5:
OscP5 oscP5;
NetAddress myRemoteLocation;

// we want to send
      the type of powerup(reverb, delay, modulation)
      pitch
*/
PFont title;
int x,y, weight;
int gameState;
int correct, incorrect;
String roundStats;

//game states
final  int GAMEOVER = -1;
final int STARTSCREEN = 0;
final int PLAY = 1;
final int CHOOSECHORDS = 2;

Player player;
ArrayList<Bullet> bullets;
Key k;
Note []chord; 
Button b1, b2, b3;
Chord c;
void setup(){
  size(500,500);
  //load font for score keeping
  //Note chord [] = new Note();
  player = new Player();
  gameState = STARTSCREEN;
  correct = 0;
  incorrect = 0;
  roundStats = "You got " + correct + " correct and " + incorrect + " incorrect.";
  title = createFont("font",75,true);
  bullets = new ArrayList <Bullet> ();
  //c = new Chord();//global chord variable, default constructor
  c = new Chord("C","E","G",MAJOR);
}
void draw(){
  switch(gameState) {
    case GAMEOVER:
      background(#000000);
      fill(240);
      textAlign(CENTER);
      textSize(32);
      text("Game Over", width/2, height/2);
      textSize(24);
      text(roundStats, width/2, height/2 + 50);
      break;
      
    case STARTSCREEN: 
    //title screen info
      textAlign(CENTER);
      textFont(title);
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
      background(#ffffff);
      
      for(int i = 0; i < chord.length; i++){
        chord[i].draw();
        //chord[i].updatePos();
        chord[i].collide();
      }

      c.draw();//lets us display the chord on the screen
      player.draw();
      checkNoteCollide(chord);
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
  // shoot bullet
  /*if(key == ' ' || key == ' '){
    Bullet temp;
    bullets.add(new Bullet());
    temp = bullets.get(0);
    temp.shoot();
  } */
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
       c = k.getChord((int)random(1,8));
      //c.printChord();
      //c.draw();
      chord = new Note[3];
      chord[0] = new Note(c.root);
      chord[1] = new Note(c.third);
      chord[2] = new Note(c.fifth);
      gameState = PLAY;
    }
    else if(b2.rectOver){
      k = new Key(D, MAJOR); 
      c = k.getChord((int)random(1,8));
      //c.printChord();
      //c.draw();
      chord = new Note[3];
      chord[0] = new Note(c.root);
      chord[1] = new Note(c.third);
      chord[2] = new Note(c.fifth);
      gameState = PLAY;
   
    }
    else if(b3.rectOver){
      k = new Key(G, MAJOR);
      c = k.getChord((int)random(1,8));
     // c.printChord();
       //c.draw();
      chord = new Note[3];
      chord[0] = new Note(c.root);
      chord[1] = new Note(c.third);
      chord[2] = new Note(c.fifth);
      gameState = PLAY;
    }
  }
  if(gameState == PLAY){
    //shoot = true;
    Bullet temp;
    bullets.add(new Bullet());
    temp = bullets.get(0);
    temp.shoot();
    temp.update();
  }
    
}   

void checkNoteCollide(Note [] chrd){
  
  //check collision between all notes
  for(int i = 0; i < chrd.length; i++){
    for(int j = 0; j < chrd.length; j++){
      if(!(chrd[i].isEqual(chrd[j]))){
        chrd[i].noteCollide(chrd[j]);
      }
    }
  }
}

void loadButtons(){
      textAlign(CENTER);
      text("Which chords do you want to master now? ", width/2, 50);
      b1 = new Button(10, 100, width-20, 50, "Key of C Major/ A minor: C, d, e, F, G, a, b");
      b1.draw();
      b2 = new Button(10, 170, width-20, 50, "Key of D Major/ B minor: D, e, f#, G, A, b, c#");
      b2.draw();      
      b3 = new Button(10, 240, width-20, 50, "Key of G Major/ e minor: G, a, b, C, D, e, f#");
      b3.draw();
}
