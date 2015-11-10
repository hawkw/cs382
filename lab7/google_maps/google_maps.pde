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
  
  image(newImg, 0, 0);
}
void draw() {

  
  if (original)  image(img, 0, 0);
  else           image(newImg, 0, 0);
} 

void mousePressed() {
  img.loadPixels();
  float highlit = hue(img.pixels[ mouseY * width + mouseX ]);
  print( "Highlighting hue", highlit + ".\n");
  // reset the enhanced image
  try { 
    newImg = (PImage)img.clone(); 
  } catch (Exception e) { 
    println(e); 
  }
  newImg.loadPixels();
  for (int i = 0; i < newImg.pixels.length; i++) {
    color pixel = newImg.pixels[i];
    float hue = hue(pixel);
    if (hue > (highlit - 3) && hue < (highlit + 3))
      newImg.pixels[i] = color( hue
                              , saturation(pixel) + 50
                              , brightness(pixel) + 10
                              );
      
  }
  newImg.updatePixels();
}

void keyPressed() { 
  // pressing any key toggles between the original and modified map
  original = !original; 
}