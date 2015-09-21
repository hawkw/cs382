ArrayList<Cube> cubes = new ArrayList<Cube>();

final int MAX_SHAPES = 500;
final int WALK_SPEED = 5;
float cam_x, cam_y, cam_z;

void setup() { size(800, 600, P3D);

               // set initial camera position
               cam_x = 0; cam_y = 0; cam_z = 2000;

               // create shapes
               for (int i = 0; i < MAX_SHAPES; i++)
                 cubes.add(new Cube());
              }

void draw() { lights();
              background(0);
              fill(255);
              for (Cube cube : cubes)
                cube.draw();

              if (keyPressed && (key == CODED))
                keyboardInput();

              camera( cam_x, cam_y, cam_z
                    , 50 * mouseX, 50 * mouseY, -100000
                    , 0, 1, 0
                    );
            }

void keyboardInput() { switch (keyCode) {
                         case LEFT:   cam_x -= WALK_SPEED;
                                      break;
                         case RIGHT:  cam_x += WALK_SPEED;
                                      break;
                         case UP:     cam_z -= WALK_SPEED;
                                      break;
                         case DOWN:   cam_z += WALK_SPEED;
                                      break;
                         default: break;
                      }
                     }