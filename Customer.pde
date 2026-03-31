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

  int speed = 1;
  int x, y;
  int targetY = height / 2 + 56;

  boolean atTarget = false;
  int stage = 0;

  String order;

  float floatOffset = 0;
  float alpha = 0;

  int slotIndex;
  int targetX;
  int targetY2;

  String[] kawaiiReplies = {
    "Omg kawaii desu! 💖",
    "Arigatou gozaimasu~ 🍰",
    "Sugoi! Thank you~ 😆",
    "Ureshii! So yummy~ 🍵"
  };

  String reaction = ""; // store reaction to display
  int reactionTimer = 0; // fade out timer


  State state = State.ENTERING;

  Customer(PImage sprite, int x, int y, int slotIndex) {
    this.sprite = sprite;
    this.x = x;
    this.y = y;
    this.slotIndex = slotIndex;

    targetX = 310; //+ slotIndex * 70; // spacing between customers was removed needed it for vertical? Lining up instead.
    targetY2 = height / 2 + 50 + slotIndex * 70; // Vertical lining up DO NOT CHANGE THE 50 Estimated. The lower the higher
    generateOrder();

    frameW = sprite.width / cols + 3;
    frameH = sprite.height / rows + 2;

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
    };
  }

  // Generate combo orders
  void generateOrder() {
    String[] items = {
      "Heart Pancakes",
      "Rose Latte",
      "Cream Puff",
      "Macaron Stack",
      "Fruit Parfait",
      "Honey Milk Tea",
      "Matcha Latte",
      "Strawberry Soda"
    };

    int count = int(random(1, 3)); // 1–2 items why? Count from 0.. (4) doesn't work thats too much change the font for kawaiii desu

    order = "";
    for (int i = 0; i < count; i++) {
      order += items[int(random(items.length))];
      if (i < count - 1) order += " + ";
    }
  }

  void update() {

    if (state == State.ENTERING) {
      if (y > targetY) {
        y--;
        setAnimation(2);
      } else {
        state = State.MOVING_TO_LINE;
      }
    } else if (state == State.MOVING_TO_LINE) {
      if (x > targetX) {
        x--;
        setAnimation(3);
      } else {
        state = State.MOVING_TO_SLOT;
      }
    } else if (state == State.MOVING_TO_SLOT) {
      if (abs(y - targetY2) > 1) {
        if (y < targetY2) {
          y++;  // move DOWN
        } else {
          y--;  // move UP
        }
        setAnimation(2);
      } else {
        y = targetY2; // snap perfectly into place
        state = State.IDLE;
        atTarget = true;
      }
    } else if (state == State.IDLE) {
      floatOffset = sin(frameCount * 0.05) * 5;
      alpha = min(alpha + 10, 255);
    }

    // animation logic
    if (frameCount % 10 == 0 && state != State.IDLE) {
      currentFrame = (currentFrame + 1) % cols;
    }

    if (state == State.IDLE) {
      currentFrame = 0;
    }
  }

  void drawOrderUI(HashMap<String, Integer> Inventory, ArrayList<Customer> queue) {
    if (!atTarget) return;

    int boxW = 140;
    int boxH = 50;

    int boxX = x;
    int boxY = int(y - 60 + floatOffset);

    // Glow for big combos
    if (order.contains("+")) {
      fill(255, 192, 203, 50); // pastel pink glow
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

    // handle clicking
    if (mousePressed &&
      mouseX > boxX && mouseX < boxX + boxW &&
      mouseY > boxY && mouseY < boxY + boxH) {

      if (Inventory.containsKey(order) && Inventory.get(order) > 0) {
        reaction = kawaiiReplies[int(random(kawaiiReplies.length))];

        // decrease inventory
        Inventory.put(order, Inventory.get(order) - 1);

        // remove this customer from queue after showing reaction
        reactionTimer = 60; // show reaction 1 second (assuming 60 fps)
      } else {
        reaction = "Ahhhh! I can't eat this yet~ 😭";
        reactionTimer = 60;
      }
    }

    // display reaction above customer
    if (reactionTimer > 0) {
      fill(255, 0, 255, 200);
      textSize(14);
      textAlign(CENTER, BOTTOM);
      text(reaction, x + boxW/2, boxY - 10);
      reactionTimer--;

      // When timer finishes and order was correct, remove from queue
      if (reactionTimer == 0 && reaction != "Ahhhh! I can't eat this yet~ 😭") {
        // Remove customer and shift others
        custo.queue.remove(this);

        // adjust slotIndex and targetY2 for remaining customers
        for (int i = 0; i < custo.queue.size(); i++) {
          custo.queue.get(i).slotIndex = i;
          custo.queue.get(i).targetY2 = height / 2 + 50 + i * 70;
        }
      }
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
