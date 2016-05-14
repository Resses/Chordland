  int speed = 5;

class Bullet{
  // PVector used for the location of the bullet
  PVector pos, vel;
  int radius = 10;
  
  Bullet(float posX, float posY, float dirX, float dirY) {
    // println("Creating bullet");
    pos = new PVector(posX, posY);
    vel = new PVector(dirX * speed, dirY * speed);
    //println(vel);
  }
  
  void draw() { 
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

  boolean inBounds(){
    if(pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height){
      return false;
    }
    return true;
  }
  
}