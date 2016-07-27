import java.awt.Rectangle;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
Floor floor;
Rectangle human = null;
int score=0;

void setup() {
  //size(900, 500, P2D);
  fullScreen(2);
  println(height);
  oscP5 = new OscP5(this, 12000);
  floor = new Floor(0, height, width);
}

void draw() {
  background(255);
  floor.update();
  floor.draw();
  
  if (human!=null){
     // println("drawing: ", human.x, human.y, human.width, human.height);

    stroke(255,0,0);
    strokeWeight(3);
    //rect(0,0,400,400);
    rect(human.x, human.y, human.width, human.height);
    if (floor.checkCollision(human)==true){
      score++;
    }
  }
  
  fill(125);
  textSize(50);
  text(score, 60, 60);
  
}

void oscEvent(OscMessage theOscMessage) {
  int x = theOscMessage.get(0).intValue();  
  int y = theOscMessage.get(1).intValue();
  int w = theOscMessage.get(2).intValue();
  int h = theOscMessage.get(3).intValue();
  human = new Rectangle(width/2, 320, 30, h);
  //println("receiving: ", x, y, w, h);
  /* print the address pattern and the typetag of the received OscMessage */
  //print("### received an osc message.");
  //print(" addrpattern: "+theOscMessage.addrPattern());
  //println(" typetag: "+theOscMessage.typetag());
}