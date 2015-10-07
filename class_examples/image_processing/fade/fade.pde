PImage lunar, capsule;
int fadeAmount = 255;
boolean fadeState = false; // false == fade in, true == fade out

void setup() {
  lunar = loadImage("lunar.jpg");
  capsule = loadImage("capsule.jpg");
  size(480,240);
  //tint(0, 150, 200); // blue tint
  //tint(255,127); // alpha fade
}

void draw() {
  tint(255, 255);
  image(capsule, 0, 0);
  tint(255, fadeAmount);
  image(lunar, 0, 0);
  
  // fade in/out depending on fade state
  if (fadeState) fadeAmount++;
  else fadeAmount--;
  
  // check the fade state and toggle if we're fully faded in or out
  if (fadeAmount == 0 || fadeAmount == 255)
    fadeState = !fadeState;
}