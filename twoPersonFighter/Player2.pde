class Player2 {
  float xPos;
  float yPos;
  float xVelo;
  float yVelo;
  float originalYPos;
  float health;
  PImage currentImage, idle, attack1, attack2, combo;
  String currentAction = "idle";
  int score;
  boolean left;

  int timer = 0;

  Player2(float x, float y, boolean left) {
    this.xPos = x;
    this.yPos = y;
    
    this.originalYPos = y;
    xVelo = 0;
    yVelo = 0;
    health = 100;
    score = 200;
    this.left = left;
    idle = loadImage("player_2_idle.png");
    idle.resize(300, 400);
    attack1 = loadImage("player_2_attack_1.png");
    attack1.resize(300, 400);

    attack2 = loadImage("player_2_attack_2.png");
    attack2.resize(300, 400);

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
    if (keyCode == RIGHT) {
      xVelo = 2;
    }
    if (keyCode == LEFT) {
      xVelo = -2;
    }
    if (keyCode == DOWN) {
      yPos = 400;

      currentAction  = "Jumping";
    }

    if (key == 'j') {
      currentAction  = "Slice 1";

      currentImage = attack1;
    } else if (key == 'k') {
      currentAction  = "Slice 2";

      currentImage = attack2;
    }
  }

  void keyReleased() {
    if (keyCode == RIGHT) {
      xVelo = 0;
    }
    if (keyCode == LEFT) {
      xVelo = 0;
    }
    if (keyCode == DOWN) {
      yVelo = 0;
    }
    if (keyCode == UP) {
      yVelo = 0;
    }
  }

  void takeDamage(int dam) {
    if (health <= 0) return;

    health -= dam;
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
