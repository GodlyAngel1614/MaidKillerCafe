class Player {
  float xPos;
  float yPos;
  float xVelo;
  float yVelo;
  float health;
  PImage currentImage, idle, attacking, dead, jumping;
  String currentAction = "idle";
  int score;
  boolean left;
  float originalYPos;

  int timer = 0;

  Player(float x, float y, boolean left) {
    this.xPos = x;
    this.yPos = y;
    xVelo = 0;
    yVelo = 0;
    health = 100;
    score = 200;
    this.left = left;
    idle = loadImage("player_1_idle.png");
    idle.resize(300, 400);
    attacking = loadImage("player_1_attack.png");
    attacking.resize(300, 400);
    this.originalYPos = y;

    currentImage = idle;
  }

  void update() {
    xPos += xVelo;
    yPos += yVelo;
  }

  void display() {
    push();
    translate(xPos, yPos);
    scale(1, left ? -1 : 1);
    imageMode(CENTER);
    image(currentImage, 0, 0);
    pop();

    if (currentImage != idle || currentAction == "Jumping") {
      timer ++;

      if (timer > 60) {
        timer = 0;
        currentImage = idle;
        currentAction  = "idle";
        yPos = originalYPos;
      }
    }
  }

  void keyPressed() {
    if (key == 'd') {
      xVelo = 2;
    }
    if (key == 'a') {
      xVelo = -2;
    }
    if (key == 's') {
      yVelo = 2;
    }
    if (key == 'w') {
      yVelo = -2;
    }




    if (key == 'q') {
      currentAction = "Attack 1";

      currentImage = attacking;
    }
  }

  void takeDamage(int dam) {
    if (health <= 0) return;

    health -= dam;
  }

  void keyReleased() {
    if (key == 'd') {
      xVelo = 0;
    }
    if (key == 'a') {
      xVelo = 0;
    }
    if (key == 'w') {
      yPos = 400;
    }
  }

  float hitBoxOffset() {
    return 40;
  }

  float left() {
    return xPos - hitBoxOffset() ;
  }

  float right() {
    return xPos + hitBoxOffset() ;
  }

  float top() {
    return yPos - hitBoxOffset() ;
  }

  float bottom() {
    return yPos + hitBoxOffset() ;
  }
}
