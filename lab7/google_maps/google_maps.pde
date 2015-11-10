final float HIGHWAY = 24.143192     // this is the color for the highways
          , ORANGE_ROADS = 31.31579
          , YELLOW_ROADS = 34.056293
          ;
boolean original = false;
PImage img, newImg;

void setup() {
  colorMode(HSB);
  size(1109, 562);
  
  img = loadImage("lab7part2.png");
  try { 
    // This has to be inside a `try`/`catch` block  because 
    // Java's type system is terrible (clone() can throw a 
    // CloneNotSupportedException  rather than, I don't know, 
    // just not being a method on all objects???)
    newImg = (PImage)img.clone(); 
  } catch (Exception e) { 
    println(e); 
  }
  
  newImg.loadPixels();
  for (int i = 0; i < newImg.pixels.length; i++) {
    color pixel = newImg.pixels[i];
    float hue = hue(pixel);
    if (hue > 24 && hue < 25) {
      // Bring out the borders of roads
     newImg.pixels[i] = color( hue
                           , saturation(pixel) - 50
                           , brightness(pixel) + 10);
    } else if ((hue >= 31 && hue < 32) ||
               (hue > 4 && hue < 5)) {
       // Make the universities and hospitals more saturated
      newImg.pixels[i] = color( hue
                           , saturation(pixel) + 50
                           , brightness(pixel));
      
    }
  }
  
  image(newImg, 0, 0);
}
void draw() {
  if (original)  image(img, 0, 0);
  else           image(newImg, 0, 0);
} 

void mousePressed() {
  loadPixels();
  color pixel = pixels[ mouseY * width + mouseX ];
  print( "The pixel at (" + mouseX + "," , mouseY + ") is "
       , "\t\nH:", hue(pixel)
       , "\t\nS:", saturation(pixel)
       , "\t\nB:", brightness(pixel)
       ,  "\n" );
}

void keyPressed() { 
  // pressing any key toggles between the original and modified map
  original = !original; 
}