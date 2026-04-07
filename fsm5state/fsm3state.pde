int state = 0;
int hex = #B1D8D3;

int seconds = 60 * 2;
int time = 0;

void setup() {
  size(500, 500);
}

void draw() {
  background(hex);
  time++;
  
  textSize(30);
  text(state, 60, 60);

  if (state == 3 && time > seconds) {
    state = 4;
    time = 0;
    updateColor();
  }

  if (state == 4 && time > 60) {
    state = 2;
    time = 0;
    updateColor();
  }
}

void keyPressed() {
  if (key == 'b') {
    state = 1;
    time = 0;
  } else if (key == 'x') {
    state = 2;
    time = 0;
  } else if (key == 'a') {
    state = 3;
    time = 0;
  }

  updateColor();
}

void updateColor() {
  if (state == 0) {
    hex = #B1D8D3;
  } else if (state == 1) {
    hex = #EA0254;
  } else if (state == 2) {
    hex = #FFD166; 
  } else if (state == 3) {
    hex = #28cc2a; 
  } else if (state == 4) {
    hex = #d09c39; 
  }
}
