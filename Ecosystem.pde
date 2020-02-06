class Ecosystem {
  
  // instance variables
  float riverSize;
  float riverXPos;
  float riverYPos;
  color waterColor;
  color bushColor;
  int bushNum;
  Bush[] bushes;
  
  //Constructor 
  Ecosystem(float _riverSize, float _riverXPos, float _riverYPos, int _bushNum) { //If you wish to have no river, input a number less than or equal to 0
    
    riverSize = _riverSize;
    
    waterColor = color(129, 140, 255);
    riverXPos = _riverXPos;
    riverYPos = _riverYPos;
    
    bushColor = color(0, random(50, 255), 0, 100);
    bushNum = _bushNum;
    bushes = new Bush[bushNum];
    
    for(int i = 0; i < bushes.length; i++) {
       Bush bush = new Bush(random(100, 900), random(100, 1000), random(50,200), bushColor);
       bushes[i] = bush;
    }
  }
  
  
  void createEcosystem(boolean isRiver) { //Creates water source and bushes
    createWater(isRiver);
    createBush();
  }
  
  
  
  
  void createWater(boolean isRiver) { //Creates river/lake object 
    if(isRiver)
    {
      rectMode(CORNER);
      noStroke();
      fill(waterColor);
      rect(riverXPos,riverYPos,width,riverSize);
      strokeWeight(1);
    }
    else
    {
      noStroke();
      fill(waterColor);
      ellipse(riverXPos,riverYPos,riverSize * 3,riverSize * 3);
      strokeWeight(1);
    }
    
  }
  
  
  void createBush() { //Creates bush objects for beetles to interact with
    
    for(int i = 0; i < bushes.length; i++) {
       bushes[i].exist();
    }
  }
}
