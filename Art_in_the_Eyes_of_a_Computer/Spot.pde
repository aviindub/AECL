class Spot {
  int x;
  int y;	
  float xspeed = 1;
  float yspeed = 1;
  int xdirection = 1; 	
  int ydirection = 1; 	
  int rand = 0;
  int secHighBound;
  int secLowBound;
  int secLeftBound;
  int secRightBound;
  color clr;
  
  Spot(color initColor, int xloc, int yloc){
    clr = initColor;
    x = xloc; 
    y = yloc;
    secHighBound = 0;
    secLowBound = height;
    secLeftBound = 0;
    secRightBound = width;    
  }

  Spot(int upper, int lower, int side1, int side2, color colorOf, int xloc, int yloc) {
    x = xloc;
    y = yloc;
    secHighBound = upper;
    secLowBound = lower;
    secLeftBound = side1;
    secRightBound = side2;
    clr = colorOf;
  }

  void showPoint() {
    strokeWeight(5);
    stroke(clr);
    point(x, y);
  }
  
  int getX(){
    return x;
  }
  
  int getY(){
    return y;
  }
  
  void move() {
    rand = (int)random(2);
    if (rand % 2 == 1 && y >= secHighBound && y < secLowBound)
      ydirection *= -1;
    if (y > (secHighBound) || y < secLowBound) 
      ydirection *= -1;
    rand = (int)random(2);
    if (rand % 2 == 1 && x <= secRightBound && x >= secLeftBound) 
      xdirection *= -1;
    if (x > secRightBound || x < secLeftBound) 
      xdirection *= -1;
    y += (yspeed * ydirection);
    x += (xspeed * xdirection);
  }
}


