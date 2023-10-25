float distFromLineToPoint(PVector p1, PVector p2, PVector p) {
  return abs((p2.x-p1.x)*(p1.y-p.y)-(p1.x-p.x)*(p2.y-p1.y))/
         sqrt((p2.x-p1.x)*(p2.x-p1.x)+(p2.y-p1.y)*(p2.y-p1.y));
}

float distFromLineSegmentToPoint(PVector v, PVector w, PVector p) {
  // Return minimum distance between line segment vw and point p
  float l2 = PVector.sub(v, w).magSq();  // i.e. |w-v|^2 -  avoid a sqrt
  if (l2 == 0.0) return dist(p.x, p.y, v.x, v.y);   // v == w case
  // Consider the line extending the segment, parameterized as v + t (w - v).
  // We find projection of point p onto the line. 
  // It falls where t = [(p-v) . (w-v)] / |w-v|^2
  // We clamp t from [0,1] to handle points outside the segment vw.
  float t = max(0, min(1, PVector.dot(PVector.sub(p, v), PVector.sub(w, v)) / l2));
  PVector projection = PVector.add(v, PVector.mult(PVector.sub(w, v), t));  // Projection falls on the segment
  return dist(p.x, p.y, projection.x, projection.y);
}
