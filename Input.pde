// Used with the "OSC via UDP" app

import netP5.*;
import oscP5.*;

class Input {
  int x;
  int y;
  
  String type;
  final String mouse = "mouse";
  final String phone = "phone";
  boolean flatMode = true; // If true flat is normal state, if false up is normal state. Mobile will be held as a joystick instead of in the palm

  OscP5 osc;
  int oscPort = 10000;


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
    println(x + " " + y + " " + z );
    
    if (flatMode) {
      this.x = (int) map(x, -1, 1, 0, width);
      this.y = (int) map(y, 1, -1, 0, height);
    } else {
      this.x = (int) map(z, 1, -1, 0, width);
      this.y = (int) map(x, -1, 1, 0, height);
    }
  }
  
  
  
  void oscEvent(OscMessage m) {
    //println(m);
  }
  
  void initPhoneConnection() {
    osc = new OscP5(this, oscPort);
    osc.plug(this, "shake", "/xyz"); // "/xyz" is the label of the accelerometer event from app
  }

}