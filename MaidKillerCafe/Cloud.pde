class Cloud {
  float x, y;
  float speed;
  float size;
  float alpha;

  Cloud() {
    x = random(width);
    y = random(height * 0.5); // upper half of screen
    speed = random(0.2, 0.6);
    size = random(60, 140);
    alpha = random(40, 90);
  }

  void update() {
    x += speed;

    // wrap around screen
    if (x > width + size) {
      x = -size;
      y = random(height * 0.5);
    }
  }

  void display() {
    noStroke();
    fill(200, 200, 255, alpha);

    // fluffy cloud (multiple circles)
    ellipse(x, y, size, size * 0.6);
    ellipse(x + size * 0.3, y - 10, size * 0.7, size * 0.5);
    ellipse(x - size * 0.3, y - 5, size * 0.7, size * 0.5);
  }
}
