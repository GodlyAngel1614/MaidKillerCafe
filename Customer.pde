static enum State {
  ENTERING,
    MOVING_TO_LINE,
    MOVING_TO_SLOT,
    IDLE
}

class Customer {
  PImage sprite;
  PImage[][] frames;

  int cols = 4;
  int rows = 4;

  int frameW, frameH;
  int currentFrame = 0;
  int currentRow = 0;

  int x, y;
  int targetX;
  int targetY;
  int targetY2;
  int slotIndex;

  boolean atTarget = false;

  State state = State.ENTERING;

  String order;
  float floatOffset = 0;
  float alpha = 0;

  // Kawaii reactions
  String[] kawaiiReplies = {
    "Omg kawaii desu! 💖",
    "Arigatou gozaimasu~ 🍰",
    "Sugoi! Thank you~ 😆",
    "Ureshii! So yummy~ 🍵"
  };

  String reaction = "";
  int reactionTimer = 0;

  boolean superDead = false;
  boolean readyToLeave = false; // flag to remove customer

  Customer(PImage sprite, int x, int y, int slotIndex) {
    this.sprite = sprite;
    this.x = x;
    this.y = y;
    this.slotIndex = slotIndex;

    targetX = 310;
    targetY = height / 2 + 56;
    targetY2 = height / 2 + 50 + slotIndex * 70;

    generateOrder();

    frameW = sprite.width / cols + 3;
    frameH = sprite.height / rows + 2;

    frames = new PImage[rows][cols];
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        frames[row][col] = sprite.get(col * frameW, row * frameH, frameW, frameH);
      }
    }
  }

  void generateOrder() {
    String[] items = {
      "Heart Pancakes",
      "Rose Latte",
      "Cream Puff",
      "Fruit Parfait",
      "Honey Milk Tea",
      "Matcha Latte",
      "Strawberry Soda"
    };

    int count = int(random(1, 3)); // 1–2 items
    order = "";
    for (int i = 0; i < count; i++) {
      order += items[int(random(items.length))];
      if (i < count - 1) order += " + ";
    }
  }

  void update() {
    // Movement logic
    if (state == State.ENTERING) {
      if (y > targetY) {
        y--;
        setAnimation(2);
      } else state = State.MOVING_TO_LINE;
    } else if (state == State.MOVING_TO_LINE) {
      if (x > targetX) {
        x--;
        setAnimation(3);
      } else state = State.MOVING_TO_SLOT;
    } else if (state == State.MOVING_TO_SLOT) {
      if (abs(y - targetY2) > 1) {
        y += (y < targetY2) ? 1 : -1;
        setAnimation(2);
      } else {
        y = targetY2;
        state = State.IDLE;
        atTarget = true;
      }
    } else if (state == State.IDLE) {
      floatOffset = sin(frameCount * 0.05) * 5;
      alpha = min(alpha + 10, 255);
    }

    // Animation
    if (frameCount % 10 == 0 && state != State.IDLE) {
      currentFrame = (currentFrame + 1) % cols;
    }
    if (state == State.IDLE) currentFrame = 0;

    if (keyPressed) {
      if (key == 'q') {
        superDead = true;
        println("we super deaded the customer guy.");
      }
    }
  }

  void drawOrderUI(HashMap<String, Integer> Inventory) {
    if (!atTarget) return;

    int boxW = 150, boxH = 50;
    int boxX = x, boxY = int(y - 60 + floatOffset);

    // Glow for combos
    if (order.contains("+")) {
      fill(255, 192, 203, 20); // fourth parameter is transparency tone it down
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

    triangle(boxX + 15, boxY + boxH, boxX + 25, boxY + boxH, boxX + 20, boxY + boxH + 10);

    boolean canServe = true;

    // Handle clicks
    if (mousePressed && mouseX > boxX && mouseX < boxX + boxW && mouseY > boxY && mouseY < boxY + boxH && reactionTimer == 0) {
      String[] items = order.split(" \\+ ");
      for (String item : items) {
        if (!Inventory.containsKey(item) || Inventory.get(item) <= 0) {
          canServe = false;
          break;
        }
      }

      if (canServe) {
        for (String item : items) Inventory.put(item, Inventory.get(item) - 1);
        reaction = kawaiiReplies[int(random(kawaiiReplies.length))];
        reactionTimer = 60;
        readyToLeave = true; // mark for removal after reaction
      } else {
        reaction = "Ahhhh! I can't eat this yet~ 😭";
        reactionTimer = 60;
      }
    }

    // Display reaction
    if (reactionTimer > 0) {
      fill(255, 0, 255, 200);
      textSize(14);
      textAlign(CENTER, BOTTOM);
      text(reaction, x + boxW/2, boxY - 10);
      reactionTimer--;
    }
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
