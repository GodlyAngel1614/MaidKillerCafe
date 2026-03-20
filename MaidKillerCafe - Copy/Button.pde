class Button {
  float x, y, w, h;
  String label;
  boolean hovered;

  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }

  void update() {
    hovered = mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h;
  }

  void display() {
    if (hovered) {
      fill(255, 0, 0);
    } else {
      fill(50);
    }
    rect(x, y, w, h);

    fill(255);
    textAlign(CENTER, CENTER);
    text(label, x + w/2, y + h/2);
  }
}
