class RootMaker {
  List<Root> roots;
  
  RootMaker() {
    roots = new ArrayList<Root>();
  }
  
  void update() {
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
  }
  
  void makeRoots() {
    float newRootDie = random(0, 1);
    if (newRootDie > newRootLikelihood) {
      float thicknessDie = random(newThicknessMin, newThicknessMax);
      roots.add(new Root(input.x, input.y, thicknessDie));  
    }
  }
  
  void start() {
  }
  
  void stop() {
  }
  
}