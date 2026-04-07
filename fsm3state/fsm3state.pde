int state = 0;
int hex = #B1D8D3;

void setup() {
  size(500, 500);
  background(hex);
}

void draw() {
  background(hex);  

  textSize(30);
  text(state, 60, 60);

}

void keyPressed() {
  if (key == ' ' && state < 3) {
    state += 1;
  } else if (key == ' ' && state == 2) {
    state = 0;
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
