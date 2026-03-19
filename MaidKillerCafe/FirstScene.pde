
class FirstScene {

  FirstScene() {
  }

  void display() {
    background(0);
    ArrayList<String> lines = new ArrayList<String>();

    lines.add("Hello there.");
    lines.add("Welcome to the café...");
    lines.add("Don't look behind you.");

    box = new DialogueBox("Stranger", lines);
  }

  void drawf() {
    box.update();
    box.display();
  }
}
