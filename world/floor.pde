class Floor {
  ArrayList <Rectangle> shapes = new ArrayList<Rectangle>();
  // shapes.append(r);
  PShape path;  // The PShape object
  float locX;
  float locY;
  float w;

  Floor(float _x, float _y, float _w) {
    locX = _x;
    locY = _y;
    w = _w;
  }

  void update() {
    for (int i=0; i<shapes.size(); i++) {
      shapes.get(i).x++;
    }
    generateRects();
  }

  void draw() {
    translate(locX, locY);
    for (int i=0; i<shapes.size(); i++) {
      Rectangle r = shapes.get(i);
      rect(r.x, r.y, r.width, r.height);
    }
  }

  void generateRects() {
    if (random(1)>0.988 && (shapes.size()==0 || prevRectFarEnough())) { 
      int recW = int(random(-50, -30));
      int recH = int(random(-50, -30));
      Rectangle r = new Rectangle(0, 0, recW, recH);
      shapes.add(r);
    }
  }
  boolean prevRectFarEnough(){
    if (shapes.get(shapes.size()-1).x + shapes.get(shapes.size()-1).width > 70) return true;
    else return false;
  }   

  boolean checkCollision(Rectangle human){
    for (Rectangle shape : shapes) {
      if (shape.intersects(human)) return true;    
    }
    return false;
  }
}