import java.util.Iterator;
import java.util.List;

class Root {
  float directionInterval = 50;
  float newRootLikelihood = 0.98;

  List<Root> roots = new ArrayList<Root>();
  
  int xPos;
  int yPos;
  float radius;
  float direction;
  float speed;
  boolean fertile;
  
  Root(int x, int y, float rad, boolean fertile) {
    this(x, y, rad, 2, fertile);
  }
  
  Root(int x, int y, float rad) {    
    this(x, y, rad, 2, true);
  }
  
  Root(int x, int y, float rad, float speed, boolean fertile) {
    xPos = x;
    yPos = y;
    radius = rad;
    direction = random(0, 360);
    this.speed = speed;
    this.fertile = fertile;
  }
  
  void grow() {
    if (fertile) {
      float newRootDice = random(0, 1);
      if (newRootDice > newRootLikelihood) {
       roots.add(new Root(xPos, yPos, radius, true));  
      }
      
      for (Iterator<Root> iterator = roots.iterator(); iterator.hasNext();) {
        Root root = iterator.next();
        root.grow();
        root.display();
        if (root.radius <= 0) {
          iterator.remove();
        }
      }
    }
    
    direction += random(-directionInterval/2, directionInterval/2);  
    float deltaX = speed * cos(radians(direction));
    float deltaY = speed * sin(radians(direction));
    xPos += deltaX;
    yPos += deltaY;

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