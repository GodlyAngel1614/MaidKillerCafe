class CustomerManager {
  MaidKillerCafe app;
  ArrayList<Customer> queue = new ArrayList<Customer>();
  PImage customerImg;

  float spawnRate = 60 * 4;
  int timer = 0, spawned = 0, toSpawn;

  CustomerManager(MaidKillerCafe app) {
    this.app = app;
    customerImg = loadImage("customer.png");
    toSpawn = app.day + 2;
  }

  void update() {
    // Spawn logic
    if (spawned < toSpawn) {
      timer++;
      if (timer >= spawnRate) {
        spawn();
        spawned++;
        timer = 0;
      }
    }

    // Update all customers
    for (Customer c : queue) c.update();

    // Remove customers that finished their reaction
    for (int i = queue.size() - 1; i >= 0; i--) {
      Customer c = queue.get(i);
      if (c.readyToLeave && c.reactionTimer <= 0) {
        queue.remove(i);
        // shift remaining customers
        for (int j = 0; j < queue.size(); j++) {
          queue.get(j).slotIndex = j;
          queue.get(j).targetY2 = height / 2 + 50 + j * 70;
        }
      }
      
      if (queue.size() == 0) {
        println("All customers were super served or killed.");
        app.state += 1;
        break;
      }
    }
  }

  void display() {
    for (Customer c : queue) {
      c.display();
      c.drawOrderUI(app.inventory);
    }
  }

  void spawn() {
    int startX = 450, startY = 600;
    int slot = queue.size();
    Customer c = new Customer(customerImg, startX, startY, slot);
    queue.add(c);
  }
}
