//This project need the "minim" library , just download it in "Sketch -> import library -> Add library"

import ddf.minim.*;
import ddf.minim.analysis.*;

//minim variables
Minim minim;
AudioInput in;
FFT fft;

//colors
color background = #1A1F18;
color mainColor = #7f8c8d;

void setup()
{
  size(1280, 720);  //comment to set to fullscreen
  //fullscreen()  //uncomment to set to fullscreen
  smooth(3);  //antialiasing
  surface.setResizable(true);
  
  //minim variables setup
  minim = new Minim(this);
  in = minim.getLineIn(); //important! minim select the default recording device as audio , you can't directly record the computer sounds (use stereo mix or a virtual cable set as default recording device)
  fft = new FFT(in.bufferSize(), in.sampleRate());
}

void draw()
{
  background(background, 255);  //set background color to prevent frame ghosting
  translate(width/2, height/2);  //move the visualizer at the center of the screen
  fft.forward(in.mix);  //scan the audio for the current frame

  visualizer();
}


//////////////////////////////////////////////////////////////////////////////////
//VISUALIZER

void visualizer() {
  
  //define the style
  translate(-width/2, 100);
  stroke(mainColor, 255);  //edge color
  strokeWeight(2);  //width of the edges
  fill(mainColor);  //fill color (obvious lol)
  
  //visualizer bars variables
  int size = 40;  //number of bars
  int barHeight = 20;
  int maxBarHeight = 300;
  int barWidth = 20;
  
  //get the frequencies from audio
  int bsize = fft.specSize()-200;  //the number on the right remove the highest frequencies
  int bsep = bsize / size;
  int wsep = width/size;
  
  //display all the bars
  for (int i = 0; i < size ; i++)
  {
    rect(wsep*i,10,barWidth,-min(maxBarHeight,fft.getBand(bsep*i)*barHeight));
  }
  
  translate(width/2, -100);
}

//quit programm when escape is pressed
void keyPressed() {
  if (key==' ')exit();
}