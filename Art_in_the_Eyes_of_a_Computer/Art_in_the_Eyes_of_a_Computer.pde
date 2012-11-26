String inputImage;
PImage img = null;
int numSpots = 1000;
Spot[] Spots = new Spot[numSpots];

void setup (){
   inputImage = "School_of_Athens2.jpg";
   img = loadImage(inputImage);
   img.loadPixels();
   size(img.width, img.height);
   frame.setLocation(screen.width/4, screen.height/4);
   background(img);
   int row = 0;
   int col = 1;
   int space = (int)sqrt(numSpots);
   numSpots = space*space;
   for(int i = 0; i < numSpots; i++){
      Spots[i] = new Spot(get(img.width/space * col, img.height/space * row), 
                         img.width/space * col, img.height/space * row);
      col++;
      System.out.println((0) % space);
      if((col - 1) % space == 0){
        row++;
        col = 1;
      }
      System.out.println(Spots[i].getX() + " " + Spots[i].getY() + " " + col);
    }   
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
