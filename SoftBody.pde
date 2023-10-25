class SoftBody {
  Node[] nodes;
  Spring[] springs;

  SoftBody(float x, float y, int w, int h, float d, float stiffness, float dampingFactor, float nodeRadii, color nodeColour) {
    
    Node[][] inputNodes = new Node[w][h];
    for (int xpos = 0; xpos < w; xpos++) {
      for (int ypos = 0; ypos < h; ypos++) {
        inputNodes[xpos][ypos] = new Node(x + xpos * d, y + ypos * d, 1, nodeRadii, nodeColour);
      }
    }
    
    springs = new Spring[(w-1) * (h-1) * 4 + (w-1) + (h-1)];
    for (int xpos = 0; xpos < w-1; xpos++) {
      for (int ypos = 0; ypos < h-1; ypos++) {
        springs[ypos + xpos * (h-1)] = new Spring(inputNodes[xpos][ypos], inputNodes[xpos + 1][ypos], stiffness, d, dampingFactor);
        //println(ypos + xpos * (h-1));
        springs[(ypos + xpos * (h-1)) + (w-1) * (h-1)] = new Spring(inputNodes[xpos][ypos], inputNodes[xpos][ypos + 1], stiffness, d, dampingFactor);
        //println((ypos + xpos * (h-1)) + (w-1) * (h-1));
        springs[(ypos + xpos * (h-1)) + (w-1) * (h-1) * 2] = new Spring(inputNodes[xpos][ypos], inputNodes[xpos + 1][ypos + 1], stiffness, d * 1.4142, dampingFactor);
        //println((ypos + xpos * (h-1)) + (w-1) * (h-1) * 2);
        springs[(ypos + xpos * (h-1)) + (w-1) * (h-1) * 3] = new Spring(inputNodes[xpos + 1][ypos], inputNodes[xpos][ypos + 1], stiffness, d * 1.4142, dampingFactor);
        //println((ypos + xpos * (h-1)) + (w-1) * (h-1) * 3);
      }
    }
    for (int xpos = 0; xpos < w-1; xpos++) {
      springs[(w-1) * (h-1) * 4 + xpos] = new Spring(inputNodes[xpos][h-1], inputNodes[xpos + 1][h-1], stiffness, d, dampingFactor);
      //println((w-1) * (h-1) * 4 + xpos);
    }
    for (int ypos = 0; ypos < h-1; ypos++) {
      springs[(w-1) * (h-1) * 4 + (w-1) + ypos] = new Spring(inputNodes[w-1][ypos], inputNodes[w-1][ypos + 1], stiffness, d, dampingFactor);
      //println((w-1) * (h-1) * 4 + (w-1) + ypos);
    }
    
    nodes = new Node[w * h];
    for (int xpos = 0; xpos < w; xpos++) {
      for (int ypos = 0; ypos < h; ypos++) {
        nodes[xpos * h + ypos] = inputNodes[xpos][ypos];
      }
    }
  }
  void update(float dt, float g, Polygon[] polygons, float airResistance) {
    for (Spring spring : springs) {
      spring.update();
    }
    for (int i = 0; i < nodes.length; i++) {
      nodes[i].handleGravity(g);
      nodes[i].update(dt, airResistance);
      for (int j = i + 1; j < nodes.length; j++) {
        nudgeNodes(nodes[i], nodes[j]);
      }
      //boolean collision = false;
      for (Polygon polygon : polygons) {
        //if (polygon.pointIn(nodes[i].pos)) collision = true;;
        nodePolygonCollision(nodes[i], polygon);
      }
      //if (collision) {
      //  nodes[i].colour = color(170, 170, 255);
      //} else {
      //  nodes[i].colour = color(255);
      //}
    }
  }

  void display() {
    for (Spring spring : springs) {
      spring.display();
    }
    for (Node node : nodes) {
      node.display();
    }
  }
}
