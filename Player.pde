/*
*  Player Class Sketch
*  Version 1.0
*  Game Design Final Project(SPR 2016)
*
*  Created by Chris Menedes, Renee Esess, and Kwan Holloway
*
*/

class Player {
    PImage playerImg;  
    PVector pos; 
    Guitar guitar;
    int sizeWid = 45;
    int sizeHgt = 95;
    int speed = 5;
    int vel = 5;
    boolean moveLeft = false;
    boolean moveRight = false;
    
    //constructor set player position to bottom center of screen, 
    // creates a guitar at the bottom center of itself
    Player(){
      pos = new PVector(width/2 - sizeWid, height -sizeHgt); 
      guitar = new Guitar(new PVector(getCenterX(), getCenterY()));  
      playerImg = loadImage("KazukiChordland.png");
    }
    
    //Sets Velocity based on conditional statements
    void setVelocity(){
      if(moveLeft && !moveRight){
        vel = -speed;
      }
      else if(moveRight && !moveLeft){
        vel = speed;      
      }
      else{
        vel = 0;
      }
    }
    
    //updates the position of the player
    void updatePos(){ 
      //move by velocity
      pos.x += vel;
      //clamp to screen boundary
      pos.x = max(pos.x, 0);
      pos.x = min(pos.x, width - sizeWid);
    }
    
    //gets center x value of player
    float getCenterX(){ 
      //println(pos.x + "is posx");
      return pos.x + sizeWid/2;
    }
    
    //gets center y value of player
    float getCenterY(){ 
      return pos.y + sizeHgt/2;
    }

    //shoots a bullet in the direction of the guitar
    void shoot(){ 
      bullets.add(new Bullet(guitar.getEndX(), guitar.getEndY(), guitar.direction.x, guitar.direction.y));
    }
    
    //draws the player and updates its position based on value of moveLeft and moveRight
    void draw() {
      setVelocity();
      updatePos();
      imageMode(CORNER);
      image(playerImg,pos.x,pos.y,sizeWid, sizeHgt);
      guitar.draw();
    } // end of draw()
    
}