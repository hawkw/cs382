/**
 * Returns a random number not equal to the specified value.
 *
 * We use this to ensure that our random start x- and y-positions
 * are not equal to the Tile's original x- or y-position, since
 * that breaks the <code>map()</code> function we use for calculating
 * the angle to rotate.
 *
 * @param not the number that the random number cannot equal.
 * @param min the minimum value for the random number.
 * @param max the maximum value for the random number.
 * @return a random number between <code>min</code> and <code>max</code>.
 */
float rand_not(float not, float min, float max) {
  float result = not;
  while (result == not)
    result = random(min, max);
  return result;
}

/**
 * A tile in the image to reassemble.
 *
 * @author Hawk Weisman.
 */
class Tile {
  PImage image;
  int x      , y      // the Tile's target x- and y-positions
    , x_pos  , y_pos  // the Tile's current x- and y-positions
    , x_start;        // the initial x-position (used for angle calculation)


  /**
   * Constructs a new <code>Tile</code> from the given <code>PImage</code>
   * at the specified x- and y-position.
   *
   * @param image a <code>PImage</code> to extract this <code>Tile</code> from.
   * @param x the <code>Tile</code>'s x-position
   * @param y the <code>Tile</code>'s y-position
   * @return a new <code>Tile</code>
   */
  Tile(PImage image, int x, int y) {
    this.image   = image;
    this.x       = x;
    this.y       = y;
    this.x_pos   = (int)rand_not(x, 0, width);
    this.y_pos   = (int)rand_not(y, 0, height);
    this.x_start = x_pos;
  }

  /**
   * Draw this <code>Tile</code> and update its position and angle.
   */
  void draw() {
    if (x_pos != x)                  // if we're not at our final x-position
      x_pos = x_pos > x? x_pos - 1 : // move 1 pixel closer to it
                         x_pos + 1 ;

    if (y_pos != y)                  // if we're not at our final y-position
      y_pos = y_pos > y? y_pos - 1 : // move 1 pixel closer to it
                         y_pos + 1 ;

                                  // calculate the angle to rotate to
    float theta = map( x_pos      // by mapping our current x-position
                     , x, x_start // to the range 0-360, so that we are at
                     , 0, 360);   // 0 when we arrive at our target x-position

    pushMatrix();              // push a new matrix stack to draw this tile
      translate( x_pos + 10    // translate ten pixels further so that
               , y_pos + 10 ); // we can rotate around the tile's center

      rotate(radians(theta));  // rotate to the angle we caculated above

      translate(-10,-10);      // translate back to the real position

      image(image, 0, 0);      // finally, actually draw the pixel.
    popMatrix();
  }

}
