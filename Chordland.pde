/*
  Chordland main sketch
  Authors: Christopher Menedes, Kwan Holloway, Renee Esses
*/
//import Sound;
//import oscp5;
PFont title;
int x,y, weight;
int gameState;
Player player;

void setup(){
  size(700,700);
  //load font for score keeping
  //Note chord [] = new Note();
  player = new Player();
  gameState = 0;
  title = createFont("font",75,true);
}
void draw(){
  switch(gameState) {
    case 0: 
    //title screen info
    textAlign(CENTER);
    textFont(title);
    fill(255);
    text("CHORDLAND",width/2,height/2 - 20);
    textFont(title, 20);
    fill(0);
    text("Use 'A' and 'D' or the left and right arrow keys to move player.", width/2, height/2 + 20);
    text(" Aim guitar with mouse, and click to shoot at notes!", width/2, height/2 +40);
    break;
    case 1: 
    //gameplay
    background(#ffffff);
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
      player.moveRight=true;
    }         
    if (keyCode == LEFT){
      player.moveLeft=true;
    }
  }
  if(key == 'z')
    gameState = 1;
}//end key pressed
   
void keyReleased(){
  if (key == CODED){
    if (keyCode == RIGHT){
      player.moveRight=false;
    } 
    if (keyCode == LEFT){
      player.moveLeft=false;
    }
  }
}//end key released 
   