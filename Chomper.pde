class Chomper {
  
  int xDirection, yDirection;
  float size;
  float maxSpeed;
  float maxForce;
  
  PVector position; //replaces 0 and 0
  PVector speed; //replaces xSpeed and ySpeed, take heading() of this to get direction of movement
  PVector acceleration;

  color chomperColor;
  
  //Constructor
  Chomper(float _xPos, float _yPos, float _size, float _xSpeed, float _ySpeed) {
    
    
    position = new PVector(_xPos, _yPos);
    size = _size;
    
    
    xDirection = floor(random(2)) * 2 - 1;
    yDirection = floor(random(2)) * 2 - 1;
    
    acceleration = new PVector(0,0);
    speed = new PVector(_xSpeed, _ySpeed);
    maxSpeed = max(_xSpeed, _ySpeed);
    maxForce = 0.1;
    
    chomperColor = color(random(80, 110), random(80,120), random(140, 180));
  }
  
  
  
  void exist() { //Creates visualization of Chomper
    pushMatrix();
    translate(position.x, position.y);
    rotate(speed.heading() + PI);
    
    float chompSize = size;
    float halfChomp = chompSize/2;
    
    //fill(97, 100, 162);
    fill(chomperColor);
    noStroke(); //Ear 1
    beginShape();
    vertex(0,0);
    vertex(0,0-halfChomp);
    vertex(0-chompSize,0-halfChomp);
    endShape(CLOSE);
    
    beginShape(); //Ear 2
    vertex(0,0);
    vertex(0,0+halfChomp);
    vertex(0-chompSize,0+halfChomp);
    endShape(CLOSE);
    
    stroke(0);
    beginShape(); //Head
    vertex(0,0-halfChomp);
    vertex(0-chompSize,0);
    vertex(0,0+halfChomp);
    endShape(CLOSE);
    
    rectMode(CENTER); //Body
    rect(0+(halfChomp),0,chompSize,chompSize);
    arc(0+chompSize,0,halfChomp*3,chompSize,PI*3/2,TWO_PI);
    arc(0+chompSize,0,halfChomp*3,chompSize,0,HALF_PI);
    popMatrix();
}



  void move() { //Allows Chomper to move
    speed.add(acceleration);
    speed.limit(maxSpeed);
    position.add(speed);
    acceleration.mult(0);
  }
  
  
  void seek(PVector target) { //Makes the Chomper move and face a direction determined by the PVector given
    PVector desired = PVector.sub(target,position);
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired,speed);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void applyForce(PVector force) { //Applies Newton's 2nd Law, which is that force equals mass times acceleration. Essentially makes movement look more organic.
    acceleration.add(force);
  }
 
}
