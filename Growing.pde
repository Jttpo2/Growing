import java.util.Iterator;

Input input;
final String inputType = "mouse";
//final String inputType = "phone";

PShader blur;
float sigma = 0.31;
int blurSize = 2;

long fadeInterval = 100;
long lastFade = 0;

float newRootLikelihood = 0.8;
float newThicknessMin = 10;
float newThicknessMax = 30;

boolean continuous = true; // Continuous mode produces roots all the time
boolean makeNewRoots = true; // Or at least until toggled

List<Root> roots;;

void setup() {
  size(600, 600, P3D);
  frameRate(200);
  background(255);
  
  input = new Input(inputType);
  
  blur = loadShader("blur.glsl");
  blur.set("sigma", sigma);
  blur.set("blurSize", blurSize);
  
  roots = new ArrayList<Root>();
}

void draw() {
  input.update();
  
  if (millis() - lastFade > fadeInterval) {
    fill(255, 2);
    rect(0, 0, width, height);
    filter(blur);
  }
  
  // In continuous mode we make roots all the time if toggle is on
  // Otherwise we just grow them while pressing a mouse button
  if (continuous) {
    if (makeNewRoots) {
      makeRoots();
    }
  } else {
    if (mousePressed) {
      makeRoots();
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

void makeRoots() {
  float newRootDie = random(0, 1);
  if (newRootDie > newRootLikelihood) {
    float thicknessDie = random(newThicknessMin, newThicknessMax);
    roots.add(new Root(input.x, input.y, thicknessDie));  
  }
}


void mousePressed() {
  if (mouseButton == LEFT) {
    if (continuous) {
      // Toggle rootmaking on/off
      println("Toggling rootmaker");
      makeNewRoots = !makeNewRoots;
    }
  } else if (mouseButton == RIGHT) {
    // Toggle Continuous Mode
    continuous = !continuous;
  }
}