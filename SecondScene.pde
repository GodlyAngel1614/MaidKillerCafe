class SecondScene {
  PImage cafe;
  Player player;

  SecondScene(Player player) {
    this.player = player;
    cafe = loadImage("Cafe.jpg");
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
