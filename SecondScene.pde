class SecondScene {
  PImage cafe;
  Player player;

  SecondScene(Player player) {
    this.player = player;
    cafe = loadImage("Cafe.png");
  }

  void display() {
    image(cafe, 0, 0, width, height);
  }

  void drawf() {
    image(cafe, 0, 0, width, height);

    player.drawf();
    player.update();
  }
}
