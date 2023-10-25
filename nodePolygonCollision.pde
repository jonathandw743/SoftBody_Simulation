void nodePolygonCollision(Node n, Polygon p) {
  if (!p.pointIn(n.pos)) return;
  
  int minDistIndex = 0;
  float minDist = distFromLineSegmentToPoint(p.vertices[0], p.vertices[1], n.pos);
  for (int i = 0; i < p.vertices.length; i++) {
    float distFromNodeToEdge = distFromLineSegmentToPoint(p.vertices[i], p.vertices[(i + 1) % p.vertices.length], n.pos);
    if (distFromNodeToEdge < minDist) {
      minDist = distFromNodeToEdge;
      minDistIndex = i;
    }
  }
  PVector lineVector = PVector.sub(p.vertices[(minDistIndex + 1) % p.vertices.length], p.vertices[minDistIndex]);
  PVector normLineVector = lineVector.copy().normalize();
  PVector pointToNode = PVector.sub(n.pos, p.vertices[minDistIndex]);
  PVector projected = PVector.mult(normLineVector, PVector.dot(pointToNode, normLineVector));
  n.pos = PVector.add(p.vertices[minDistIndex], projected);
  
  n.vel = PVector.mult(normLineVector, PVector.dot(n.vel, normLineVector));
}
