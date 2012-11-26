String inputImage;
Pimage img = null;

void setup (){
   inputImage = "School_of_Athens2.jpg";
   img = loadImage(inputImage);
   img.loadPixels();
   background = img;
}

void draw(){
  
}

void stop()
{
  super.stop();
}
