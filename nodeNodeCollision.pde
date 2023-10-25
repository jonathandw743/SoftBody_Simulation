void nudgeNodes(Node n1, Node n2) {
  PVector posDiff = PVector.sub(n2.pos, n1.pos);
  
  if (posDiff.magSq() > (n1.r + n2.r) * (n1.r + n2.r)) return;
  
  float desiredDist = n1.r + n2.r;
  PVector desiredPosDiff = posDiff.copy().setMag(desiredDist);
  PVector centre = PVector.add(n1.pos, PVector.mult(posDiff, 0.5));
  n1.pos = PVector.add(centre, PVector.mult(desiredPosDiff, -0.5));
  n2.pos = PVector.add(centre, PVector.mult(desiredPosDiff, 0.5));
}
