

class Root {
  float directionInterval = 50;

  List<Circle> circles = new ArrayList<Circle>
  
  int xPos;
  int yPos;
  float radius;
  float direction;
  float speed;
  
  Circle(int x, int y, int rad) {    
    this(x, y, rad, 2);
  }
  
  Circle(int x, int y, int rad, float speed) {
    xPos = x;
    yPos = y;
    radius = rad;
    direction = random(0, 360);
    this.speed = speed;
  }
  
  void grow() {
    direction += random(-directionInterval/2, directionInterval/2);  
    
    float deltaX = speed * cos(radians(direction));
    float deltaY = speed * sin(radians(direction));
    
    xPos += deltaX;
    yPos += deltaY;
    
    //xPos += random(randomMin, randomMax);
    //yPos += random(randomMin, randomMax);

    if (radius > 0) {
     radius = radius - (radius * 0.01);
    } 
    if (radius < 3) {
      radius = 0;
    }
  }
  
  void display() {
    stroke(150);
    fill(255);
    ellipse(xPos, yPos, radius, radius);
  }
}