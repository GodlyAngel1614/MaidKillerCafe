class ThirdScene {

  DialogueBox box;
  MaidKillerCafe app;
  PImage cutePic;

  boolean showSticker = false;
  float stickerScale = 0;

  ArrayList<Sparkle> sparkles = new ArrayList<Sparkle>();
  ArrayList<Heart> hearts = new ArrayList<Heart>();

  ThirdScene(MaidKillerCafe app) {
    this.app = app;

    ArrayList<String> lines = new ArrayList<String>();

    lines.add("You completed the first day... Yay.");

    if (app.kills == 0) {
      lines.add("No kills? What a bleeding heart.");
      lines.add("You get a kawaii sticker! You make me sick.");
      lines.add("Game over!");
      cutePic = loadImage("KawaiiSticker1.png");
    } else {
      lines.add("Wow! You really put the maid in killer! Keep it up~");
      lines.add("You unlock the upgrades button~");
      lines.add("Keep up the good work for the next 3 days~");
    }

    box = new DialogueBox("Manager", lines, app);
  }

  void display() {
    background(0);
  }

  void drawf() {
    background(0);

    box.update();
    box.display();

    // Trigger sticker
    if (app.kills == 0 && box.index == 2) {
      showSticker = true;
    }
    
    if (box.index == 4) {
         app.day += 1;
    }

    if (showSticker) {

      // smooth pop-in
      stickerScale = lerp(stickerScale, 1, 0.08);

      float imgW = (width / 2) * stickerScale;
      float imgH = (height / 2) * stickerScale;

      imageMode(CENTER);
      image(cutePic, width / 2, height / 2, imgW, imgH);

      // Generate sparkles + hearts ONCE
      if (sparkles.size() == 0) {
        for (int i = 0; i < 20; i++) {
          sparkles.add(new Sparkle(width / 2, height / 2, width / 2, height / 2));
        }
      }

      if (hearts.size() == 0) {
        for (int i = 0; i < 10; i++) {
          hearts.add(new Heart(width / 2, height / 2, width / 2, height / 2));
        }
      }

      // ✨ GLOW MODE ✨
      blendMode(ADD);

      for (Sparkle s : sparkles) {
        s.update();
        s.display();
      }

      for (Heart h : hearts) {
        h.update();
        h.display();
      }

      blendMode(BLEND);
    }
  }

  void mousey() {
    box.nextLine();
  }

  // ✨ Sparkle Class ✨
  class Sparkle {
    float x, y;
    float size;
    float alpha;
    float speed;

    Sparkle(float cx, float cy, float w, float h) {
      float angle = random(TWO_PI);
      float radius = random(w / 2);

      x = cx + cos(angle) * radius;
      y = cy + sin(angle) * radius;

      size = random(6, 14);
      alpha = random(150, 255);
      speed = random(0.05, 0.1);
    }

    void update() {
      alpha = 200 + sin(frameCount * speed) * 55;
    }

    void display() {
      pushMatrix();
      translate(x, y);

      noStroke();
      fill(255, 255, 200, alpha);

      beginShape();
      vertex(0, -size);
      vertex(size * 0.3, -size * 0.3);
      vertex(size, 0);
      vertex(size * 0.3, size * 0.3);
      vertex(0, size);
      vertex(-size * 0.3, size * 0.3);
      vertex(-size, 0);
      vertex(-size * 0.3, -size * 0.3);
      endShape(CLOSE);

      popMatrix();
    }
  }

  // 💕 Floating Heart Class 💕
  class Heart {
    float x, y;
    float size;
    float speed;
    float alpha;

    Heart(float cx, float cy, float w, float h) {
      x = cx + random(-w/2, w/2);
      y = cy + random(-h/2, h/2);

      size = random(10, 20);
      speed = random(0.3, 0.8);
      alpha = random(150, 255);
    }

    void update() {
      y -= speed;

      // reset when floating too high
      if (y < height / 2 - 200) {
        y = height / 2 + random(50, 150);
      }
    }

    void display() {
      pushMatrix();
      translate(x, y);
      noStroke();

      fill(255, 150, 200, alpha);

      // simple heart shape
      beginShape();
      vertex(0, size/2);
      bezierVertex(size, -size/2, size*1.5, size/2, 0, size*1.5);
      bezierVertex(-size*1.5, size/2, -size, -size/2, 0, size/2);
      endShape(CLOSE);

      popMatrix();
    }
  }
}
