class Player {
  PImage sprite;
  PImage[][] frames;

  int cols = 4;
  int rows = 4;

  int frameW, frameH;

  int currentFrame = 0;
  int currentRow = 0;

  int speed = 3;
  int x = 200;
  int y = 200;

  Player() {
    sprite = loadImage("player.png");

    frameW = sprite.width / cols;
    frameH = sprite.height / rows;

    frames = new PImage[rows][cols];

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        frames[row][col] = sprite.get(
          col * frameW,
          row * frameH,
          frameW,
          frameH
        );
      }
    }
  }

  void update() {
    if (frameCount % 10 == 0) {
      currentFrame = (currentFrame + 1) % cols;
    }

    boolean moving = false;

    if (keyPressed) {
      if (key == 's') {
        y += speed;
        setAnimation(0);
        moving = true;
      }
      if (key == 'w') {
        y -= speed;
        setAnimation(2);
        moving = true;
      }
      if (key == 'a') {
        x -= speed;
        setAnimation(3);
        moving = true;
      }
      if (key == 'd') {
        x += speed;
        setAnimation(1);
        moving = true;
      }
    }

    if (!moving) {
      //setAnimation(0); 
      currentRow = 0;
      currentFrame = 0;
    }
  }

  void drawf() {
    image(frames[currentRow][currentFrame], x, y);
  }

  void setAnimation(int row) {
    if (currentRow != row) {
      currentRow = row;
      currentFrame = 0; 
    }
  }
}
