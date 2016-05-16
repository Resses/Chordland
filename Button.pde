class Button{
  PVector pos;
  int w, h; //width and height
  String label;
  color rectColor = #dddddd;
  color rectHighlight = #ffffff;
  boolean rectOver = false;

  // Constructor
  // takes x and y pos, width and height, and a text string
  Button(int x, int y, int w, int h, String txt){
    pos = new PVector(x, y); 
//    pos.x = x;
//    pos.y = y;
    this.w = w;
    this.h = h;
    label = txt;
  }
  
  
   void draw(){ // draws button
     update(mouseX, mouseY);
     if (rectOver) {
        fill(rectHighlight);
    } 
    else {
      fill(rectColor);
    }
    rect(pos.x, pos.y, w, h);
    textAlign(CENTER, CENTER);
    fill(#0000ff);
    text(label, pos.x, pos.y, w, h);
  }
  // updates button state
  void update(int x, int y) { 
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