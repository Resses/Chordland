/**
  * Player.pde    
  * Christopher Menedes, Kwan Holloway, Renee Esses
  * Game Design
  * Professor Kletenik
  */
//import Sound;
//import oscp5;

class Player {
    PVector pos; // position of player
    Guitar guitar;
    int size = 50;
    int speed = 5;
    int vel = 5;
    boolean moveLeft = false;
    boolean moveRight = false;
    
    //constructor set player position to bottom center of screen, and creates a guitar at the bottom center of itself
    Player(){
      pos = new PVector(width/2 - size, height - size); 
      guitar = new Guitar(new PVector(getCenterX(), getBottomY()));      
    }
    
    void setVelocity(){
      //set velocity
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
    
    void updatePos(){
      //move by velocity
      pos.x += vel;
      //clamp to screen boundary
      pos.x = max(pos.x, 0);
      pos.x = min(pos.x, width - size);
    }
    
    float getCenterX(){
      println(pos.x + "is posx");
      return pos.x + size/2;
    }
    
    float getBottomY(){
      return pos.y + size;
    }

    void shoot(){
      bullets.add(new Bullet(guitar.getEndX(), guitar.getEndY(), guitar.direction.x, guitar.direction.y));
    }
    
    //draws the player and updates its position based on value of moveLeft and moveRight
    void draw() {
      setVelocity();
      updatePos();
      //draw
      fill(#ff0000);
      rect( pos.x, pos.y, size, size );
      guitar.draw();
    } // end of draw()
    
}
