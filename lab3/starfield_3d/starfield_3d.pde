import java.util.Collections;
import java.util.List;

List<Star> stars = Collections.synchronizedList(new ArrayList<Star>());

final float CAM_POS = 1000;
final float NUM_STARS = 400;

void setup() {
  pixelDensity(2); // enable this on Retina to reduce jitter
  registerMethod("pre", this);
  size(800,600, P3D);
  background(0);
  
  for (int i = 0; i < NUM_STARS; i++)
    stars.add(new Star());
}


void pre() {
  for (Star star : stars) 
    star.tick();
}


void draw() { 
  background(0);
  
  for (Star star : stars)
    star.draw();
  
 camera( 0, 0, CAM_POS
     , mouseX, mouseY, -1000
     , 0, 1, 0
     );
}