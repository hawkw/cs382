final float HIGHWAY = 24.143192     // this is the color for the highways
          , ORANGE_ROADS = 31.31579
          , YELLOW_ROADS = 34.056293
          ;
          
void setup() {
  colorMode(HSB);
  size(1109, 562);
  PImage img = loadImage("lab7part2.png");
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    color pixel = img.pixels[i];
    float hue = hue(pixel);
    if (hue > 24 && hue < 25) {
      // Bring out the borders of roads
     img.pixels[i] = color( hue
                           , saturation(pixel) - 50
                           , brightness(pixel) + 10);
    }
  }
  image(img, 0, 0);
}
void draw() {} 

void mousePressed() {
  loadPixels();
  color pixel = pixels[ mouseY * width + mouseX ];
  print( "The pixel at (" + mouseX + "," , mouseY + ") is "
       , "\t\nH:", hue(pixel)
       , "\t\nS:", saturation(pixel)
       , "\t\nB:", brightness(pixel)
       ,  "\n" );
}