class SymmetricVelParticle {
  PVector location;
  PVector velocity;
  //PVector acceleration;
  // The Mover's maximum speed
  float _scale;

  SymmetricVelParticle(float scl) {
   _scale = scl;
   location = new PVector(width/2,height/2);
   velocity = new PVector(0,0);
   
  }

  void update() {
   PVector mouse = new PVector(mouseX,mouseY);
   PVector acceleration = PVector.sub(mouse,location);
    // Set magnitude of acceleration
    acceleration.setMag(_scale);
    
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
   
    // Location changes by velocity
    location.add(velocity);
    
  }

  void display() {
    stroke(255);
    strokeWeight(2);
    fill(127);
    ellipse(location.x,location.y,10,10);
  }
  
 
}