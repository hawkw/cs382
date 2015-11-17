# CMPSC382 Lab 7 - Hawk Weisman

### Graph desaturation

For the first part of the lab assignment, I chose to desaturate the red bars of the graph, as I found the red color too saturated, making the text difficult to read. I then chose to desaturate the other colors as well, but to a lesser degree, so that the pinkish desaturated red would not appear out of place.

```java
for (int i = 0; i < img.pixels.length; i++) {
    color pixel = img.pixels[i];
    // store this in a local variable since we reference it twice.
    float h = hue(pixel);

    if (h == 0) {
      // I thought the red color made the text a little hard to read
      // so I desaturated it a bit.
      img.pixels[i] = color( h
                           , saturation(pixel) * 0.6
                           , brightness(pixel)
                           );
      // It's ironic that the color for "saturated fat" is
      // now the least saturated color. :)
    } else {
      // Otherwise, desaturate it just a little so that the red
      // doesn't look jarringly less saturated than the other colors.
      img.pixels[i] = color( h
                           , saturation(pixel) * 0.75
                           , brightness(pixel)
                           );
    }
}
```

### Better Google Maps

I found it difficult to improve the map's color palette. It was likely developed by a large team of professional graphic designers with a great deal of knowledge of color theory. Thus, I chose to make the map interactive, instead -- I'm a programmer, not a graphic artist, and adding interactivity to the visualization is something I know a bit more about.

In my sketch, clicking on a part of the map increases the brightness and saturation of similar colors, allowing features to be selectively highlighted. Pressing a key toggles between the original and modified image. Since the colors of pixels in the image vary slightly, it was necessary to select all pixels that fell within a certain range, as shown in the following code snippet:

```java
// where 'highlit' is the hue selected by the user clicking
for (int i = 0; i < newImg.pixels.length; i++) {
  color pixel = newImg.pixels[i];
  float hue = hue(pixel);
  if (hue > (highlit - 3) && hue < (highlit + 3))
    newImg.pixels[i] = color( hue
                            , saturation(pixel) + 50
                            , brightness(pixel) + 10
                            );

}
```
