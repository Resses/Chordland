class Button{
  PVector pos;
  int w, h; //width and height
  String label;
  color rectColor = #dddddd;
  color rectHighlight = #ffffff;
  boolean rectOver = false;

  //default constructor
  Button(){}
   
  // Constructor
  // takes x and y pos, width and height, and a text string
  Button(int x, int y, int w, int h, String txt){
    pos = new PVector(x, y);
    this.w = w;
    this.h = h;
    label = txt;
  }
  
  void draw(color c){//draws button
     update();
     //if the mouse is hovered over the rectangle, change its color
     if (rectOver) {
        fill(rectHighlight);
    } 
    else {
      fill(rectColor);
    }
    //draw button as rectangle with text centered
    rect(pos.x, pos.y, w, h, 7);
    textAlign(CENTER, CENTER);
    fill(c);
    text(label, pos.x, pos.y, w, h);
  }
  
  // updates button state
  //sets value of rectover to true based on value of overRect
  void update() {
   if (overRect((int)pos.x, (int)pos.y, w, h) ) {
      rectOver = true;
    } 
    else {
      rectOver = false;
    }
  }


  // checks if mouse is over button
  boolean overRect(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
  
}