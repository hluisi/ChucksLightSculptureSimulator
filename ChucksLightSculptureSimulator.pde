import hypermedia.net.*;  // UDP Library 
Screen screen0, screen1;
UDP udp;
PImage[] images; //, image1;
boolean showImages = false;

//int signedByteToInt(byte b)

void setup() {
  size(600, 800, P2D);
  background(0);
  screen0 = new Screen(0, true);
  screen1 = new Screen(1, false);
  images = new PImage [2];
  images[0] = createImage(screen0.pixelWidth, screen0.pixelHeight, RGB);
  images[1] = createImage(screen1.pixelWidth, screen1.pixelHeight, RGB);
  images[0].loadPixels();
  images[1].loadPixels();
  udp = new UDP( this, 6000 );
  udp.listen( true );
  //println( (byte) 129 );
}

int signedByteToInt(byte b) {
  return b & 0xFF;
}

void draw() {
  screen1.draw();
  screen0.draw();
}

void receive( byte[] data, String ip, int port ) {  // <-- extended handler
  if (data.length != 1202) {
    println("data packet size error!!! " + data.length);
    return;
  }
  int index = (int) data[0];
  //println(index);
  if (data[1] == 0)
    showImages = false;
  else
    showImages = true;

  data = subset(data, 2); //, data.length);
  int pixelIndex = 0;

  for (int i = 0; i < data.length; i += 3) {
    int r = signedByteToInt(data[i]);
    int g = signedByteToInt(data[i+1]);
    int b = signedByteToInt(data[i+2]);
    images[index].pixels[pixelIndex] = color(r, g, b);
    pixelIndex++;
    //println("R: " + r + " G: " + g + " B: " + b);
  }
  images[index].updatePixels();

  if (showImages) {
    screen0.pixelImage = images[0];
    screen1.pixelImage = images[1]; 
    showImages = false;
  }
  //println( "receive: \""+message+"\" from "+ip+" on port "+port );
}

