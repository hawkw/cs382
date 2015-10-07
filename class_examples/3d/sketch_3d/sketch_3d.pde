
void setup() {
  size(800, 480, P3D);
  background(0);
  noFill();

  stroke(50,255,50);
}


void draw() {
  background(0);
  
  //lights();
  //ambientLight(100,100,100);
  translate(width/2, height/2);
  
  stroke(50,255,50);
  rotateY(radians(mouseX / (width/360)));
  box(150);
  
  rotateX(radians(mouseY / (height/360)));
  box(250);
  stroke(255,255,255,100);
 // sphere(500);
}