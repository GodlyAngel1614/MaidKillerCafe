// imports

import processing.sound.*;
SoundFile mainThemeSong;
SoundFile firstScene;
SoundFile secondScene;
int prevState = -1;

ArrayList<STar> stars = new ArrayList<STar>();
ArrayList<BloodDrop> blood = new ArrayList<BloodDrop>();
ArrayList<Button> buttons = new ArrayList<Button>();
ArrayList<Cloud> clouds = new ArrayList<Cloud>();
Button yesButton;
Button glitchYesButton;
String title = "MAID KILLER CAFE";
float titleX, titleY;
FirstScene scene1;
SecondScene scene2;
ThirdScene scene3;
Player player;
CustomerManager custo;
DialogueBox box;
menu menuUI;
HashMap<String, Integer> inventory = new HashMap<String, Integer>();

boolean glitching = false;
boolean showModal = false;
int glitchTimer = 0;
int state = 0;
int day = 1;
int kills = 0;

MenuButtons[] menu;
String currentTab = "";
HashMap<String, String[]> recipes = new HashMap<String, String[]>();
HashMap<String, String[]> tut = new HashMap<String, String[]>();


void setup() {
  size(800, 600);
  //fullScreen();

  titleX = width / 2;
  titleY = height / 3;

  player = new Player();
  scene1 = new FirstScene(this);
  scene2 = new SecondScene(player);
  custo = new CustomerManager(this);
  scene3 = new ThirdScene(this);
  menuUI = new menu();

  mainThemeSong = new SoundFile(this, "MainThemeSong.mp3");
  mainThemeSong.play();
  mainThemeSong.loop();
  mainThemeSong.rate(1);
  
  secondScene = new SoundFile(this, "CafeMusic.mp3");


  yesButton = new Button(width/2 - 110, height/2 + 40, 100, 40, "YES");
  glitchYesButton = new Button(width/2 + 10, height/2 + 40, 100, 40, "Y̸E̷S̴");

  // Create stars
  for (int i = 0; i < 150; i++) {
    stars.add(new STar());
  }

  // Create clouds
  for (int i = 0; i < 8; i++) {
    clouds.add(new Cloud());
  }

  // Create buttons
  buttons.add(new Button(width/2 - 100, height/2 + 50, 200, 50, "START"));
  buttons.add(new Button(width/2 - 100, height/2 + 120, 200, 50, "EXIT"));

  textAlign(CENTER, CENTER);
  textSize(40);
}

void onStateChanged(int newState) {

  // leaving menu
  if (newState == 1) {
    mainThemeSong.stop();

    if (firstScene != null) {
      firstScene.stop(); // safe
    }

    firstScene = new SoundFile(this, "Scene1.mp3");
    firstScene.loop();
    firstScene.rate(0.85);
  }
  if (newState == 0) {
    if (firstScene != null) firstScene.stop();
    mainThemeSong.loop();
  }

  if (newState == 2) {
    firstScene.stop();
    secondScene.play();
    secondScene.loop();    
    // second song play (Find some music might already have some.)
  }

  if (newState == 3) {
    // third song play second song stop.
  }
}

void draw() {

  if (state != prevState) {
    onStateChanged(state);
    prevState = state;
  }

  if (state == 0) {
    ZeroState();
  } else if (state == 1) {
    scene1.drawf();
  } else if (state == 2) {
        print(state);

    scene2.drawf();
    custo.display();
    custo.update();
    menuUI.drawf();
  } else if (state == 3) {
    scene3.drawf(); // its line scene 1!
  } else if (state == 4) {
   // scene2.drawf();
    
   // custo.display();
   // custo.update();
  //  menuUI.drawf();
  }
  
  if (state == 10) {
    // Impossible state for day count we only have 4 days THIS is for the killer ending
  } else if (state == 11) {
    // Jail ending
  } else if (state == 12) {
    // Accomplice ending add in Amaris sprite or make it in the character thing... If you manage to kill then you get an accomplice as an optional upgrade in day 2 
  } else if (state == 13) {
    // Become the manager? Either that or kill the manager... Super pending here. 
  }
}

void ZeroState() {
  drawSky();
  drawMoon();
  drawStars();
  drawClouds();

  updateGlitch();

  drawTitle();
  drawBlood();
  drawButtons();
  drawGlitchOverlay();

  if (showModal) drawModal();
}

