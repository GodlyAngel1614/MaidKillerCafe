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
  int targetY = height / 2 - 50;

  boolean atTarget = false;

  String order;

  float floatOffset = 0;
  float alpha = 0;

  int slotIndex;
  int targetX;

  Customer(PImage sprite, int x, int y, int slotIndex) {
    this.sprite = sprite;
    this.x = x;
    this.y = y;
    this.slotIndex = slotIndex;

    targetX = 235 + slotIndex * 70; // spacing between customers

    generateOrder();

    frameW = sprite.width / cols + 3;
    frameH = sprite.height / rows + 1;

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

  // 🍔 Generate combo orders
  void generateOrder() {
    String[] items = {"Burger", "Fries", "Pizza", "Soda"};

    int count = int(random(1, 4)); // 1–3 items

    order = "";
    for (int i = 0; i < count; i++) {
      order += items[int(random(items.length))];
      if (i < count - 1) order += " + ";
    }
  }

  void update() {

    if (atTarget) {
      floatOffset = sin(frameCount * 0.05) * 5;
      alpha = min(alpha + 10, 255); // 👈 THIS WAS MISSING
    }
    // move vertically first
    if (y > targetY) {
      y--;
      setAnimation(2);
    } else {
      atTarget = true;
    }

    // move horizontally into position
    if (atTarget && x < targetX) {
      x++;
      setAnimation(1); // walking right
    }

    // animation
    if (frameCount % 10 == 0 && (!atTarget || x < targetX)) {
      currentFrame = (currentFrame + 1) % cols;
    }

    if (atTarget && x == targetX) {
      currentFrame = 0;
    }
  }

  void drawOrderUI() {
    if (!atTarget) return;

    int boxW = 140;
    int boxH = 50;

    int boxX = x;
    int boxY = int(y - 60 + floatOffset);

    // 🌟 Glow for big combos
    if (order.contains("+")) {
      fill(255, 255, 150, 80);
      noStroke();
      rect(boxX - 5, boxY - 5, boxW + 10, boxH + 10, 12);
    }

    fill(255, alpha);
    stroke(0, alpha);
    rect(boxX, boxY, boxW, boxH, 10);

    fill(0, alpha);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(order, boxX + boxW/2, boxY + boxH/2);

    triangle(
      boxX + 15, boxY + boxH,
      boxX + 25, boxY + boxH,
      boxX + 20, boxY + boxH + 10
      );
  }

  void setAnimation(int row) {
    if (currentRow != row) {
      currentRow = row;
      currentFrame = 0;
    }
  }

  void display() {
    image(frames[currentRow][currentFrame], x, y);
    drawOrderUI();
  }
}
