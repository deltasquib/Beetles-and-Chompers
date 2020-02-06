class Beetle {
  
  // instance variables
  int populationCap; //Doesn't actually do pop cap, but used to calculate pop cap in beetles and chompers class
  int xDirection, yDirection;
  
  float xPos;
  float yPos;
  float size;
  float invisibility;
  float invisibleLow; //The lowest level of invisibility a.k.a. opacity of the bug
  float xSpeed, ySpeed, xSpeed2, ySpeed2;
  float swimAbility; //Determines color of beetles legs, which are redder the worse it's swimming is
  float swimPenalty; //Determines beetle speed in water. Lower stat is better swim ability
  float speedPenalty; //determined by size of beetle, bigger beetle = slower beetle
  float beetleR, beetleG, beetleB;
  color beetleColor;
  color legColor;
  boolean isSafe;
  boolean inWater;
  boolean inBush;
  
  //Constructor 
  Beetle(float _xPos,float _yPos, float _size,float _swimAbility,float _invisibility) {
    populationCap = 0;
    
    xPos = _xPos;
    yPos = _yPos;
    size = _size;
    speedPenalty = size/10 - 1;
    swimAbility = _swimAbility;
    swimPenalty = map(swimAbility,0,255,0,1.5);
    
    xDirection = floor(random(2)) * 2 - 1;
    yDirection = floor(random(2)) * 2 - 1;
    
    xSpeed = random(3,6) * xDirection;
    ySpeed = random(3,6) * yDirection;
    
    
    invisibility = _invisibility;
    
    beetleR = random(0,100);
    beetleG = map(invisibility,50,255,255,0);
    beetleB = map(invisibility,50,255,0,255);
    beetleColor = color(beetleR, beetleG, beetleB, invisibility);
    
    isSafe = true;
    inWater = false;
    inBush = false;
  }
  
  
  Boolean reproduce() { //Returns a boolean variable that will determine a beetle's reproduction
    int reproduceTimer = 500;
    
    if(frameCount >= reproduceTimer){
        return true;
    }
    return false;
  }
  
  
  void checkWater(int waterLeft, int waterTop, int waterSize, boolean isRiver) { //Checks whether the bug is in water
    if(isRiver) {
      if(xPos >= waterLeft && xPos <= waterLeft + width) {
        if(yPos >= waterTop - (size/2) && yPos <= waterTop + waterSize - (size/2))
          inWater = true;
        else
        inWater = false;
      }
    }
    else if (!isRiver) //Creates Lake instead
    {
      if(dist(xPos, yPos, waterLeft, waterTop) < size)
        inWater = true;
      else
        inWater = false;
    }
    else 
      inWater = false;
  }
  
  
  
  
  void move() { // implements beetle movement
      if(!isSafe && inBush) {
        xPos = xPos + 0;
        yPos = yPos + 0;
      }
      else if(inWater){ //Bugs move slower in water
        xPos += (xSpeed + (swimPenalty * xDirection * -1) - (speedPenalty * xDirection));
        yPos += (ySpeed + (swimPenalty * yDirection * -1) - (speedPenalty * yDirection));
      }
      else if(!inWater) { //Bug movement out of water
        xPos += xSpeed - (speedPenalty * xDirection);
        yPos += ySpeed - (speedPenalty * yDirection);
      }
      
  }
  
  
  
  void checkEdges() { //Allows bugs to remain within the confines of the canvas
    // bounce off the left and right walls of the window
    if (xPos <= (size/3) || xPos >= width - (size/3)) {
      xDirection *= -1;
      xSpeed *= -1;
    }

    // bounce off the top and bottom walls of the window
    if (yPos <= (size/3) || yPos >= height - (size/3)) {
      yDirection *= -1;
      ySpeed *= -1;
    }
  }
  
  
  
  void exist() { //Creates visualization of beetle
    fill(beetleColor);
    
    float beetleSize = size;
    float halfBeetle = beetleSize/2;
    
    
    stroke(swimAbility,0,0);
    strokeWeight(5);
    line(xPos+(halfBeetle*3),yPos+beetleSize,xPos-(halfBeetle), yPos-beetleSize); //Creates beetle legs
    line(xPos+(halfBeetle),yPos-(beetleSize),xPos+(halfBeetle), yPos+beetleSize);
    line(xPos-halfBeetle,yPos+beetleSize,xPos+(halfBeetle*3), yPos-beetleSize);
    noStroke();
     
    arc(xPos,yPos,halfBeetle*3,beetleSize,HALF_PI,PI*3/2); //Creates beetle body
    rectMode(CENTER);
    rect(xPos+(halfBeetle),yPos,beetleSize,beetleSize);
    arc(xPos+beetleSize,yPos,halfBeetle*3,beetleSize,PI*3/2,TWO_PI);
    arc(xPos+beetleSize,yPos,halfBeetle*3,beetleSize,0,HALF_PI);
    rectMode(CORNER);
 }
 
 
 
 
  void mutate() { //determines mutation of a beetle when it is spawned.
    int rng = floor(random(100));
    
    if(rng > 95) { // Super low chance for a horrendous complete mutation
      size = random(20,30);
      speedPenalty = size/10 - 1;
      swimAbility = random(255);
      swimPenalty = map(swimAbility,0,255,0,2);
      
      xDirection = floor(random(2)) * 2 - 1;
      yDirection = floor(random(2)) * 2 - 1;
      xSpeed = (random(3,6) - speedPenalty) * xDirection;
      ySpeed = (random(3,6) - speedPenalty) * yDirection;
      
      invisibility = random(50, 255);
      
      beetleR = random(255);
      beetleG = random(255);
      beetleB = random(255);
      beetleColor = color(beetleR, beetleG, beetleB, invisibility);
    }
    
    
    if(rng <= 95 && rng > 90) { // Decently low chance for a change in color and visibility
      
      invisibility = invisibility + random(20) * yDirection;
      
      beetleR = beetleR + random(20) * xDirection;
      beetleG = beetleG + random(20) * yDirection;
      beetleB = beetleB + random(20) * xDirection;
      beetleColor = color(beetleR, beetleG, beetleB, invisibility);
    }
    
    if(rng <= 90 && rng > 85) { //Pretty low chance for a change in swimming ability
      swimAbility = random(255);
      swimPenalty = map(swimAbility,0,255,0,2);
    }
    
    
    if(rng <= 85 && rng > 80) { //Okay chance for beetle to have slightly altered size
      size = size + random(2) * xDirection;
      speedPenalty = size/10 - 1;
    }
  }
}
