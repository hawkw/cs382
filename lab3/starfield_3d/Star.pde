class Star {
  float x, y, z;
  
  Star () { this.x = random(-1000,1000);
            this.y = random(-1000,1000);
            this.z = random(100, 1000);
          }
          
   int fade() {
     return 255;
   }
   
   void tick() {
     if (this.z > CAM_POS) {
       this.x = random(-1000,1000);
       this.y = random(-1000,1000);
       this.z = random(100, 1000);
     } else {
       this.z += 1;
     }
   }
   
   void draw() {
     stroke(fade());
     point(x, y, z);
   }
  
}