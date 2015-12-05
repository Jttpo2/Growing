import java.util.Iterator;
import java.util.List;

class Root {
  float directionInterval = 50;
  float newRootLikelihood = 0.1;
  float widthDecreaseMultiplierMin = 0.02;
  float widthDecreaseMultiplierMax = 0.05;
  float widthDecreaseMultiplier;
  float widthIncreaseLikelihood = 0.2;
  float fadeSpeed = 2;
 
  List<Circle> circles = new ArrayList<Circle>(); 
  List<Root> roots = new ArrayList<Root>();
  
  int xPos;
  int yPos;
  float radius;
  color col;
  float opacity;
  
  float direction;
  float speed;
  boolean fertile;
  
  
  Root(int x, int y, float rad, boolean fertile) {
    this(x, y, rad, 2, fertile);
  }
  
  Root(int x, int y, float rad) {    
    this(x, y, rad, 2, false);
  }
  
  Root(int x, int y, float rad, float speed, boolean fertile) {
    xPos = x;
    yPos = y;
    radius = rad;
    direction = random(0, 360);
    this.speed = speed;
    this.fertile = fertile;
    //sizeDecreaseMultiplier = random(0.02, 0.1);
    col = 0; 
    opacity = 255;
  }
  
  void grow() {
    // Spawning of child roots
    if (fertile) {
      float newRootDice = random(0, 1);
      if (newRootDice < newRootLikelihood) {
       roots.add(new Root(xPos, yPos, radius, false));  
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
    
    // Calculate new position
    direction += random(-directionInterval/2, directionInterval/2);  
    float deltaX = speed * cos(radians(direction));
    float deltaY = speed * sin(radians(direction));
    xPos += deltaX;
    yPos += deltaY;

    // Color change
    col += fadeSpeed;

    // Width
    widthDecreaseMultiplier = random(widthDecreaseMultiplierMin, widthDecreaseMultiplierMax);
    // sometimes the roots grow a tiny bit in girth
    float increaseGirthDice = random(0, 1);
    if (increaseGirthDice < widthIncreaseLikelihood) {
      widthDecreaseMultiplier = -widthDecreaseMultiplier;
    }
    if (radius > 0) {
     radius = radius - (radius * widthDecreaseMultiplier);
    }
    // Don't draw too small roots
    if (radius < 3) {
      radius = 0;
    }
    
    circles.add(new Circle(xPos, yPos, radius, col));
  }
  
  void display() {
    for (Circle c: circles) {
      c.display();
    }
  }
}