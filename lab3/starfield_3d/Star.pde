class Star {
  float x, y, z; // the star's x-, y-, and z-positions

  /*
   * Create a new star with a randomly generated x, y, and z-position
   */
  Star () { this.x = random(-1000,1000);
            this.y = random(-1000,1000);
            this.z = random(100,1000);
          }

  /*
   * Returns a value between 0 and 255 to set the star's brightness
   * based on its distance from the viewer.
   */
  float fade() { return z <= 500 ? 100 + (z * (155/500)) : 255; }

  /*
   * Updates a star's z-position prior to drawing it.
   *
   * If the star is behind the camera, we replace it with a new star
   * with a random x- and y-position at the vanishing point. Otherwise,
   * increment its z-position by 1, bringing it closer to the camera.
   *
   * This is called once per frame for each star by the `pre()` function.
   */
  void tick() { if (this.z > CAM_POS) {
                  this.x = random(-1000,1000);
                  this.y = random(-1000,1000);
                  this.z = 0;
                } else {
                  this.z += 1;
                }
              }

  /*
   * Draw a star by setting the stroke based on the star's z-distance
   * and drawing a point at the star's x-, y-, and z-position.
   *
   * This is called once per frame for each star by the `draw()` function.
   */
  void draw() { stroke(fade());
                point(x, y, z);
              }

}
