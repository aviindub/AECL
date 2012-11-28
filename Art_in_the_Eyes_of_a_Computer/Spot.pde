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
  float initHue;
  
  Spot(color initColor, int xloc, int yloc){
    clr = initColor;
    initHue = hue(clr);
    x = xloc; 
    y = yloc;
    secHighBound = 0;
    secLowBound = height;
    secLeftBound = 0;
    secRightBound = width;    
  }

  void showPoint() {
    strokeWeight(2);
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
    int curHue = (int)getLocationHue(x,y);
    rand = (int)random(2);
    if (y < secHighBound || y > secLowBound || abs(curHue-initHue) > 10) 
      ydirection *= -1;
    else if (rand % 2 == 1 && y >= secHighBound && y < secLowBound)
      ydirection *= -1;
    rand = (int)random(2);
    if (x > secRightBound || x < secLeftBound || abs(curHue-initHue) > 10)
      xdirection *= -1;
    else if (rand % 2 == 1 && x <= secRightBound && x >= secLeftBound) 
      xdirection *= -1;
    y += (yspeed * ydirection);
    x += (xspeed * xdirection);
  }
}


