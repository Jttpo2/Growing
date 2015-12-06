import java.util.Iterator;
import java.util.List;

class Root {
  float minSpeed = 1;
  float maxSpeed = 4;
  float directionInterval = 50;
  float newRootLikelihood = 0.1;
  float widthDecreaseMultiplierMin = 0.02;
  float widthDecreaseMultiplierMax = 0.05;
  float widthDecreaseMultiplier;
  float widthIncreaseLikelihood = 0.2;
  float minRadius = 3;
  
  float xOffset = 0; // For Perlin noise generation 
 
  List<Circle> circles = new ArrayList<Circle>(); 
  List<Root> roots = new ArrayList<Root>();
  
  int xPos;
  int yPos;
  float radius;
  color startCol = 0;
  color currentCol;
  float opacity;
  float borderThickness;
  
  float direction;
  float speed;
  boolean fertile;
  
  
  Root(int x, int y, float rad, boolean fertile) {
    this(x, y, rad, 2, fertile);
  }
  
  Root(int x, int y, float rad) {    
    this(x, y, rad, false);
    speed = random(minSpeed, maxSpeed);
  }
  
  Root(int x, int y, float rad, float speed, boolean fertile) {
    xPos = x;
    yPos = y;
    radius = rad;
    direction = random(0, 360);
    this.speed = speed;
    this.fertile = fertile;
    currentCol = startCol;
    opacity = 255;
  }
  
  void grow() {
    // Don't grow too small roots
    if (radius < minRadius) {
     return;
    }
    
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
    //direction += random(-directionInterval/2, directionInterval/2);
    xOffset += 0.01;
    direction = 90;// + noise(xPos+ xOffset);
    float deltaX = speed * cos(radians(direction));
    float deltaY = speed * sin(radians(direction));
    xPos += deltaX;
    yPos += deltaY;

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
    
    //if (currentCol > 0) {
    // currentCol -= 5;
    //} else currentCol = 0;
  }
  
  boolean isRemovable() {
    return false;
    //// Removable when invisible 
    //return firstOfRoot.borderCol >= 255;
  }
    
  void display() {
    // Don't grow too small roots
    if (radius < minRadius) {
     return;
    }
    Circle circle = new Circle(xPos, yPos, radius, currentCol);
    circle.display();
  }
}