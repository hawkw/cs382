ArrayList<Cube> cubes = new ArrayList<Cube>();

final int MAX_SHAPES = 500;
final int WALK_SPEED = 5;
final float NINETY   = 90; // magic numbers are bad :)

float cam_x
    , cam_y
    , cam_z;
float look_x
    , look_y
    , look_z;

void setup() { size(800, 600, P3D);

               // set initial camera position
               cam_x = 0;  cam_y = 0;  cam_z = 2000;
               look_x = 0; look_y = 0; look_z = -1000;

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
                
              update_camera(angle_h(), angle_v());
              
              camera( cam_x, cam_y, cam_z
                    , look_x, look_y, look_z
                    , 0, 1, 0
                    );
            }

void keyboardInput() { switch (keyCode) {
                         case LEFT:   
                           cam_x += WALK_SPEED * 
                                    sin(radians(angle_h() - NINETY));
                           cam_z += WALK_SPEED * 
                                    -cos(radians(angle_h() - NINETY));
                           break;
                         case RIGHT:
                           cam_x += WALK_SPEED * 
                                    -sin(radians(angle_h() - NINETY));
                           cam_z += WALK_SPEED * 
                                    cos(radians(angle_h() - NINETY));
                           break;
                         case UP:  
                           cam_x += WALK_SPEED * 
                                    sin(radians(angle_h()));
                           cam_z += WALK_SPEED * 
                                    -cos(radians(angle_h()));
                           break;
                         case DOWN:   
                           cam_x += WALK_SPEED * 
                                    -sin(radians(angle_h()));
                           cam_z += WALK_SPEED * 
                                    cos(radians(angle_h()));
                           break;
                         default: break;
                       }
                     }
                     
float angle_h() { return ((float)mouseX /
                           (float)width - 0.5) * 360; }
                     
float angle_v() { return ((float)mouseY /
                          (float)height - 0.5) * 180; }
                                                   
                          
void update_camera(float theta_h, float theta_v) {
  look_x = 100000 * sin(radians(theta_h));
  look_y = 100000 * sin(radians(theta_v));
  look_z = -100000 * cos(radians(theta_h));
}