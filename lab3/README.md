CMPSC382 Lab 3 - Hawk Weisman
=============================

### What is it?

Like my sketch from [the first lab](../lab1), this project 'simulates' flying through space. Since my first sketch only drew pixels, rather than shapes, I couldn't use translation matrices to rewrite the sketch. Instead, I chose to use Processing's 3D functionality, which, it turns out, makes implementing the star field significantly easier. It also now allows the viewer to pan the field of view using the mouse.

### How to use it

Since my use of [Quil](http://quil.info/) lead to issues viewing my sketch from lab 1, this one is implemented in standard Processing.

However, do note that since my MacBook has a Retina (220 PPI) display, I had to add the line `pixelDensity(2);` in the sketch's `setup()` function to reduce jittering. On computers with standard density displays, the call to `pixelDensity(2);` should be commented out; it will only make the frame rate slower.
