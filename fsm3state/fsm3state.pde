int state = 0;
int hex = #B1D8D3;

void setup() {
  size(500, 500);
  background(hex);
}

void draw() {
  
}

void keyPressed() {
  if (key == ' ' && state < 3) {
    state += 1;
  } else if (key == ' ' && state == 2) {
    state = 0;
  } 
}
