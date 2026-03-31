class SecondScene {
  PImage cafe;
  Player player;

  MenuButtons[] menu;
  String currentTab = "";
  MenuButtons cookButton;
  boolean cooking = false;
  String selectedFood = "";
  float cookBar = 0;
  float cookSpeed = 4;
  boolean movingRight = true;
  boolean clickHandled = false;
  boolean startCookGameNextFrame = false;
  boolean cookClickHandled = false;


  SecondScene(Player player) {
    this.player = player;
    cafe = loadImage("Cafe.png");

    menu = new MenuButtons[4];

    int startX = width - 160;
    int startY = 20;
    int spacing = 50;

    menu[0] = new MenuButtons("RecipeBook", startX, startY, 140, 40);
    menu[1] = new MenuButtons("Stock", startX, startY + spacing, 140, 40);
    menu[2] = new MenuButtons("Achievements", startX, startY + spacing * 2, 140, 40);
    menu[3] = new MenuButtons("Instructions", startX, startY + spacing * 3, 140, 40);

    cookButton = new MenuButtons("COOK", width - 160, height - 80, 140, 50);

    recipes.put("Sweetheart Set", new String[]{"Heart Pancakes", "Rose Latte"});
    recipes.put("Tea Time Treat", new String[]{"Cream Puff", "Honey Milk Tea"});
    recipes.put("Morning Smile", new String[]{"Macaron Stack", "Matcha Latte"});
    recipes.put("Berry Bliss", new String[]{"Fruit Parfait", "Strawberry Soda"});
  }

  void addToInventory(String item) {
    if (inventory.containsKey(item)) {
      inventory.put(item, inventory.get(item) + 1);
    } else {
      inventory.put(item, 1);
    }
  }

  void display() {
    image(cafe, 0, 0, width, height);
  }

  void drawCookingGame() {
    if (selectedFood.equals("")) return;

    // background
    fill(0, 180);
    rect(0, 0, width, height);

    // bar track
    int barX = width/2 - 150;
    int barY = height/2;
    int barW = 300;

    fill(200);
    rect(barX, barY, barW, 20);

    // perfect zone
    fill(100, 255, 100);
    rect(barX + 120, barY, 60, 20);

    // moving slider
    fill(50);
    rect(barX + cookBar, barY, 10, 20);

    // movement
    if (movingRight) cookBar += cookSpeed;
    else cookBar -= cookSpeed;

    if (cookBar > barW || cookBar < 0) {
      movingRight = !movingRight;
    }

    // click to stop
    if (mousePressed && !cookClickHandled) {
      if (cookBar > 120 && cookBar < 180) {
        println("Perfect cook!");
        addToInventory(selectedFood);
      } else {
        println("You are terrible...");
      }

      cooking = false;
      selectedFood = "";
      cookBar = 0;
      cookClickHandled = true;
    }

    if (!mousePressed) cookClickHandled = false;
  }

  void drawPanel() {
    if (currentTab.equals("")) return;

    int panelX = width - 350;
    int panelY = 20;
    int panelW = 300;
    int panelH = 300;

    // shadow
    noStroke();
    fill(0, 80);
    rect(panelX + 5, panelY + 5, panelW, panelH, 16);

    // glass panel
    fill(255, 230);
    stroke(255, 255, 255, 120);
    rect(panelX, panelY, panelW, panelH, 16);

    // title
    fill(0);
    textSize(18);
    textAlign(LEFT, TOP);
    text(currentTab, panelX + 15, panelY + 12);

    // divider line
    stroke(0, 50);
    line(panelX + 10, panelY + 40, panelX + panelW - 10, panelY + 40);


    if (currentTab.equals("RecipeBook")) {
      int yOffset = 50;

      for (String recipeName : recipes.keySet()) {
        text(recipeName, panelX + 10, panelY + yOffset);
        yOffset += 20;
      }
    } else if (currentTab.equals("Stock")) {
      int yOffset = 50;
      for (String item : inventory.keySet()) {
        int count = inventory.get(item);
        text(item + " x" + count, panelX + 10, panelY + yOffset);
        yOffset += 20;
      }
    }
  }

  String checkRecipe(String order) {
    String[] items = split(order, " + ");

    for (String recipeName : recipes.keySet()) {
      String[] recipeItems = recipes.get(recipeName);

      if (items.length == recipeItems.length) {
        boolean match = true;

        for (int i = 0; i < items.length; i++) {
          if (!items[i].equals(recipeItems[i])) {
            match = false;
            break;
          }
        }

        if (match) return recipeName;
      }
    }

    return "Unknown Combo";
  }

  void drawCookingMenu() {
    if (!cooking || selectedFood != "") return;

    fill(0, 150);
    rect(0, 0, width, height);

    String[] options = {
      "Heart Pancakes",
      "Rose Latte",
      "Cream Puff",
      "Honey Milk Tea",
      "Macaron Stack",
      "Matcha Latte",
      "Fruit Parfait",
      "Strawberry Soda"
    };
    for (int i = 0; i < options.length; i++) {
      int bx = width/2 - 100;
      int by = 150 + i * 60;

      fill(255);
      rect(bx, by, 200, 40, 10);

      fill(0);
      textAlign(CENTER, CENTER);
      text(options[i], bx + 100, by + 20);

      if (mousePressed && !clickHandled &&
        mouseX > bx && mouseX < bx + 200 &&
        mouseY > by && mouseY < by + 40) {

        selectedFood = options[i];
        clickHandled = true;
        startCookGameNextFrame = true; // mark to start on next frame
      }

      if (!mousePressed) {
        clickHandled = false;
      }
    }
  }

  void drawf() {
    image(cafe, 0, 0, width, height);

    player.drawf();
    player.update();

    for (int i = 0; i < menu.length; i++) {
      menu[i].update();
      menu[i].display();

      if (menu[i].isClicked()) {
        if (currentTab.equals(menu[i].label)) {
          currentTab = ""; // close it
        } else {
          currentTab = menu[i].label; // open new one
        }
      }
    }

    cookButton.update();
    cookButton.display();

    if (cookButton.isClicked()) {
      cooking = true;
    }

    if (cooking) {
      if (selectedFood.equals("")) {
        drawCookingMenu();
      } else if (startCookGameNextFrame) {
        // Wait one frame so mouseReleased avoids instant click
        startCookGameNextFrame = false;
      } else {
        drawCookingGame(); // now the mini-game runs safely
      }
    }

    drawPanel();
  }
}
