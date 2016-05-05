/**
  * Player.pde    
  * Christopher Menedes, Kwan Holloway, Renee Esses
  * Game Design
  * Professor Kletenik
  */
//import Sound;
//import oscp5;

class Player {
    PVector pos, posA, bulletDir;
    PVector guitar;
    int size = 50;
    int speed = 5;
    int vel = 5;
    boolean moveLeft = false;
    boolean moveRight = false;
    //constructor set player position to bottom center
    Player(){
      pos = new PVector(width/2 - size, height - size); 
      guitar = new PVector(0,0);
      bulletDir = new PVector(0,0);
      posA = new PVector(pos.x+25, pos.y+50);
      
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
      
      guitar.x = mouseX;
      guitar.y = mouseY;
      //find line from mouse to guitar and make guitar follow mouse
      guitar.sub(posA);
      guitar.normalize();
      bulletDir.x = guitar.x;
      bulletDir.y = guitar.y;
//      println(bulletDir);
      guitar.mult(85);
     
     translate( pos.x+25, pos.y+50 );
     strokeWeight(2);
     line( 0, 0, guitar.x, guitar.y );


    } // end of draw()
    
    void shoot(){
      bullets.add(new Bullet(bulletDir.x, bulletDir.y));
    }
 
}
