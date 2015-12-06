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

boolean makeNewRoots = true;

List<Root> roots;;

void setup() {
  size(400, 400, P2D);
  frameRate(100);
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
  
  
  if (makeNewRoots) {
    float newRootDie = random(0, 1);
    if (newRootDie > newRootLikelihood) {
      float thicknessDie = random(newThicknessMin, newThicknessMax);
      roots.add(new Root(input.x, input.y, thicknessDie));  
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