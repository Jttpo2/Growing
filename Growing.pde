Circle[] circles;

void setup() {
  size(400, 400, P3D);
  background(255);
  
  circles = new Circle[1];
  circles[0] = new Circle(width/2, height/2, 20);
}

void draw() {
  for (Circle c: circles) {
    c.display();
    c.move();
  }
  
  
}