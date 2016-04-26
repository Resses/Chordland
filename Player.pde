/**
  * Player.pde    
  * Christopher Menedes, Kwan Holloway, Renee Esses
  * Game Design
  * Professor Kletenik
  */
//import Sound;
//import oscp5;

float angle = 0.0f;


class Player {
    PVector pos;
    int size = 50;
    int speed = 5;
    int vel = 5;
    boolean moveLeft = false;
    boolean moveRight = false;

    //constructor set player position to bottom center
    Player(){
      pos = new PVector(width/2 - size, height - size); 
    }
    
    //draws the player and updates its position based on value of moveLeft and moveRight
    void draw() {
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
      //move by velocity
      pos.x += vel;
      //clamp to screen boundary
      pos.x = max(pos.x, 0);
      pos.x = min(pos.x, width - size);
      
      //draw
      fill(#ff0000);
      rect( pos.x, pos.y, size, size );
      
      //find angle from mouse to bottom middle of screen
     angle = atan2( mouseY  - pos.y, mouseX - pos.x );
     
     translate( pos.x+25, pos.y+50 );
     rotate( angle );
     strokeWeight(2);
     line( 0, 0, 90, 0 );

    } // end of draw()
    
 
}
