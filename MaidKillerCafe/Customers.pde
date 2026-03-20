class Customer {
  MaidKillerCafe app;

  Customer(MaidKillerCafe app) {
    this.app = app;
  }

  void spawn() {
    float spawnRate = 15000 / app.day;
    int elapsedTime = 0;
    int spawned = 0;
    int ToSpawn = app.day + 2;


    for (int i = app.day + 2; i >= 0;) {
      elapsedTime += 1;

      if (elapsedTime >= spawnRate) {
        i--;
        spawned ++;

        elapsedTime = 0;
      } else {
        print(elapsedTime);
      }
    }
  }
  
  
}
