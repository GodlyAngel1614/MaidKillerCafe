class BloodDrop {
  float x, y, speed, length;

  BloodDrop(float x, float y) {
    this.x = x;
    this.y = y;
    speed = random(1, 3);
    length = random(10, 30);
  }

  void update() {
    y += speed;
  }

  void display() {
    stroke(150, 0, 0);
    line(x, y, x, y + length);
  }
}
