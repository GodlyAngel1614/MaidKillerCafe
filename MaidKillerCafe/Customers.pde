class CustomerManager {
  MaidKillerCafe app;

  ArrayList<Customer> queue = new ArrayList<Customer>();

  float spawnRate;
  int timer = 0;
  int spawned = 0;
  int toSpawn;

  PImage customerImg;

  CustomerManager(MaidKillerCafe app) {
    this.app = app;

    customerImg = loadImage("customer.png");

    spawnRate = 60 * 4;
    toSpawn = app.day + 2;
  }

  void update() {
    if (spawned < toSpawn) {
      timer++ ;

      if (timer >= spawnRate) {
        spawn();
        spawned++;
        timer = 0;
      }
    }

    // update all customers
    for (Customer c : queue) {
      c.update();
    }
  }

  void display() {
    for (Customer c : queue) {
      c.display();
    }
  }

  void spawn() {
    println("Customer spawned!");

    int x = 100 + queue.size() * 60; // simple line spacing
    int y = 400;

    Customer c = new Customer(customerImg, x, y);
    queue.add(c);
  }
}
