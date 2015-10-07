PImage img;
PFont font;

float ONE_THIRD = 1.0 / 3.0;

void setup() {
  img = loadImage("lunar.jpg");
  font = loadFont("PragmataPro-Bold-48.vlw");
  size(480, 480);
  image(img,0,0);
  image(img,0, img.height);
  loadPixels();
  colorMode(HSB);

  for (int i = pixels.length/2; i < pixels.length; i++) {
    color c   = pixels[i];
    //pixels[i] = color( ONE_THIRD * red(c)
    //                 + ONE_THIRD * green(c)
    //                 + ONE_THIRD * blue(c)
    //                 );
    //pixels[i] = color( 255 - red(c)
    //                  , 255 - green(c)
    //                  , 255 - blue(c)
    //                  );
    pixels[i] = color( hue(c) - 20
                     , saturation(c) % 120
                     , brightness(c) + 10 );    
  }

  updatePixels();

  textFont(font);
}

// void draw() {
//   background(0);
//   image(img
//         , mouseX - img.width/2
//         , mouseY - img.height/2
//         );
//   textSize(18);
//   text("James Irwin crusin'", 0,0);
// }