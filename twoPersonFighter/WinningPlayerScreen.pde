class WinningPlayerScreen {
  PFont sFont;
  PImage bg;

  WinningPlayerScreen() {
    sFont = createFont("ka1.ttf", 200);
    bg = loadImage("gameOver.png");
    bg.resize(width,height);
  }

  void display(int winner) {
    push();
    textFont(sFont);
    background(#ff0000);
    textAlign(CENTER, CENTER);
    textSize(40);
    fill(#aaaa44);
    text("Player " + winner + " won!", width/2, height * 0.665);
    textSize(60);
    fill(200);
    textSize(30);
    fill(255);
    text("Created by Tom Jones", width * 0.85, height * 0.95);
    pop();
  }
}
