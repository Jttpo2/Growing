import java.util.Iterator;

PShader blur;
float sigma = 0.3;
int blurSize = 2;

float newRootLikelihood = 0.8;
float newThicknessMin = 10;
float newThicknessMax = 30;

boolean makeNewRoots = true;

List<Root> roots;;

void setup() {
  size(400, 400, P2D);
  frameRate(100);
  background(255);
  
  blur = loadShader("blur.glsl");
  blur.set("sigma", sigma);
  blur.set("blurSize", blurSize);
  
  roots = new ArrayList<Root>();
}

void draw() {  
  fill(255, 5);
  rect(0, 0, width, height);
  
  filter(blur);
  
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
  
  //filter(BLUR, 0.6);
  //filter(blur);
   
  // Frame rate in title bar
  surface.setTitle((int) frameRate + " fps");
}

void mousePressed() {
  println("Toggling rootmaker");
  makeNewRoots = !makeNewRoots;
}