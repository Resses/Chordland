class Button{
  PVector pos;
  int w, h; //width and height
  String label;
  color rectColor = #dddddd;
  color rectHighlight = #ffffff;
  boolean rectOver = false;

  
  Button(int x, int y, int w, int h, String txt){
    pos = new PVector(x, y); 
//    pos.x = x;
//    pos.y = y;
    this.w = w;
    this.h = h;
    label = txt;
  }
  
  
   void draw(){
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
    text(label, pos.x, pos.y, w, 50);
  }
  
  void update(int x, int y) {
   if (overRect((int)pos.x, (int)pos.y, w, h) ) {
      rectOver = true;
    } 
    else {
      rectOver = false;
    }
  }


  
  boolean overRect(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
  
}
