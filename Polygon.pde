class Polygon {
  PVector[] vertices;
  PVector min;
  PVector max;

  Polygon(PVector[] vertices) {
    this.vertices = vertices;
    min = vertices[0].copy();
    max = min.copy();
    for (PVector vertex : vertices) {
      if (vertex.x < min.x) {
        min.x = vertex.x;
      }
      if (vertex.y < min.y) {
        min.y = vertex.y;
      }
      if (vertex.x > max.x) {
        max.x = vertex.x;
      }
      if (vertex.y > max.y) {
        max.y = vertex.y;
      }
    }
  }

  boolean pointIn(PVector p) {
    if (p.x < min.x || p.y < min.y || p.x > max.x || p.y > max.y) return false;

    // POLYGON/POINT
    boolean collision = false;

    // go through each of the vertices, plus
    // the next vertex in the list
    int next = 0;
    for (int current=0; current<vertices.length; current++) {

      // get next vertex in list
      // if we've hit the end, wrap around to 0
      next = current+1;
      if (next == vertices.length) next = 0;

      // get the PVectors at our current position
      // this makes our if statement a little cleaner
      PVector vc = vertices[current];    // c for "current"
      PVector vn = vertices[next];       // n for "next"

      // compare position, flip 'collision' variable
      // back and forth
      if (((vc.y >= p.y && vn.y < p.y) || (vc.y < p.y && vn.y >= p.y)) &&
        (p.x < (vn.x-vc.x)*(p.y-vc.y) / (vn.y-vc.y)+vc.x)) {
        collision = !collision;
      }
    }
    return collision;
  }

  void display() {
    stroke(255);
    strokeWeight(1);
    noFill();
    beginShape();
    for (PVector vertex : vertices) {
      vertex(vertex.x, vertex.y);
    }
    endShape(CLOSE);
  }
}
