// Used with the "OSC via UDP" or "SenseOSC" apps

import netP5.*;
import oscP5.*;

class Input {
  int x;
  int y;
  
  String type;
  final static String mouse = "mouse";
  final static String phone = "phone";
  boolean flatMode = true; // If true flat is normal state, if false up is normal state. Mobile will be held as a joystick instead of in the palm

  OscP5 osc;
  int oscPort = 5000;

  String accelerometerLabel = "/1/xyz"; // "SenSeOSC" app
  //String accelerometerLabel = "/xyz"; // "OSC via UDP" app

  Input(String type) {
    this.type = type;
    
    if (type.equals(phone)) {
      initPhoneConnection();
    }
    
  }

  void update() {
    if (type.equals(mouse)) {
      x = mouseX;
      y = mouseY;
    } else if (type.equals(phone)) {
      
    }
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
    //println(m);
  }
  
  void initPhoneConnection() {
    osc = new OscP5(this, oscPort);
    osc.plug(this, "shake", accelerometerLabel); 
  }

}