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
  float fadeSpeed = 2;
  float minRadius = 3;
  //float minBorderThickness = 0.9;
  //float maxBorderThickness = 2.0;
 
  List<Circle> circles = new ArrayList<Circle>(); 
  List<Root> roots = new ArrayList<Root>();
  
  int xPos;
  int yPos;
  float radius;
  color startCol = 230;
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
    //sizeDecreaseMultiplier = random(0.02, 0.1);
    currentCol = startCol;
    opacity = 255;
    //borderThickness = random(minBorderThickness, maxBorderThickness);
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
    direction += random(-directionInterval/2, directionInterval/2);  
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
    
    if (currentCol > 0) {
      currentCol -= 5;
    } else currentCol = 0;
    
    // Append next circle to end of root
    //circles.add(new Circle(xPos, yPos, radius, currentCol));
    
    Circle circle = new Circle(xPos, yPos, radius, currentCol);
    circle.display();
  }
  
  boolean isRemovable() {
    if (circles.isEmpty()) {
      return true;
    }
    Circle firstOfRoot = circles.get(circles.size()-1); 
    // Removable when invisible 
    return firstOfRoot.borderCol >= 255;
  }
    
  void display() {
 
    for (Iterator<Circle> iterator = circles.iterator(); iterator.hasNext();) {
      Circle circle = iterator.next();
      
      circle.display();
      if (circle.borderCol <= 0) {
        iterator.remove();
      }
    }
  }
}