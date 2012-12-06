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
  float initBrightness;
  float initSaturation;
  float curHue;
  float curBrightness;
  float curSaturation;
  
  Spot(color initColor, int xloc, int yloc){
    clr = initColor;
    initHue = hue(clr);
    initBrightness = brightness(clr);
    initSaturation = saturation(clr);
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
  
 float[] getMoveData() {
    curHue = getLocationHue(x,y);
    curBrightness = getLocationBrightness(x,y);
    curSaturation = getLocationSaturation(x,y);    
    rand = (int)random(2);
    if (y < secHighBound || y > secLowBound ||
        abs(curHue-initHue) > 10 ||
        abs(curBrightness-initBrightness) > 50 ||
        abs(curSaturation-initSaturation) > 50) 
      ydirection *= -1;
    else if (rand % 2 == 1 && y >= secHighBound && y < secLowBound)
      ydirection *= -1;
    rand = (int)random(2);
    if (x > secRightBound || x < secLeftBound ||     
        abs(curHue-initHue) > 10 ||
        abs(curBrightness-initBrightness) > 50 ||
        abs(curSaturation-initSaturation) > 50)
      xdirection *= -1;
    else if (rand % 2 == 1 && x <= secRightBound && x >= secLeftBound) 
      xdirection *= -1;
    //y += (yspeed * ydirection);
    //x += (xspeed * xdirection);
    float[] data = { (float) x, 
                     (float) y, 
                     (float) xdirection,
                     (float) ydirection 
                  };
    return data;
  }

  void setMoveData(float newX, float newY) {
    x = (int) newX;
    y = (int) newY;
  }
  
}
