long prev;

float g;

Polygon[] polygons;
SoftBody softBody;

void setup() {
  size(850, 800);

  g = 200;

  polygons = new Polygon[3];
  polygons[0] = new Polygon(new PVector[] {new PVector(50, 200), new PVector(400, 250), new PVector(400, 350), new PVector(50, 300)});
  polygons[1] = new Polygon(new PVector[] {new PVector(450, 500), new PVector(700, 200), new PVector(800, 300), new PVector(550, 600)});
  polygons[2] = new Polygon(new PVector[] {new PVector(50, 650), new PVector(425, 750), new PVector(800, 650), new PVector(800, 900), new PVector(50, 900)});
  softBody = new SoftBody(100, 100, 10, 5, 25, 1500, 2, 5, color(255));
}

void draw() {
  float dt = (-prev + (prev = frameRateLastNanos))/1e9;

  // stops wierd shit happening at the beginning to do with dt
  if (frameCount < 10) return;

  background(50, 50, 120);
  
  // keeping dt the same maintains stability
  softBody.update(0.1 / 6.0, g, polygons, 0.995);
  softBody.display();
  for (Polygon polygon : polygons) {
    polygon.display();
  }
  
  //textAlign(RIGHT, TOP);
  //textSize(20);
  //text(frameRate, width - 10, 10);
}
