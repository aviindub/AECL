String inputImage;
PImage img = null;
int numSpots;
Spot[] Spots = new Spot[numSpots];

void setup (){
   //inputImage = "School_of_Athens.jpg";
   //inputImage = "Us.jpg";
   //inputImage = "Hope.jpeg";
   inputImage = "Rocky.jpg";
   colorMode(HSB, 255);
   img = loadImage(inputImage);
   img.loadPixels();   
   frameRate(1);
   size(img.width, img.height);  
   //background(img);
   image(img, 0, 0);
   int row = 0;
   int col = 1;
   numSpots = (img.width*img.height)/10;
   float space = sqrt(numSpots);
   numSpots = (int)(space*space);
   int perRow = (int)space;
   for(int i = 0; i < numSpots; i++){
      Spots[i] = new Spot(get((int)(img.width/space * col), (int)(img.height/space * row)), 
                         (int)(img.width/space * col), (int)(img.height/space * row));
      col++;
      if((col - 1) % perRow == 0){
        row++;
        col = 1;
      }
   }
   background(255);   
}

void draw(){
  frame.setLocation((screen.width - img.width)/2,
                    (screen.height - img.height)/2);
  for (int i = 0; i < numSpots; i++) {
    Spots[i].move();
    Spots[i].showPoint();
  }
}

void stop()
{
  super.stop();
}

float getLocationHue(int x, int y){
  return hue(img.get(x, y));  
}

float getLocationSaturation(int x, int y){
  return saturation(img.get(x, y));  
}

float getLocationBrightness(int x, int y){
  return brightness(img.get(x, y));  
}
