

class Bullet{
  // PVector used for the location of the bullet
  PVector loc, vel;
  //for rotation based on mouse and speed
  float rotation;
  
  Bullet() {
    //places the bullet in the middle of the room
    loc= new PVector(player.pos.x+25, player.pos.y+50);
    
    //this checks the angle
    rotation = atan2(mouseY - loc.y, mouseX - loc.x);
    //bullet speed
    vel = new PVector(3,3);
  }
  
  void update() { loc.add(vel); }
  void shoot(){
    ellipse(loc.x,loc.y, 20, 20);
  }
  
  
}