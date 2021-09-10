import ddf.minim.*;

int num = 9;
float[] xpos;
float[] ypos;
float[] xspd;
float[] yspd;
float margin=100;

float value;

Minim minim;
AudioPlayer player;

void setup()
{
  size(720, 720, P3D);
  colorMode(HSB);
  
  minim = new Minim(this);
  player = minim.loadFile("xxx.mp3"); //sound file
  
  
  
  xpos = new float[num];
  ypos = new float[num];
  xspd = new float[num];
  yspd = new float[num];
  for(int i = 0; i<num; i++){
    xpos[i] = random(margin, width-margin);
    ypos[i] = random(margin, height-margin);
    xspd[i] = random(-3, 3);
    yspd[i] = random(-2, 2);
  }  
}

void draw()
{
  background(0);
  stroke(255);

  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    //float x1 = map( i, 0, player.bufferSize(), 0, width );
    //float x2 = map( i+1, 0, player.bufferSize(), 0, width );
    value = player.mix.get(i);
    //println(value);

  }
  


  for(int i = 0; i<num; i++){    
    xpos[i]+=(abs(value*50)*xspd[i]);
    ypos[i]+=(abs(value*50)*yspd[i]);
    if(xpos[i]<margin || xpos[i]>width-margin){
      xspd[i]*=-1;
    }
    if(ypos[i]<margin || ypos[i]>height-margin){
      yspd[i]*=-1;
    }
  }
  
  loadPixels();
  for(int i = 0; i<pixels.length; i++){
    int x = i % width;
    int y = i / width;
    
    float colorSelect = 0; //customise
    
    for(int j = 0; j<num; j++){
      float dist = dist(x, y, xpos[j], ypos[j]);
      colorSelect+=sqrt(dist)-2000/dist; //customise
      //println(colorSelect);
      
      
    }
    pixels[i] = color(colorSelect, 205, 255);
  }
  updatePixels();    
    
}

void keyPressed()
{
  if ( player.isPlaying() )
  {
    player.pause();
  }

  else if ( player.position() == player.length() )
  {
    player.rewind();
    player.play();
  }
  else
  {
    player.play();
  }
}
