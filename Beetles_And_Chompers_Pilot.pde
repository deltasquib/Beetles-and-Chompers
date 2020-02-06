import processing.sound.*;



//Initialize how many creatures there are and the ecosystem as well.
Beetle[] beetles = new Beetle[10];
Chomper[] chompers = new Chomper[3];
Ecosystem world = new Ecosystem(100, 0, random(600), 20); //Determines water size and bush number

//Drops in sound
SoundFile lostForest;


color groundColor = color(255, 218, 162);
color waterColor = color(129, 140, 255);
color bushColor = color(62, 245, 106);
int popCap = 50;                //This variable determines number cap of bugs for reproducing, this doesn't effect manual spawning
boolean isRiver = true;

void setup() {
  textAlign(CENTER);
  //size(1900,1000);
  fullScreen();
  
  background(255); //Loading screen visuals
  textSize(100);
  fill(0);
  text("Loading Beetles and Chompers...", width/2, height/2);
  
  lostForest = new SoundFile(this, "Lost Woods 8 Bit.mp3");
  
  
  for(int i = 0; i < beetles.length; i++)
  {
    Beetle beetle = new Beetle(random(25,width-25),random(25,height-25), random(20,30), random(255), random(50, 255)); //Beetles takes x, y, xSpeed, ySpeed, size, swimAbility, and invisibility
    beetles[i] = beetle;
    beetles[i].exist(); 
  }
  
  
  for(int k = 0; k < chompers.length; k++)
  {
    Chomper chomper = new Chomper(random(50,width-50), random(50, height-50), random(50,70), random(2,7), random(2,7));
    chompers[k] = chomper;
    chompers[k].exist(); 
  }
  
  lostForest.loop();
}




void draw() {
  background(groundColor);
  
  removeEatenBugs();
  updateScene();
  
  //Creates the beetle count at the top right
  textAlign(BASELINE);
  String howManyBeetles = "Beetle Count:" + beetles.length;  
  textSize(40);
  fill(0);
  text(howManyBeetles, width*5/6, 50);
  
  
  
  checkBeetlesInBush();
  checkForDanger();
  chompersHuntBeetles();
}



void updateScene() { //Updates scene
  
  world.createEcosystem(isRiver); //Creates ecosystem
  //println(frameCount);
  
  for(int i = 0; i < beetles.length; i++) { //Updates beetles
    beetles[i].exist();
    beetles[i].move();
    beetles[i].checkEdges();
    beetles[i].checkWater(floor(world.riverXPos),floor(world.riverYPos),100,isRiver);
    
    if(beetles[i].reproduce()) //Beetle reproduction code
    {
      if(beetles.length < beetles[i].populationCap) {
          Beetle beetle = new Beetle(beetles[i].xPos, beetles[i].yPos, beetles[i].size, beetles[i].swimAbility, beetles[i].invisibility);
          beetle.xSpeed = random(3,6) * beetle.xDirection;
          beetle.ySpeed = random(3,6) * beetle.yDirection;
          beetle.mutate();
          beetles = (Beetle[])append(beetles,beetle);
      }
    }
    if(frameCount > 500) { //Checks for rebirth time.
      frameCount = 0;
    }
    if(beetles[i].populationCap != popCap  ){ //Reproduces with respect to population cap
      beetles[i].populationCap ++;
    }
  }  
  
  
  for(int h = 0; h < chompers.length; h++) //Updates chompers
  {
    chompers[h].exist();
    chompers[h].move();
  }
}


void removeEatenBugs() { //Removes a beetle if a chomper is on top of the beetle and the beetle is not camoflaged in a bush
  for (int b = 0; b < chompers.length; b++) {
    for(int z = 0; z < beetles.length; z++) {
      if(dist(beetles[z].xPos, beetles[z].yPos, chompers[b].position.x, chompers[b].position.y) < 50 && !beetles[z].inBush) {
        beetles = removeBeetle(beetles, z);
      }
    }
  }
}


void chompersHuntBeetles() { //Targeting system for Chompers to Beetles
  for (int b = 0; b < chompers.length; b++) {
    if(chompers.length > beetles.length) {
      chompers[b].seek(new PVector(beetles[0].xPos, beetles[0].yPos));
    }
    else {
      chompers[b].seek(new PVector(beetles[b].xPos, beetles[b].yPos));
    }
  }
}



Beetle[] removeBeetle(Beetle[] array, int index) { //Removes beetles
  Beetle[] leftHandSide = (Beetle[])subset(array, 0, index);
  Beetle[] rightHandSide = (Beetle[])subset(array, index + 1);
  return (Beetle[])concat(leftHandSide, rightHandSide);
}





void mousePressed() { //Adds a beetle every click
  Beetle beetle = new Beetle(random(25,width-25),random(25,height-25), random(20,30), random(255), random(50, 255));
  beetles = (Beetle[])append(beetles,beetle);
}




void checkBeetlesInBush() { //Detects if beetle is in a bush
    for(Bush c : world.bushes) {
      for(Beetle b : beetles) {
        if(dist(b.xPos, b.yPos, c.xPos, c.yPos) < c.size) {
          b.inBush = true;  
        }
        else {
          b.inBush = false;  
        }
      }
    }
}


void checkForDanger() { //Checks if a chomper is nearby
  for(Chomper c : chompers) {
    for(Beetle b : beetles) {
      if(dist(b.xPos, b.yPos, c.position.x, c.position.y) <= 200){
        b.isSafe = false; 
      }   
      else {
        b.isSafe = true;
      }
    }
  }
}
