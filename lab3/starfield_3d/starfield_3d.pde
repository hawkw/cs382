import java.util.Collections;
import java.util.List;

// This has to be a `synchronizedList`; otherwise, Processing will throw
// a `ConcurrentModificationException`
List<Star> stars = Collections.synchronizedList(new ArrayList<Star>());

final float CAM_POS = 1000;
final float NUM_STARS = 400;

void setup() { size(800,600, P3D);
               pixelDensity(2); // enable this on Retina to reduce jitter
               registerMethod("pre", this);

               // create NUM_STAR stars by adding them to the stars list
               for (int i = 0; i < NUM_STARS; i++)
                 stars.add(new Star());

               background(0);
             }

/*
 * Updates each star's z-position, moving it closer to the viewer.
 *
 * Doing this in the `draw()` function sometimes causes Processing
 * to throw a `ConcurrentModificationException`, so it had to be
 * factored out into a separate function.
 */
void pre() { for (Star star : stars) // loop through the stars list
              star.tick();           // and update each star's position
           }

/*
 * Draws each frame by:
 * 		+ resetting the background to black
 * 		+ looping through the list of stars and drawing each star
 * 		+ setting the camera position
 */
void draw() { background(0); // set the background to black
                             // not doing this creates streaks, which is
                             // kinda cool

              for (Star star : stars) // loop through the list
                star.draw();          // and draw each star

              camera( 0, 0, CAM_POS
                    , 10*mouseX, 10*mouseY, -1000
                    , 0, 1, 0
                    );
             }
