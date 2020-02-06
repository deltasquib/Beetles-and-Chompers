class Bush { //This object is made for easier reference for bugs to check whether they are in a bush or not
  
  float xPos, yPos, size;
  color bushColor;
  
  //Constructor
  Bush(float _xPos, float _yPos, float _size, color _bushColor) {
    xPos = _xPos;
    yPos = _yPos;
    size = _size;
    bushColor = _bushColor;
  }
  
  
  
  void exist() { //Creates visualization for Bush
    fill(bushColor);
    noStroke();
    ellipse(xPos, yPos, size, size);
    ellipse(xPos, yPos, size/4, size/4);
  }
}
