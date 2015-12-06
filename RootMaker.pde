class RootMaker {
  List<Root> roots;
  Input input;
  
  final static float minSpeed = 1;
  final static float maxSpeed = 4;
  final static float smallSpeedMin = minSpeed * 0.3;
  final static float smallSpeedMax = maxSpeed * 0.3;
  float smallThicknessMin = newThicknessMin * 0.3;
  float smallThicknessMax = newThicknessMax * 0.3;
  final static float newSmallRootLikelihood = 0.5;
  
  boolean makeNew;
  
  RootMaker(String inputType) {
    this(inputType, null);
  }
  
  RootMaker(String inputType, TuioCursor tuioCursor) {
    roots = new ArrayList<Root>();
    input = new Input(inputType, tuioCursor);
    makeNew = makeNewRoots; // Gotten from main file = Hack
  }
  
  void update() {
    input.update();
    
    
    if (input.type.equals(Input.tuio)) {
      if (makeNew) {
        makeRoots();
      }
    // In continuous mode we make roots all the time if toggle is on
    // Otherwise we just grow them while pressing a mouse button
    } else if (continuous) {
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
  }
  
  void makeRoots() {
    // Add lots of small ones for filling 
    
    float newSmallRootDie = random(0, 1);
    
    float smallSpeed = random(smallSpeedMin, smallSpeedMax);
    float smallThicknessDie = random(smallThicknessMin, smallThicknessMax);
    if (newSmallRootDie > newSmallRootLikelihood) { 
      roots.add(new Root(input.x, input.y, smallThicknessDie, smallSpeed, 240));
    }
    
    float newRootDie = random(0, 1);
    if (newRootDie > newRootLikelihood) {
      float thicknessDie = random(newThicknessMin, newThicknessMax);
      roots.add(new Root(input.x, input.y, thicknessDie));  
    }
    
    
  }
  
  void start() {
  }
  
  void stop() {
    makeNew = false;
  }
  
  // Checks if RootMaker is active
  boolean isFullyGrown() {
    for (Root r: roots) {
      // See if any individual root is still growing
      if (!r.isFullyGrown()) {
        return false;
      }
    }
    return true;
  }
  
  
  
}