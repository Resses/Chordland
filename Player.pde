/**
  * Player.pde    
  * Christopher Menedes, Kwan Halloway, Renee Esses
  * Game Design
  * Professor Kletenik
  */
//import Sound;
//import oscp5;


class Player {
    PVector pos;
    int size = 50;
    int velx = 5;
    boolean moveLeft = false;
    boolean moveRight = false;

    //constructor set player position to bottom center
    Player(){
      pos = new PVector(width/2 - size, height - size); 
    }
    
    //draws the player and updates its position based on value of moveLeft and moveRight
    void draw() {
      fill(#ff0000);
      rect( pos.x, pos.y, size, size );
      if(moveLeft && pos.x-velx > 0){
        pos.x -= velx;
      }
      else if(moveRight && pos.x + size +velx < width){
        pos.x += velx;      
      }

    } // end of draw()
    
 
}
