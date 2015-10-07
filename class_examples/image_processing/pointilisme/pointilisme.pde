PImage img;

void setup() {
  img = loadImage("lunar.jpg");
  size(480,240);
  image(img, 0, 0);
  
  loadPixels();
  
  noStroke();
  
  for (int i = 0; i < 10000; i++) {
    addPoint();
  }
  
}

void addPoint() {
  int x = (int)random(width);
  int y = (int)random(height);
  color c = pixels[width * y + x];
  fill( c );
  ellipse(x, y, 7, 7);
}

void draw() { addPoint(); }