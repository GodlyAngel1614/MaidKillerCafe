
class FirstScene {

  DialogueBox box;
  MaidKillerCafe app;

  FirstScene(MaidKillerCafe app) {
    ArrayList<String> lines = new ArrayList<String>();
    this.app = app;
    lines.add("Hi~");
    lines.add("Welcome to the maid cafe. Don't be totally incompetent.");
    lines.add("Today is your first day, I bet you're nervous.");
    lines.add("It's a big responsibility, being the cashier.");
    lines.add("I'm sure your parents are so proud of you.");
    lines.add("Anyways, I won't be coming to help you out! That's not the job of a manager.");
    lines.add("Have a greeeat first day!");

    box = new DialogueBox("Manager", lines, app);
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
