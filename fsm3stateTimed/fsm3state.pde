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
  
  if (time > seconds) {
    time = 0;
    
    state++;
    
    if (state > 2) {
      state = 0;
    }
    
    updateColor();
  }
}

void keyPressed() {
  if (key == ' ') {
    state++;
    
    if (state > 2) {
      state = 0;
    }
    
    updateColor();
  }
}

void updateColor() {
  if (state == 0) {
    hex = #B1D8D3;
  } else if (state == 1) {
    hex = #EA0254;
  } else if (state == 2) {
    hex = #FFD166; 
  }
}
