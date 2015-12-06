class Circle {
  float fadingSpeed = 1;
  
  int xPos;
  int yPos;
  float radius;
  color borderCol;
  color fillCol;
  float opacity;
  float borderThickness;
  
  Circle(int x, int y, float rad, color c) {
    xPos = x;
    yPos = y;
    radius = rad;
    borderCol = c;
    //borderCol = (int) (radius*5 ); // Depending on radius
    fillCol = 255;   
  }
  
  void display() {
    
    // fade the border
    if (borderCol < 255) {
      borderCol += fadingSpeed;
    }
    stroke(borderCol);
    borderThickness = 0.8 + radius * 0.03;
    strokeWeight(borderThickness);
    fill(fillCol);
    
    ellipse(xPos, yPos, radius, radius);
  }
}