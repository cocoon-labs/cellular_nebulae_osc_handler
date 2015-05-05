import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup()
{
  //size(800, 800);
    
  // start oscP5, telling it to listen for incoming messages at port 5001 */
  oscP5 = new OscP5(this,5001);
 
  // set the remote location to be the localhost on port 5001
  myRemoteLocation = new NetAddress("192.168.1.5",5001);
  
  // REMEMBER TO FLASH OSC DEVICE WITH INITIAL VARIABLE VALUES DURING SETUP
}
 
void draw()
{
 
}


void oscEvent(OscMessage theOscMessage) 
{ 
//  print("Unexpected OSC Message Recieved: ");
//  println("address pattern: " + theOscMessage.addrPattern());
//  println("type tag: " + theOscMessage.typetag()); 
  
  String addPatt = theOscMessage.addrPattern();
  
  if (addPatt.length() < 3) {
    println("Page change");
  } else if (addPatt.substring(1,4).equals("xy0")) {
    float y = theOscMessage.get(0).floatValue();
    float x = theOscMessage.get(1).floatValue();
    println("x0 = " + x);
    println("y0 = " + y);
  } else if (addPatt.substring(1,4).equals("xy1")) {
    float y = theOscMessage.get(0).floatValue();
    float x = theOscMessage.get(1).floatValue();
    println("x1 = " + x);
    println("y1 = " + y);
  } else if (addPatt.substring(1,5).equals("mode")) {
    if (theOscMessage.get(0).floatValue() == 1.0) {
      int newMode = 4 * (3 - Integer.parseInt(addPatt.substring(6,7))) + (Integer.parseInt(addPatt.substring(8,9)) - 1);
      println("New mode = " + newMode);
    }
  } else if (addPatt.substring(1,7).equals("faders")) {
    int faderNum = Integer.parseInt(addPatt.substring(8,9));
    float faderVal = theOscMessage.get(0).floatValue();
    switch(faderNum) {
      case 1:
        int brightness = (int) map(faderVal, 0.0, 1.0, 0.0, 255.0);
        println("Brightness = " + brightness);
        break;
      case 2:
        int delay = (int) map(faderVal, 0.0, 1.0, 0.0, 500.0);
        println("Delay = " + delay + " ms");
        break;
      default:
        println("Fader " + faderNum + " = " + faderVal);
        break;
    }
  } else if (addPatt.substring(1,6).equals("vibes")) {
    if (theOscMessage.get(0).floatValue() == 1.0) {
      int vibe = 3 * (3 - Integer.parseInt(addPatt.substring(7,8))) + (Integer.parseInt(addPatt.substring(9,10)) - 1);
      print("Color Vibe = ");
      switch(vibe) {
        case(0) :
          println("DEFAULT");
          break;
        case(1) :
          println("WARM");
          break;
        case(2) :
          println("COOL");
          break;
        case(3) :
          println("RAINBOW");
          break;
        case(8) :
          println("WHITE");
          break;
        default:
          println(vibe);
          break;
      }
    }
  } else if(addPatt.substring(1,8).equals("toggles")) {
    int toggleNum = 5 * (5 - Integer.parseInt(addPatt.substring(9,10))) + (Integer.parseInt(addPatt.substring(11,12)) - 1);
    print("Toggle " + toggleNum + " is ");
    if (theOscMessage.get(0).floatValue() == 1.0) {
      println("ON");
    } else {
      println("OFF");
    }
  } else if (addPatt.substring(1,11).equals("multipush1")) {
    if (theOscMessage.get(0).floatValue() == 1.0) {
      int buttonNum = 3 * (2 - Integer.parseInt(addPatt.substring(12,13))) + (Integer.parseInt(addPatt.substring(14,15)) - 1);
      switch (buttonNum) {
        case(3) :
          println("Stage lights ON");
          break;
        case(0) :
          println("Choose new scheme");
          break;
        default :
          println("Button " + buttonNum + " pressed");
          break;
      }
    }
  } else {
    print("Unexpected OSC Message Recieved: ");
    println("address pattern: " + theOscMessage.addrPattern());
    println("type tag: " + theOscMessage.typetag());
  }
  
  // print out the message
  //print("OSC Message Recieved: ");
  //println("address pattern: " + theOscMessage.addrPattern());
  //println("type tag: " + theOscMessage.typetag());
  //println(theValue);
  // println(theValue2);
  // println(firstValue + " " + secondValue + " " + thirdValue);
}
