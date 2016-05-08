class Guitar{
  PImage guitarImg;
  PVector startPos;
  PVector direction;
  int sizeWid = 45; //for GuitarChordland image, use 80
  int sizeHgt = 100; //'' '' use 100
  float angle;
  
  Guitar(PVector start){
    startPos = start;
    direction = new PVector(0,0);
    guitarImg = loadImage("guitar2.png");
  }
    
  void setStart(){
    startPos.x = player.getCenterX();
    startPos.y = player.getCenterY();
  }
  
  void setDirection(){
    direction.x = mouseX;
    direction.y = mouseY;
    direction.sub(startPos);
    direction.normalize();
    angle = PVector.angleBetween(new PVector(0,-1), direction);
    if(direction.x < 0){
      angle*=-1;
    }

  }

  float getEndX(){
    return startPos.x + ((sizeWid/2.) * direction.x);
  }
  float getEndY(){
    return startPos.y + (sizeHgt/2. * direction.y);
  }
  
  
  
  void draw(){
    setStart();
    setDirection();
    strokeWeight(2);
    println(startPos + " to " + getEndX() + ", " + getEndY() );
//    println( startPos.x + ", " + startPos.y + " to "  + getEndX() ", " + getEndY());
//    line( startPos.x, startPos.y, getEndX(), getEndY());
    translate(startPos.x, startPos.y);
    rotate(angle);
    println("rotating " + degrees(angle));
    imageMode(CENTER);
    image(guitarImg, 0,0, 33,69);
    
  }
}