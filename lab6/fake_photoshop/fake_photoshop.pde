int[] k_hist = new int[256]  // histogram for all colors
    , r_hist = new int[256]  // histogram for red
    , g_hist = new int[256]  // histogram for green
    , b_hist = new int[256]; // histogram for blue

int max;

PImage img, imgEnhanced;

void setup() {
  img = loadImage("../data/lunar.jpg");
  size(992, 512);
  imgEnhanced = img;
  update_histograms(imgEnhanced);
}

void draw() {
  background(255);

  draw_histogram(k_hist, 0,   0,   color(0));
  draw_histogram(r_hist, 256, 0,   color(255,0,0));
  draw_histogram(g_hist, 0,   256, color(0,255,0));
  draw_histogram(b_hist, 256, 256, color(0,0,256));

  image(img, 512, 0);                  // draw original image at (512, 0)
  image(imgEnhanced, 512, img.height); // draw adjusted image at (512, 240)

}

void mouseMoved() {
  float contrast = map( mouseX
                      , 0, width
                      , 0, 5 );

  float brightness = map( mouseY
                        , 0, height
                        , -128, 128 );

  imgEnhanced = adjust(img, contrast, brightness);
  update_histograms(imgEnhanced);
}

void update_histograms(PImage img) {
  img.loadPixels();
  // zero out all histograms before updating.
  k_hist = new int[256];
  r_hist = new int[256];
  g_hist = new int[256];
  b_hist = new int[256];
  for (color pixel : img.pixels) {
    int r = (pixel >> 16) & 0xFF
      , g = (pixel >> 8)  & 0xFF 
      , b = pixel         & 0xFF 
      , k = (int)((r + g + b) / 3.0);
    k_hist[ k ]++;
    r_hist[ r ]++;
    g_hist[ g ]++;
    b_hist[ b ]++;
  }
  max = max(new int[]{ max(k_hist)
                     , max(r_hist)
                     , max(g_hist)
                     , max(b_hist)
                     });
}

void draw_histogram(int[] hist, int x, int y, color stroke) {
  assert hist.length == 256:
    "histogram array must contain 256 elements";
  assert x < width && y < height:
    "x- and y-positions must be within the sketch";

  pushMatrix();
    translate(x, y);
    stroke(0);
    noFill();
    rect(0,0,256,256);
    stroke(stroke);
    for (int i = 0; i < 256; i++)
      line( i, 255
          , i, 255 - map(hist[i], 0, max, 0, 255)
          );
  popMatrix();
}


PImage adjust( PImage input, float cont, float bright ) {
  int w = input.width;
  int h = input.height;
  // rather than passing in the output PImage as in the original code,
  // my version returns a new PImage. that means we don't need to
  // check the height and widths as in the original program.
  PImage output = new PImage(w, h);

  //t his is required before manipulating the image pixels directly
  input.loadPixels();
  output.loadPixels();

   //loop through all pixels in the image
   for(int i = 0; i < w*h; i++) {
       //get color values from the current pixel (which are stored as a list of type 'color')
       color inColor = input.pixels[i];

       //slow version for illustration purposes - calling a function inside this loop
       //is a big no no, it will be very slow, plust we need an extra cast
       //as this loop is being called w * h times, that can be a million times or more!
       //so comment this version and use the one below
      //  int r = (int) red(input.pixels[i]);
      //  int g = (int) green(input.pixels[i]);
      //  int b = (int) blue(input.pixels[i]);

       //here the much faster version (uses bit-shifting) - uncomment to try
       int r = (inColor >> 16) & 0xFF; //like calling the function red(), but faster
       int g = (inColor >> 8) & 0xFF;
       int b = inColor & 0xFF;

       //apply contrast (multiplcation) and brightness (addition)
       r = (int)(r * cont + bright); //floating point aritmetic so convert back to int with a cast (i.e. '(int)');
       g = (int)(g * cont + bright);
       b = (int)(b * cont + bright);

       //slow but absolutely essential - check that we don't overflow (i.e. r,g and b must be in the range of 0 to 255)
       //to explain: this nest two statements, sperately it would be r = r < 0 ? 0 : r; and r = r > 255 ? 255 : 0;
       //you can also do this with if statements and it would do the same just take up more space
       r = r < 0 ? 0 : r > 255 ? 255 : r;
       g = g < 0 ? 0 : g > 255 ? 255 : g;
       b = b < 0 ? 0 : b > 255 ? 255 : b;

       //and again in reverse for illustration - calling the color function is slow so use the bit-shifting version below
      //  output.pixels[i] = color(r ,g,b);
       output.pixels[i] = 0xff000000 | (r << 16) | (g << 8) | b; //this does the same but faster

   } //for

   //so that we can display the new image we must call this for each image
   input.updatePixels();
   output.updatePixels();
   return output;
} //ContrastAndBrightness