/**
  * Note.pde    
  * Christopher Menedes, Kwan Holloway, Renee Esses
  * Game Design
  * Professor Kletenik
  */
//import Sound;
//import oscp5;

class Note {
    
  PVector pos;
  PVector vel; //speed 
  //int d = 100;
  String note;
  float pitch;
  int max_x = 500, min_x = 0, max_y= 500, min_y = 0;
  int rad = 18; // radius
  int xdirection = 1;  // Left or Right
  int ydirection = 1;  // Top to Bottom
  int xspeed = 3;
  int yspeed = 3;
  
  //constructor
  Note(){
    this.note = "placeholder";
    this.pos = new PVector(30,30);
    this.vel = new PVector(xspeed,yspeed);
  }
  //constructor
  Note(String note){
    this.note = note;
    this.pos = getRandomLoc();
    this.vel = new PVector(xspeed,yspeed);
  }
  //constructor
  Note(String note, PVector posi){
    this.note = note;
    this.pos = posi;
    this.vel = new PVector(xspeed,yspeed);
  }
    
    
  void updatePos(){
  // Update the position of the shape
  pos.x = pos.x + ( vel.x  );
  pos.y = pos.y + ( vel.y );
  
  }
  
  void collide(){
   // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
    if (pos.x > width-rad || pos.x < rad) {
      //xdirection *= -1;
      vel.x = -vel.x;
    }
    // 
    if (pos.y > height-130 || pos.y < rad) {
      //ydirection *= -1;
      vel.y = -vel.y;
    }

   }
  
  void noteCollide(Note scnd){
    //Tests to see if the notes collide
    if(dist(pos.x,pos.y,scnd.pos.x,scnd.pos.y) < (rad*2)){
      println("collided");
      vel.x = -vel.x;
      vel.y = -vel.y;
      scnd.vel.x = -scnd.vel.x;
      scnd.vel.y = -scnd.vel.y;
     /* xdirection *= -1;
      ydirection *= -1;
      scnd.xdirection *= -1;
      scnd.ydirection *= -1; */
    }
  }
  
  boolean isEqual(Note scnd){
    //return if they have the same position or not
    return (pos.x == scnd.pos.x && pos.y == scnd.pos.y) ? true : false;
  }
  
 /* PVector getPos();//returns position of note
  PVector getDiameter();//returns diameter of note
  char getNote();
  float getPitch();
  void playSound();
  void slowDown();
  void doublePoints();
  */
  void draw(){
    noFill();
    ellipseMode(RADIUS);
    //updatePos();
    ellipse(pos.x, pos.y, rad, rad);
    textAlign(CENTER,CENTER);
    textSize(24);
    text(note, pos.x, pos.y);
  }

///**Returns a new location that is unique 
//*/
//PVector getNewLoc(PVector [] arr, int arrSize){
//  PVector temp = getRandomLoc();
//  //while it's not unique, try a new loc
//  while(isLocUsed(temp,arr,arrSize)){
//    temp = getRandomLoc();
//  }
//  //otheriwse return the unique location
//  return temp;
//}

//// Checks to see if a location exists in the given collection
//boolean isLocUsed(PVector randLoc, PVector [] tempArr, int tempSize){
//  //check for randLoc
//  for(int i = 0; i < tempSize; i++){
//    if(tempArr[i] == randLoc){
//      //retun true if location is used
//      return true;
//    }
//  }
//  //if location is unique
//  return false;
//}

//PVector getRandomLoc() {
//  return( new PVector(
//  ((int)random(rad,(max_x+1-rad))/rad)*rad,
//  ((int)random(rad,(max_y+1-125))/rad)*rad));
//} // end of getRandomLoc()


}
