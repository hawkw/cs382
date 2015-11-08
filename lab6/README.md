# CMPSC382 Lab 6 - Hawk Weisman

### Image reassembly

Rather than calculating `xStep` and `yStep` values, I simply made each tile move at a rate of one pixel per frame. I chose this approach as I was having issues calculating step values with sufficient precision for tiles to actually stop upon reaching their destinations. When the step value was too high, tiles would often 'overshoot' their target x- or y-position and continue moving.

The code for moving each tile is shown in the following code segment:
```java
if (x_pos != x)                  // if we're not at our final x-position
  x_pos = x_pos > x? x_pos - 1 : // move 1 pixel closer to it
                     x_pos + 1 ;

if (y_pos != y)                  // if we're not at our final y-position
  y_pos = y_pos > y? y_pos - 1 : // move 1 pixel closer to it
                     y_pos + 1 ;
```
I then used Processing's `map()` function to calculate rotation angles so that the tile would always have rotated back to the correct position when it arrived at its destination. I did this by mapping the current x position to the range 0 ... 360, as shown in the following code snippet:

```java
// calculate the angle to rotate to
float theta = map( x_pos      // by mapping our current x-position
                 , x, x_start // to the range 0-360, so that we are at
                 , 0, 360);   // 0 when we arrive at our target x-position
```

When using this approach, an issue would occur intermittently where a tile's randomly generated starting x-position would be the same as it's target x-position. This would cause `map()` to throw an exception, since the two numbers that define the range to map from cannot be equal. Therefore, I wrote a simple helper function for generating random numbers not equal to a given value:

```java
int rand_not(int not, float min, float max) {
  int result = not;
  while (result == not)
    result = (int)random(min, max);
  return result;
}
```

### Brightness and Contrast

I called my program for the brightness and contrast assignment "fake_photoshop", since it is essentially mimicking the functionality found in Photoshop and other image editing tools.

I essentially followed the instructions in the lab handout for this assignment, but I did choose to move the code for drawing histograms and adjusting brightness and contrast to separate functions, in order to make the code more modular. Theoretically, if I were to continue using this code to implement a more fully-featured image editing tool, this modularity might make it a bit easier.

I also moved the code for calculating the brightness and contrast values to the `mouseMoved()` handler, as I believe this means that Processing can run it in a  separate thread. This could possibly make the program more responsive on a system with a very low frame rate.
