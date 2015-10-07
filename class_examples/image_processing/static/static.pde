void setup() { size(800,600); }
void draw() {
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] = color( random(0,255)
                     , random(0, 255)
                     , random(0, 255) 
                     );
  }
  updatePixels();
}