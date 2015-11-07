PImage image;
Tile[] tiles;

void setup() {
  image = loadImage("../data/lunar.jpg");
  size(480,240);
  // we can calculate the number of tiles needed based on the image dimensions
  tiles = new Tile[ width/20 * height/20 ];

  int tileNum = 0;

  for (int y = 0; y < image.height; y += 20) {
    for (int x = 0; x < image.width; x += 20) {
      // create a new Tile from this segment of the image
      tiles[tileNum] = new Tile( image.get(x, y, 20, 20)
                                , x, y);
      tileNum++;
    }
  }
}

void draw() {
  background(0);          // set the background to black
  for (Tile tile : tiles) // loop through and draw each tile
    tile.draw();
}