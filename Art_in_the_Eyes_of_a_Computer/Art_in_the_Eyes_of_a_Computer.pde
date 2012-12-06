//openCL imports
import javax.media.opengl.*;
import processing.opengl.*;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.nio.IntBuffer;
import com.sun.opengl.util.BufferUtil;

import com.nativelibs4java.opencl.CLMem;
import com.nativelibs4java.opencl.CLBuildException;
import msa.opencl.*;

OpenCL openCL;
OpenCLBuffer[] clBuf;
FloatBuffer xBuf;
FloatBuffer yBuf;
FloatBuffer xDirectionBuf;
FloatBuffer yDirectionBuf;
ByteBuffer xResultBuf;
ByteBuffer yResultBuf;
OpenCLKernel kernelUpdateSpot;

//regular imports
String inputImage;
PImage img = null;
int numSpots;
Spot[] Spots;

void setup () {
  //inputImage = "School_of_Athens.jpg";
  //inputImage = "Us.jpg";
  //inputImage = "Hope.jpeg";
  inputImage = "Rocky.jpg";
  colorMode(HSB, 255);
  img = loadImage(inputImage);
  img.loadPixels();
  numSpots = (img.width*img.height)/10;  
  frameRate(1);
  size(img.width, img.height);  
  //background(img);
  image(img, 0, 0);
  int row = 0;
  int col = 1;
  float space = sqrt(numSpots);
  numSpots = (int)(space*space);
  Spots = new Spot[numSpots];
  int perRow = (int)space;
  for (int i = 0; i < numSpots; i++) {
    Spots[i] = new Spot(get((int)(img.width/space * col), (int)(img.height/space * row)), 
    (int)(img.width/space * col), (int)(img.height/space * row));
    col++;
    if ((col - 1) % perRow == 0) {
      row++;
      col = 1;
    }
  }


  //openCL setup
  System.out.println( "Initialize CL" );
  openCL = OpenCL.getSingleton();
  OpenCL.getSingleton().init( OpenCL.GPU, 0 );
  OpenCLProgram program = OpenCL.getSingleton().loadProgramFromFile( dataPath("TestProgram.cl"), false );
  if ( program == null ) System.exit( 0 );

  kernelUpdateSpot = null;
  try {
    System.out.println( "1- loadKernel" );
    kernelUpdateSpot = program.loadKernel( "updateSpot" );
  } 
  catch (CLBuildException e) {
    e.printStackTrace();
  }
  println("initialize buffers");
  xBuf = openCL.createFloatBuffer(numSpots);
  yBuf = openCL.createFloatBuffer(numSpots);
  xDirectionBuf = openCL.createFloatBuffer(numSpots);
  yDirectionBuf = openCL.createFloatBuffer(numSpots);
  xResultBuf = openCL.createByteBuffer(numSpots);
  yResultBuf = openCL.createByteBuffer(numSpots);
  clBuf = new OpenCLBuffer[6];
  
  
  background(255);
}

/*
    float[] data = { (float) x, 
 (float) y,  
 (float) xdirection,
 (float) ydirection 
 };
 */

void draw() {
  frame.setLocation((screen.width - img.width)/2, 
  (screen.height - img.height)/2);

  //put all data in to buffers for openCL
  println("populate buffers");
  for (int i = 0; i < numSpots; i++) {
    //Spots[i].move();
    //Spots[i].showPoint();
    float[] spotData = Spots[i].getMoveData();    
    xBuf.put(spotData[0]);
    yBuf.put(spotData[1]);
    xDirectionBuf.put(spotData[2]);
    yDirectionBuf.put(spotData[3]);
  }
  xBuf.rewind();
  yBuf.rewind();
  xDirectionBuf.rewind();
  yDirectionBuf.rewind();
  
  println("populate CL buffers");
  for (int i = 0; i < 6; i++) {
    clBuf[i] = new OpenCLBuffer();
  }
  clBuf[0].initBuffer( numSpots * BufferUtil.SIZEOF_FLOAT, CLMem.Usage.InputOutput, xBuf );
  clBuf[1].initBuffer( numSpots * BufferUtil.SIZEOF_FLOAT, CLMem.Usage.InputOutput, yBuf );
  clBuf[2].initBuffer( numSpots * BufferUtil.SIZEOF_FLOAT, CLMem.Usage.InputOutput, xDirectionBuf );
  clBuf[3].initBuffer( numSpots * BufferUtil.SIZEOF_FLOAT, CLMem.Usage.InputOutput, yDirectionBuf );
  clBuf[4].initBuffer( numSpots * BufferUtil.SIZEOF_FLOAT, CLMem.Usage.InputOutput, null );
  clBuf[5].initBuffer( numSpots * BufferUtil.SIZEOF_FLOAT, CLMem.Usage.InputOutput, null );

  //attach the buffers to the kernel
  println("attach the buffers to the kernel");
  for (int i = 0; i < 6; i++) {
    kernelUpdateSpot.setArg(i, clBuf[i].getCLMem());
  }
  kernelUpdateSpot.setArg(6, (float) 1);
  kernelUpdateSpot.setArg(7, (float) 1);
  OpenCL.getSingleton().finish();

  //get results
  print("get back the results");
  clBuf[4].read( xResultBuf, 0, numSpots * BufferUtil.SIZEOF_FLOAT, false );
  clBuf[5].read( yResultBuf, 0, numSpots * BufferUtil.SIZEOF_FLOAT, false );

  for (int i = 0; i < numSpots; i++) {
    Spots[i].setMoveData((float) xResultBuf.get(i),(float) yResultBuf.get(i));
  }

  openCL.finish();
}

void stop()
{
  super.stop();
}

float getLocationHue(int x, int y) {
  return hue(img.get(x, y));
}

float getLocationSaturation(int x, int y) {
  return saturation(img.get(x, y));
}

float getLocationBrightness(int x, int y) {
  return brightness(img.get(x, y));
}

