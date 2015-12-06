// Used with the "OSC via UDP" or "SenseOSC" apps

import netP5.*;
import oscP5.*;

class Input {
  int x;
  int y;
  int prevX = 0;
  int prevY = 0;
  float distanceFromLast;
  String type;
  
  final static String mouse = "mouse";
  final static String accelerometer = "accelerometer";
  final static String tuio = "TUIO";
  
  boolean flatMode = true; // If true flat is normal state, if false up is normal state. Mobile will be held as a joystick instead of in the palm

  OscP5 osc;
  int oscPort = 5000;
  String accelerometerLabel = "/1/xyz"; // "SenSeOSC" app
  //String accelerometerLabel = "/xyz"; // "OSC via UDP" app
  
  TuioCursor tuioCursor;

  Input(String type) {
    this(type, null);
  }
  
  Input(String type, TuioCursor tuioCursor) {
    this.type = type;
    
    if (type.equals(accelerometer)) {
      initPhoneConnection();
    } else if (type.equals(tuio)) {
      this.tuioCursor = tuioCursor;
    }
  }

  void update() {
   //println(x + " " + y + " " + prevX + " " + prevY + " " + distanceFromLast);
    prevX = x;
    prevY = y;
    
    if (type.equals(mouse)) {
      x = mouseX;
      y = mouseY;
    } else if (type.equals(accelerometer)) {
      
    } else if (type.equals(tuio)) {
      x = (int) map(tuioCursor.getX(), 0, 1, 0, width);
      y = (int) map(tuioCursor.getY(), 0, 1, 0, height);
    }
    //println(x + " " + y + " " + prevX + " " + prevY + " " + distanceFromLast);
    distanceFromLast = twoPointDistance(x, y, prevX, prevY);
    
    
    
  }
  
  // Do something with received accelerometer values
  void shake(float x, float y, float z) {
    //println(x + " " + y + " " + z );
    
    float max = 0.7; // so you don't have to tilt the phone all the way
    if (flatMode) {
      this.x = (int) map(x, -max, max, 0, width);
      this.y = (int) map(y, max, -max, 0, height);
    } else {
      this.x = (int) map(z, max, -max, 0, width);
      this.y = (int) map(x, -max, max, 0, height);
    }
  }
  
  void oscEvent(OscMessage m) {
    println(m);
  }
  
  void initPhoneConnection() {
    osc = new OscP5(this, oscPort);
    osc.plug(this, "shake", accelerometerLabel); 
  }

  // Calculate distance between 2 points using the Pythagorean theorem
  float twoPointDistance(float currentX, float currentY, float prevX, float prevY) {
    return sqrt(pow(currentX - prevX, 2) + pow(currentY - prevY, 2));
  }

}