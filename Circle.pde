class Circle {
  float fadingSpeed = 1;
  
  int xPos;
  int yPos;
  float radius;
  color borderCol;
  color fillCol;
  float opacity;
  float borderThickness;
  
  Circle(int x, int y, float rad, color c, color fillColor) {
    xPos = x;
    yPos = y;
    radius = rad;
    borderCol = c;
    //borderCol = (int) (radius*5 ); // Depending on radius
    fillCol = fillColor;
  }
  
  Circle(int x, int y, float rad, color c) {
     this(x, y, rad, c, 255);
  }
  
  void display() {
    stroke(borderCol);
    borderThickness = 0.8 + radius * 0.01;
    strokeWeight(borderThickness);
    fill(fillCol);
    
    ellipse(xPos, yPos, radius, radius);
    //filter(BLUR, map(borderCol, 0, 255, 0, 0.2));
  }
}