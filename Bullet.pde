class Bullet{
  // PVector used for the location of the bullet
  PVector pos, vel;
  int radius = 10;

  
  Bullet(float dirX, float dirY) {
//    println("Creating bullet");
    //places the bullet in the middle of the room
    pos = new PVector(player.pos.x+25, player.pos.y+50);
    
    //this checks the angle
//    rotation = atan2(mouseY - loc.y, mouseX - loc.x);
    //bullet speed
    vel = new PVector();
    vel.x = dirX * 5;
    vel.y = dirY * 5;
    println(vel);
  }
  
  void draw() { 
    println(vel.x + " " + vel.y);
    pos.x += vel.x;
    pos.y += vel.y;
    inBounds();
    //loc.add(vel); 
    fill(#ff0000);
    ellipse(pos.x, pos.y, radius,radius);
    
    
  }
  
  //Returns whether or not a bullet and note collide
  boolean bulletCollide(Note note){
    if(dist(pos.x,pos.y,note.pos.x,note.pos.y) < (radius+note.rad)){
      return true;
    }
    return false;
  }
  
  void inBounds(){
    if(pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height){
      bullets.remove(this);
    }
  }
//  void shoot(){
//    ellipse(loc.x,loc.y, 20, 20);
//  }
  
  
}