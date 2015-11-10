
void setup() {
  PImage img = loadImage("lab7part1.png");
  img.loadPixels();
  colorMode(HSB);
  for (int i = 0; i < img.pixels.length; i++) {
    color pixel = img.pixels[i];
    // store this in a local variable since we reference it twice.
    float h = hue(pixel); 
   
    if (h == 0) {
      // I thought the red color made the text a little hard to read
      // so I desaturated it a bit.
      img.pixels[i] = color( h
                           , saturation(pixel) * 0.6
                           , brightness(pixel)
                           );
      // It's ironic that the color for "saturated fat" is
      // now the least saturated color. :)
    } else {
      // Otherwise, desaturate it just a little so that the red
      // doesn't look jarringly less saturated than the other colors.
      img.pixels[i] = color( h
                           , saturation(pixel) * 0.75
                           , brightness(pixel)
                           );
    }
  }
  img.updatePixels();
  
  size(533, 368);
  image(img,0,0);
}