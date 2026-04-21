class GameOverScreen {
  PFont sFont;
  PImage bg;

  GameOverScreen() {
    sFont = createFont("ka1.ttf", 200);
    bg = loadImage("gameOver.png");
    bg.resize(width,height);
  }

  void display() {
    push();
    textFont(sFont);
    imageMode(CORNER);
    image(bg, 0, 0);
    fill(#ff0000);
    textAlign(CENTER, CENTER);
    textSize(40);
    fill(#aaaa44);
    textSize(60);
    fill(200);
    text("Hit Start to play Again", width/2, height * 0.56);
    textSize(30);
    fill(255);
    text("Created by Tom Jones", width * 0.85, height * 0.95);
    pop();
  }
}
