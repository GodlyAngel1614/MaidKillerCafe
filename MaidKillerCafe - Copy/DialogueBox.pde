class DialogueBox {

  String speakerTag;
  ArrayList<String> dialogue;

  int index = 0;
  String currentText = "";
  int charIndex = 0;

  int typeSpeed = 2; // lower = faster

  DialogueBox(String tag, ArrayList<String> dialogueLines) {
    this.speakerTag = tag;
    this.dialogue = dialogueLines;
  }

  void update() {
    if (index >= dialogue.size()) return;

    String fullText = dialogue.get(index);

    if (charIndex < fullText.length()) {
      if (frameCount % typeSpeed == 0) {
        charIndex++;
        currentText = fullText.substring(0, charIndex);
      }
    }
  }

  void nextLine() {
    if (index < dialogue.size() - 1) {
      index++;
      charIndex = 0;
      currentText = "";
    } else if (state == 1 && index >= dialogue.size() - 1) {
      state = 2;
    }
  }

  void display() {
    fill(255);
    textAlign(LEFT);

    text(speakerTag + ":", 50, height - 120);
    text(currentText, 50, height - 90);
  }
}
