import java.util.Iterator;
import java.util.concurrent.ConcurrentHashMap;

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

//List<RootMaker> rootMakers;
ConcurrentHashMap <RootMaker, RootMaker> rootMakers;

static final String defaultInputType = Input.mouse;

void setup() {
  size(600, 600, P3D);
  frameRate(150);
  background(255);
  
  blur = loadShader("blur.glsl");
  blur.set("sigma", sigma);
  blur.set("blurSize", blurSize);
  
  //rootMakers = new ArrayList<RootMaker>();
  //rootMakers.add(new RootMaker(defaultInputType));
  
  rootMakers = new ConcurrentHashMap<RootMaker, RootMaker>();
  RootMaker newRM = new RootMaker(defaultInputType);
  rootMakers.put(newRM, newRM);
}

void draw() {
  
  if (millis() - lastFade > fadeInterval) {
    fill(255, 2);
    rect(0, 0, width, height);
    filter(blur);
  }
  
  //for (RootMaker rm: rootMakers) {
  //  rm.update();
  //}
  
  Iterator<RootMaker> iterator = rootMakers.keySet().iterator();
  while (iterator.hasNext()) {
    iterator.next().update();
  }
  
  //filter(BLUR, 0.6);
  //filter(blur);
   
  // Frame rate in title bar
  surface.setTitle((int) frameRate + " fps");
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