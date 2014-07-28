import hypermedia.net.*;  // UDP Library 
Screen screen0, screen1;

void setup() {
  size(600, 800, P2D);
  background(0);
  screen0 = new Screen(0, true);
  screen1 = new Screen(1, false);
}

void draw() {
  screen1.draw();
  screen0.draw();
  
}



