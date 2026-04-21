class ScoreBoard {
  int score;
  int level;
  float barValue;
  PFont sFont;
  float h;

  ScoreBoard() {
    score = 0;
    sFont = createFont("ka1.ttf", 180);
    level = 1;
    barValue = 1;
    h = 100;
  }
  
  void HealthBar(float health) {
    
  }

  void display() {
    //bar
    push();
    fill(200);
    rect(0, 0, width, h);
    //words
    fill(#224488);
    textFont(sFont);
    textSize(80);
    textAlign(CORNER);
    text(score, 10, 75);
    textAlign(CENTER);
    text("My Game", width/2, 75);
    textSize(30);
    textAlign(RIGHT);
    text("Level " + level, width-10, 85);
    //bottom border
    fill(#224488);
    rect(0, 100, width, 8);
    //health bar
    fill(#224488);
    rect(width-360, 20, 350, 30);
    stroke(#224488);
    strokeWeight(2);
    fill(200);
    rect(width-370, 10, 350, 30);
    if (barValue > 0.6) {
      fill(#22AA22);
    } else if (barValue > 0.2) {
      fill(#AAAA22);
    } else {
      fill(#aa0000);
    }

    rect(width-370, 10, 350 * barValue, 30);
    pop();
  }

  void updateScore(int s) {
    score = s;
  }

  void updateLevel(int lvl) {
    level = lvl;
  }

  void updateBar(float v) {
    barValue = v;
  }
}
