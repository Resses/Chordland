/*
  Chordland main sketch
  Authors: Christopher Menedes, Kwan Halloway, Renee Esses
*/
//import Sound;
//import oscp5;
int x,y, weight;
Player player;

void setup(){
  size(700,700);
  //load font for score keeping
  //Note chord [] = new Note();
  player = new Player();
}
void draw(){
  background(#ffffff);
  player.draw();
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
   
