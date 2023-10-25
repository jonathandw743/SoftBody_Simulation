class Spring {
  Node a;
  Node b;
  float stiffness;
  float restLength;
  float dampingFactor;
  
  Spring(Node a, Node b, float stiffness, float restLength, float dampingFactor) {
    this.a = a;
    this.b = b;
    this.stiffness = stiffness;
    this.restLength = restLength;
    this.dampingFactor = dampingFactor;
  }
  
  void update() {
    float springForce = stiffness * (PVector.sub(b.pos, a.pos).mag() - restLength);
    
    PVector normDirVec = PVector.sub(b.pos, a.pos).normalize();
    PVector velDiff = PVector.sub(b.vel, a.vel);
    float dampingForce = PVector.dot(normDirVec, velDiff) * dampingFactor;
    
    float totalForce = springForce + dampingForce;
    
    a.force.add(PVector.mult(normDirVec, totalForce));
    b.force.add(PVector.mult(normDirVec, -totalForce));
  }
  
  void display() {
    stroke(255);
    strokeWeight(1);
    line(a.pos.x, a.pos.y, b.pos.x, b.pos.y);
  }
}
