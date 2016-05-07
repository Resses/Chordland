class Guitar{

  PVector startPos;
  PVector direction;
  int size = 85;
  
  Guitar(PVector start){
    startPos = start;
    direction = new PVector(0,0);
  }
    
  void setStart(){
    startPos.x = player.getCenterX();
    startPos.y = player.getBottomY();
  }
  
  void setDirection(){
    direction.x = mouseX;
    direction.y = mouseY;
    direction.sub(startPos);
    direction.normalize();
  }

  float getEndX(){
    return startPos.x + (size * direction.x);
  }
  float getEndY(){
    return startPos.y + (size * direction.y);
  }
  
  void draw(){
    setStart();
    setDirection();
    strokeWeight(2);
    println(startPos + " to " + getEndX() + ", " + getEndY() );
//    println( startPos.x + ", " + startPos.y + " to "  + getEndX() ", " + getEndY());
    line( startPos.x, startPos.y, getEndX(), getEndY());
  }
}
