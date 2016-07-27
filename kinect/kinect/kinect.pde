import netP5.*;
import oscP5.*;

import gab.opencv.*;

import java.awt.Rectangle;

// Daniel Shiffman
// Depth thresholding example

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

// Original example by Elie Zananiri
// http://www.silentlycrashing.net

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

int minDepth =  60;
int maxDepth = 860;
PImage depthImg;
OpenCV opencv;
PImage src, dst;
ArrayList<Contour> contours;


OscP5 oscP5;
NetAddress theo;
NetAddress home;

void setup() {
  size(640, 480);

  kinect = new Kinect(this);
  kinect.initDepth();

  //  // Blank image
  depthImg = new PImage(kinect.width, kinect.height);

  opencv = new OpenCV(this, kinect.width, kinect.height);
  
  oscP5 = new OscP5(this,12001);
  theo = new NetAddress("192.168.1.15", 12000);
  home = new NetAddress("127.0.0.1", 12000);
}

void draw() {
  depthImg = kinect.getDepthImage();
  opencv.loadImage(depthImg);
  int t = 137;//int(map(mouseX, 0, width, 0, 255));
  println(t);
  opencv.threshold(t);
  //opencv.gray();
  PImage threshImg = opencv.getSnapshot();
  contours = opencv.findContours();

  image(threshImg, 0, 0);
  float record = 0;
  Contour winner = null;
  for (Contour contour : contours) {
    if (contour.area() > record) {
      winner = contour;
      record = contour.area();
    }
  }
  if (winner != null) {  
    Rectangle r = winner.getBoundingBox();
    OscMessage msg = new OscMessage("/person");
    msg.add(r.x);
    msg.add(r.y);
    msg.add(r.width);
    msg.add(r.height);
    noFill();
    stroke(255,0,0);
    strokeWeight(3);
    rect(r.x,r.y,r.width,r.height);
    println(r.x, r.y, r.width, r.height);
    oscP5.send(msg, home);
  }
}