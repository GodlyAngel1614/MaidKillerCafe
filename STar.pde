float brightness;
float twinkleSpeed;

class STar {
  float x, y, speed;

  STar() {
    x = random(width);
    y = random(height);
    speed = random(0.5, 2.0);
    brightness = random(150, 255);
    twinkleSpeed = random(0.05, 0.2);
  }

  void update() {
    y += speed;
    brightness += sin(frameCount * twinkleSpeed) * 2;
    if (y > height) {
      y = 0;
      x = random(width);
    }
  }

  void display() {
    pushMatrix();
    translate(x, y);

    noStroke();
    fill(brightness);

    float s = 3;

    beginShape();
    vertex(0, -s);
    vertex(s/3, -s/3);
    vertex(s, 0);
    vertex(s/3, s/3);
    vertex(0, s);
    vertex(-s/3, s/3);
    vertex(-s, 0);
    vertex(-s/3, -s/3);
    endShape(CLOSE);

    popMatrix();
  }
}
