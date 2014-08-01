import hypermedia.net.*;  // UDP Library 
UDP udp;
PImage[] images;
PImage frame;
boolean drawImages = false;

final int xSize = 120;
final int ySize = 65;

void setup() {
  size(xSize * 4, ySize * 4, P2D);
  background(0);
  images = new PImage [6];
  for (int i = 0; i < images.length; i++) {
    images[i] = createImage(20, 20, RGB);
    images[i].loadPixels();
  }

  frame = createImage(xSize, ySize, RGB);
  frame.loadPixels();

  setupPixelMap();

  udp = new UDP( this, 6000 );
  udp.listen( true );

  //imageMode(CENTER);
}

int signedByteToInt(byte b) {
  return b & 0xFF;
}

void draw() {
  if (drawImages) {
    for (int i = 0; i < frame.pixels.length; i++) {
      int x = i % xSize;
      int y = i / xSize;
      int imageIndex = pMap[x][y].i;
      if (imageIndex >= 0) {
        frame.pixels[i] = images[imageIndex].pixels[pMap[x][y].pixelIndex()];
      } else {
        frame.pixels[i] = color(0);
      }
    }
    frame.updatePixels();
    g.copy(frame, 0, 0, frame.width, frame.height, 0, 0, width, height);
    drawImages = false;
  }
}


void receive( byte[] data, String ip, int port ) {  // <-- extended handler
  if (data.length != 1202) {
    println("data packet size error!!! " + data.length);
    return;
  }
  int index = (int) data[0];
  if (data[1] == 0)
    drawImages = false;
  else
    drawImages = true;

  data = subset(data, 2); //, data.length);
  int pixelIndex = 0;

  for (int i = 0; i < data.length; i += 3) {
    int r = signedByteToInt(data[i]);
    int g = signedByteToInt(data[i+1]);
    int b = signedByteToInt(data[i+2]);
    images[index].pixels[pixelIndex] = color(r, g, b);
    pixelIndex++;
  }
  images[index].updatePixels();
}

