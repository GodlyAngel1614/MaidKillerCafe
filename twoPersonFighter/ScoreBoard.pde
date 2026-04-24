class ScoreBoard {
  int score;
  int level;
  PFont sFont;
  float h;

  float health1, health2;
  float maxHealth;

  ScoreBoard(float player1Health, float player2Health) {
    score = 0;
    level = 1;
    h = 100;

    sFont = createFont("ka1.ttf", 180);

    maxHealth = 100;
    health1 = player1Health;
    health2 = player2Health;
  }

  void drawHealthBar(float health, float x, boolean mirror) {
    float barValue = constrain(health / maxHealth, 0, 1); 

    fill(200);
    rect(x, 10, 350, 30);

    if (barValue > 0.6) {
      fill(#22AA22);
    } else if (barValue > 0.2) {
      fill(#AAAA22);
    } else {
      fill(#AA0000);
    }

    float w = 350 * barValue;

    if (mirror) {
      rect(x + (350 - w), 10, w, 30);
    } else {
      rect(x, 10, w, 30);
    }
  }

  void display() {
    push();

    fill(200);
    rect(0, 0, width, h);

    fill(#224488);
    textFont(sFont);

    textSize(80);
    textAlign(LEFT);
    text(score, 10, 75);

    textAlign(CENTER);
    text("My Game", width / 2, 75);

    textSize(30);
    textAlign(RIGHT);
    text("Level " + level, width - 10, 85);

    fill(#224488);
    rect(0, 100, width, 8);

    drawHealthBar(health1, 20, false);              // Player 1 left to right
    drawHealthBar(health2, width - 370, true);      // Player 2 right to left

    pop();
  }

  void updateScore(int s) {
    score = s;
  }

  void updateLevel(int lvl) {
    level = lvl;
  }

  void updateHealth1(float h) {
    health1 = h;
  }

  void updateHealth2(float h) {
    health2 = h;
  }
}
