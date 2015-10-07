PImage img
     , img_2;

void setup() {
  background(0);
  size(480,400);
  img   = loadImage("lunar.jpg");
  img_2 = createImage(img.width, img.height/2, RGB);
}

void draw() {
  image(img, 0, 0);
  loadPixels();
  color[][] two_d = convert_to_2d(pixels, img.width, img.height);
  image(img_2, 0, img.height);

}

color[][] convert_to_2d( color[] a
                       , int w
                       , int h ) 
{
  color[][] b = new color[h][w];
  int x = 0, y = 0;
  for (int i = 0; i < a.length; i++) {
    b[x][y] = a[i];
    if (x++ > w) {
      x = 0;
      y++;
    }
  }
  return b;
}