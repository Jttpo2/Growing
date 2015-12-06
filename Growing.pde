import java.util.Iterator;
import java.util.concurrent.ConcurrentHashMap;

PShader blur;
float sigma = 0.31;
int blurSize = 2;

long fadeInterval = 100;
long lastFade = 0;

boolean continuous = false; // Continuous mode produces roots all the time
boolean makeNewRoots = true; // Or at least until toggled

ConcurrentHashMap <RootMaker, RootMaker> rootMakers;
ConcurrentHashMap <RootMaker, RootMaker> removalQueue;

static final String defaultInputType = Input.mouse;

void setup() {
  size(600, 600, P3D);
  frameRate(150);
  background(255);
  
  blur = loadShader("blur.glsl");
  blur.set("sigma", sigma);
  blur.set("blurSize", blurSize);
  
  rootMakers = new ConcurrentHashMap<RootMaker, RootMaker>();
  RootMaker newRM = new RootMaker(defaultInputType);
  rootMakers.put(newRM, newRM);
  
  removalQueue = new ConcurrentHashMap<RootMaker, RootMaker>();
}

void draw() {
  
  if (millis() - lastFade > fadeInterval) {
    fill(255, 2);
    rect(0, 0, width, height);
    filter(blur);
  }
  
  Iterator<RootMaker> iterator = rootMakers.keySet().iterator();
  while (iterator.hasNext()) {
    iterator.next().update();
  }
  
  //filter(BLUR, 0.6);
  //filter(blur);
   
  // Frame rate in title bar
  surface.setTitle((int) frameRate + " fps");
  
  // Remove rootmakers only after they've stopped growing
  Iterator<RootMaker> removalIterator = removalQueue.keySet().iterator();
  while (removalIterator.hasNext()) {
    RootMaker rm = removalIterator.next();
    if (rm.isFullyGrown()) {
        rootMakers.remove(rm);
      }
  }
}

void remove(RootMaker rm) {
  rm.stop();
  removalQueue.put(rm, rm);
}

void mousePressed() {
    if (mouseButton == LEFT) {
      if (continuous) {
        // Toggle rootmaking on/off
        println("Toggling Rootmaking");
        makeNewRoots = !makeNewRoots;
      } else {
        //println("left");
      }
          
    } else if (mouseButton == RIGHT) {
      // Toggle Continuous Mode
      continuous = !continuous;
      println("Toggling Continuous Mode");
    }
  }