class Node {
  PVector pos;
  PVector vel;
  PVector force;
  float mass;
  float r;
  color colour;
  
  Node(float x, float y, float mass, float r, color colour) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    force = new PVector(0, 0);
    this.mass = mass;
    this.r = r;
    this.colour = colour;
  }
  
  void update(float dt, float airResistance) {
    vel.add(PVector.div(PVector.mult(force, dt), mass));
    vel.mult(airResistance);
    pos.add(PVector.mult(vel, dt));
    force.mult(0);
  }
  
  void handleGravity(float g) {
    force.y += g * mass;
  }
  
  void display() {
    noStroke();
    fill(colour);
    circle(pos.x, pos.y, r * 2);
  }
}
