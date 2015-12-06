import java.util.Iterator;

//float newRootLikelihood = 0.87;
float newRootLikelihood = 0.8;
float newThicknessMin = 10;
float newThicknessMax = 30;

boolean makeNewRoots = true;

List<Root> roots;;


void setup() {
  size(400, 400, P3D);
  background(255);
  
  roots = new ArrayList<Root>();
  //roots.add(new Root(width/2, height/2, 20, true));
}

void draw() {
  background(255);
  if (makeNewRoots) {
    float newRootDie = random(0, 1);
    if (newRootDie > newRootLikelihood) {
      float thicknessDie = random(newThicknessMin, newThicknessMax);
      roots.add(new Root(mouseX, mouseY, thicknessDie));  
    }
  }
  
  for (Iterator<Root> iterator = roots.iterator(); iterator.hasNext();) {
    Root root = iterator.next();
    
    root.grow();
    root.display();
    if (root.isRemovable()) {
      iterator.remove();
    }
  }
}

void mousePressed() {
  println("Toggling rootmaker");
  makeNewRoots = !makeNewRoots;
}