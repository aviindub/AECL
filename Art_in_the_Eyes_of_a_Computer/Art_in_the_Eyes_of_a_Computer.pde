String inputImage;
PImage img = null;
int numSpots = 20000;
Spot[] Spots = new Spot[numSpots];

void setup (){
   frame.setLocation(screen.width/4, screen.height/4);
   inputImage = "School_of_Athens2.jpg";
   img = loadImage(inputImage);
   img.loadPixels();
   frameRate(15);
   size(img.width, img.height);
   //background(img);
   image(img, 0, 0);
   int row = 0;
   int col = 1;
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
  for (int i = 0; i < numSpots; i++) {
    Spots[i].move();
    Spots[i].showPoint();
  }
}

void stop()
{
  super.stop();
}
