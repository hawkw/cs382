class Cube {
  float x , y , z
      , h , w , d
      , r , g , b;

  float rand_pos() { return random(-1000,1000); }
  float rand_size() { return random(0,100); }
  float rand_color() { return random(0,255); }


  Cube() { x = rand_pos();
           y = rand_pos();
           z = rand_pos();
           h = rand_size();
           w = rand_size();
           d = rand_size();
           r = rand_color();
           g = rand_color();
           b = rand_color();
          }

  void draw() { pushMatrix();
                translate(x, y, z);
                fill(r, g, b);
                box(h, w, d);
                popMatrix();
              }
}