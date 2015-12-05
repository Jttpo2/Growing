Root[] roots;

void setup() {
  size(400, 400, P3D);
  background(255);
  
  roots = new Root[1];
  roots[0] = new Root(width/2, height/2, 20);
}

void draw() {
  for (Root r: roots) {
    r.display();
    r.grow();
  }
  
  
}