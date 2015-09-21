class Star {
  float x, y, z;
  
  Star () { this.x = random(-1000,1000);
            this.y = random(-1000,1000);
            this.z = random(100,1000);
          }
          
   float fade() {
     //return z <= 500 ? 100 + (z * (155/500)) : 255;
     return z <= 255 ? z : 255;
   }
   
   void tick() {
     if (this.z > CAM_POS) {
       this.x = random(-1000,1000);
       this.y = random(-1000,1000);
       this.z = 100;
     } else {
       this.z += 1;
     }
   }
   
   void draw() {
     stroke(fade());
     point(x, y, z);
   }
  
}