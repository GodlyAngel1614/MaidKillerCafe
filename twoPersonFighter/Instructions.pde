class Instructions {
  PFont sFont;
  PImage bg;

  Instructions() {
    sFont = createFont("ka1.ttf", 200);
    bg = loadImage("instructions.png");
    bg.resize(width,height);
  }

  void display() {
    push();
    textFont(sFont);
    imageMode(CORNER);
    image(bg, 0, 0);
    pop();
  }
}
