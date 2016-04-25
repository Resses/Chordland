/*
  Chordland main sketch
  Authors: Christopher Menedes, Kwan Holloway, Renee Esses
*/
//import Sound;
//import oscp5;
PFont title;
int x,y, weight;
int gameState;
int correct, incorrect;
String roundStats;
Player player;
Note []chord; 

void setup(){
  size(500,500);
  //load font for score keeping
  //Note chord [] = new Note();
  player = new Player();
  gameState = 0;
  correct = 0;
  incorrect = 0;
  roundStats = "You got " + correct + " correct and " + incorrect + " incorrect.";
  title = createFont("font",75,true);
  chord = new Note[3];
  for(int i = 0; i < chord.length; i++){
    chord[i] = new Note('c', new PVector((int)random(0,width),(int)random(0,height)));
  }
  
}
void draw(){
  switch(gameState) {
    case -1:
      background(#000000);
      fill(240);
      textAlign(CENTER);
      textSize(32);
      text("Game Over", width/2, height/2);
      textSize(24);
      text(roundStats, width/2, height/2 + 50);
      break;
      
    case 0: 
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
      break;
    
    case 1: 
      //gameplay
      background(#ffffff);
      for(int i = 0; i < chord.length; i++){
        chord[i].draw();
      }
      player.draw();
      break;
  }
//  strokeWeight(weight);
//  line(x,y,x,y);
}

//void keyPressed(){
 /* if(key == 'a')
    //move left
  if(key == 'd')
    //move right
  if(key == 'x')
    //close
  if(key == 'spacebar')
    //pause*/
//   switch(key) {
//     case '1':
//       weight = 1;
//     case '2':
//       weight = 5;
//     case '3':
//       weight = 10;
//     case '4':
//       weight = 15;
//     }
//}

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
  if (key == 'd' || key == 'D'){
    player.moveRight = true;
  }
  if(key == 'a' || key == 'A'){
    player.moveLeft = true; 
  }
  if(key == 'z' || key == 'Z'){
    gameState = 1;
  }
  if(key == 'q' || key == 'Q'){
    gameState = -1;
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
   
