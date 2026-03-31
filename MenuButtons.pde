class MenuButtons {
  String label;
  int x, y, w, h;
  boolean hovered = false;
  boolean wasPressed = false;

  MenuButtons(String label, int x, int y, int w, int h) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void update() {
    hovered = mouseX > x && mouseX < x + w &&
      mouseY > y && mouseY < y + h;
  }

  void display() {
    // shadow (depth 👀)
    noStroke();
    fill(0, 50);
    rect(x + 3, y + 3, w, h, 12);

    // main button
    if (label.equals(currentTab)) {
      fill(120, 180, 255); // active tab
    } else if (hovered) {
      fill(200, 220, 255); // hover
    } else {
      fill(240);
    }

    stroke(0, 50);
    rect(x, y, w, h, 12);

    // text
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(13);
    text(label, x + w/2, y + h/2);
  }

  boolean isClicked() {
    boolean clicked = hovered && mousePressed && !wasPressed;
    wasPressed = mousePressed;
    return clicked;
  }
}
