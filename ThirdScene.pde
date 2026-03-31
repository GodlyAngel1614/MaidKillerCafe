
class ThirdScene {

  DialogueBox box;
  MaidKillerCafe app;

  ThirdScene(MaidKillerCafe app) {
    ArrayList<String> lines = new ArrayList<String>();
    this.app = app;

    lines.add("You completed the first day... Yay.");
    box = new DialogueBox("Manager", lines, app);

    if (app.kills == 0) {
      lines.add("No kills? What a bleeding heart.");
      lines.add("You get a kawaii sticker! You make me sick.");
      lines.add("You have 3 days to redeem yourself!");
    } else {
      lines.add("Wow! You really put the maid in killer! Keep it up~");
      lines.add("You unlock the upgrades button~");
      lines.add("Keep up the good work for the next 3 days~");
    }
  }

  void display() {
    background(0);
  }

  void drawf() {
    background(0);
    box.update();
    box.display();
  }

  void mousey() {
    box.nextLine();
  }
}