void drawModal() {
  // dark overlay
  fill(0, 180);
  rect(0, 0, width, height);

  // modal box
  float boxW = 300;
  float boxH = 150;
  float bx = width/2 - boxW/2;
  float by = height/2 - boxH/2;

  fill(20);
  stroke(255);
  rect(bx, by, boxW, boxH, 10);

  // text
  fill(255);
  textSize(20);
  text("Do you want to play?", width/2, by + 40);

  // buttons
  yesButton.update();
  yesButton.display();

  glitchYesButton.update();

  // glitch effect on second button
  if (random(1) < 0.2) {
    float jitter = random(-2, 200);
    pushMatrix();
    translate(jitter, 0);
    glitchYesButton.display();
    popMatrix();
  } else {
    glitchYesButton.display();
  }

  if (glitching) {
    float offset = random(-3, 3);
    bx += offset;
    by += offset;
  }
}

void drawClouds() {
  for (Cloud c : clouds) {
    c.update();
    c.display();
  }
}

void drawMoon() {
  float mx = width * 0.8;
  float my = height * 0.2;

  noStroke();

  // glow layers
  for (int i = 60; i > 0; i -= 10) {
    fill(200, 200, 255, 10);
    ellipse(mx, my, i * 2, i * 2);
  }

  // core moon
  fill(230, 230, 255);
  ellipse(mx, my, 80, 80);
}

void drawSky() {
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    color c = lerpColor(color(10, 10, 30), color(0, 0, 0), inter);
    stroke(c);
    line(0, y, width, y);
  }
}

void drawStars() {
  for (STar s : stars) {
    s.update();
    s.display();
  }
}

void drawTitle() {
  textSize(48);

  if (glitching) {
    float offset = random(-5, 5);

    fill(255, 0, 0);
    text(title, titleX + offset, titleY);

    fill(0, 255, 255);
    text(title, titleX - offset, titleY);

    mainThemeSong.rate(0.8);
  } else {
    mainThemeSong.rate(1);
  }

  fill(255);
  text(title, titleX, titleY);

  // Randomly spawn blood drips during glitch
  if (glitching && random(1) < 0.3) {
    float bx = random(titleX - 200, titleX + 200);
    blood.add(new BloodDrop(bx, titleY + 20));
  }
}

// ---- Blood ----
void drawBlood() {
  for (int i = blood.size() - 1; i >= 0; i--) {
    BloodDrop b = blood.get(i);
    b.update();
    b.display();

    if (b.y > height) {
      blood.remove(i);
    }
  }
}

// ---- Buttons ----
void drawButtons() {
  textSize(20);

  for (Button b : buttons) {
    b.update();
    b.display();
  }
}

// ---- Glitch Logic ----
void updateGlitch() {
  if (!glitching && random(1) < 0.01) {
    glitching = true;
    glitchTimer = int(random(35, 68));
  }

  if (glitching) {
    glitchTimer--;
    if (glitchTimer <= 0) {
      glitching = false;
    }
  }
}

// ---- Glitch Overlay ----
void drawGlitchOverlay() {
  if (glitching) {
    // screen flicker
    if (random(1) < 0.3) {
      fill(255, 20);
      rect(0, 0, width, height);
    }

    // horizontal tear lines
    stroke(255);
    for (int i = 0; i < 5; i++) {
      float y = random(height);
      line(0, y, width, y);
    }
  }
}

void mousePressed() {
  if (state == 1) {
    scene1.mousey();
  } else if (state == 3) {
    scene3.mousey();
  }

  // If modal is open, ONLY interact with modal
  if (showModal) {
    if (yesButton.hovered && state < 1) {
      println("Normal Yes...");
      state = 1;
    }

    if (glitchYesButton.hovered && state < 1) {
      println("Glitch Yes 😈");
      glitching = true;
      glitchTimer = 60; // force big glitch

      state = 1;
    }

    return; // stop clicking anything behind modal
  }

  // normal buttons
  for (Button b : buttons) {
    if (b.hovered) {
      if (b.label.equals("START")) {
        showModal = true;
      }
      if (b.label.equals("EXIT")) {
        exit();
      }
    }
  }
}

void keyPressed() {
  if (key == 'q') {
    print("Killing customer");
  } else if (key == 'e') {
    print("picking up customers dead body.");
  }
  
  if (state == 2 || state == 4) {
    menuUI.keyPressedf();
  }
}

void keyReleased() {
  if (state == 2 || state == 4) {
    menuUI.keyReleasedf();
  } 
}
