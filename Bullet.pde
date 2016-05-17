/*
*  Bullet Class Sketch
*  Version 1.0
*  Game Design Final Project(SPR 2016)
*
*  Created by Chris Menedes, Renee Esess, and Kwan Holloway
*
*/

//bullet speed is global for convenience to be accessed 
int speed = 5;

class Bullet{
  // PVector used for the location of the bullet, and its velocity
  PVector pos, vel;
  int radius = 10;
  
  //Bullet Constructor
  Bullet(float posX, float posY, float dirX, float dirY) {
    pos = new PVector(posX, posY);
    vel = new PVector(dirX * speed, dirY * speed);
  }
  
  void draw() { 
    //update position based on velocity and draw the bullet
    pos.x += vel.x;
    pos.y += vel.y;
    fill(#ff0000);
    ellipse(pos.x, pos.y, radius,radius);
  }
  
  //Returns whether or not a bullet and note collide
  boolean bulletCollide(Note note){
    if(dist(pos.x,pos.y,note.pos.x,note.pos.y) < (radius+ noteRadius)){
      return true;
    }
    return false;
  }

  //returns whether or not the bullet is still within the bounds of the screen
  boolean inBounds(){
    if(pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height){
      return false;
    }
    return true;
  }
  
}