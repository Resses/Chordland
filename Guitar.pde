/*
*  Guitar Class Sketch
*  Version 1.0
*  Game Design Final Project(SPR 2016)
*
*  Created by Chris Menedes, Renee Esess, and Kwan Holloway
*
*/

class Guitar{
  PImage guitarImg;
  PVector startPos;
  PVector direction;
  int sizeWid = 45;
  int sizeHgt = 100; 
  float angle;
  
  // Constructor
  Guitar(PVector start){
    startPos = start;
    direction = new PVector(0,0);
    guitarImg = loadImage("guitar2.png");
  }
   
   // set starting position of guitar, which is middle of player 
  void setStart(){ 
    startPos.x = player.getCenterX();
    startPos.y = player.getCenterY();
  }
  
  // set direction of guitar based on mouse position
  void setDirection(){ 
    direction.x = mouseX;
    direction.y = mouseY;
    direction.sub(startPos);
    direction.normalize();//normalized vector from start position to mouse position
    angle = PVector.angleBetween(new PVector(0,-1), direction);//angle between the normalized vector and the vertical vector
    if(direction.x < 0){
      angle*=-1;
    }
  }
  
  // gets end X pos
  float getEndX(){
    return startPos.x + ((sizeWid/2.) * direction.x);
  }
  
  // gets end y Pos
  float getEndY(){
    return startPos.y + (sizeHgt/2. * direction.y);
  }
  
  // Draws guitar based on angle of mouse
  void draw(){
    setStart();
    setDirection();
    strokeWeight(2);
    translate(startPos.x, startPos.y);
    rotate(angle);
    imageMode(CENTER);
    image(guitarImg, 0,0, 33,69);
  }
}