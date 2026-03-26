class Customer {
  PImage sprite;
  PImage[][] frames;

  int cols = 4;
  int rows = 4;

  int frameW, frameH;

  int currentFrame = 0;
  int currentRow = 0;

  int speed = 1;
  int x, y;
  int targetY = 10;

  Customer(PImage sprite, int x, int y) {
    this.sprite = sprite;
    this.x = x;
    this.y = y;



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
    // move upward
    
    if (y < targetY) {
     y ++ ;
    }
    // animation
    if (frameCount % 10 == 0) {
      currentFrame = (currentFrame + 1) % cols;
    }

    // choose animation row (example: walking up)
    setAnimation(3);
  }
  void setAnimation(int row) {
    if (currentRow != row) {
      currentRow = row;
      currentFrame = 0;
    }
  }

  void display() {
    image(frames[currentRow][currentFrame], x, y);
  }
}
