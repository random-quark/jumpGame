import java.awt.Rectangle;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
Floor floor;
Rectangle human = null;

void setup() {
  size(900, 500, P2D);
  oscP5 = new OscP5(this, 12000);
  floor = new Floor(0, height, width);
}

void draw() {
  background(255);
  floor.update();
  floor.draw();
  
  if (human!=null){
    rect(width - 200, human.y, human.width, human.height);
    if (floor.checkCollision(human)==true){
      println("***** GAME OVER *****");
      noLoop();
    }
  }
  
}

void oscEvent(OscMessage theOscMessage) {
  int x = theOscMessage.get(0).intValue();  
  int y = theOscMessage.get(1).intValue();
  int w = theOscMessage.get(2).intValue();
  int h = theOscMessage.get(3).intValue();
  human.x = x;
  human.y = y;
  human.width = w;
  human.height = h;
  //println(x, y, w, h);
  /* print the address pattern and the typetag of the received OscMessage */
  //print("### received an osc message.");
  //print(" addrpattern: "+theOscMessage.addrPattern());
  //println(" typetag: "+theOscMessage.typetag());
}