class Screen {
  int index;
  int pixelWidth = 20, pixelHeight = 20;
  float blockSize;
  float widthOffset;
  float pixelSpacing;
  float pixelSize;
  PImage pixelImage;
  boolean isTop;

  Screen(int index, boolean isTop) {
    this.index = index;
    this.isTop = isTop;

    blockSize = 400 / pixelWidth;
    pixelSpacing = blockSize / 2;
    pixelSize = blockSize - pixelSpacing;
    widthOffset = pixelSpacing / 2;
    
    //pixelImage = createImage(pixelWidth, pixelHeight, RGB);
    //pixelImage.loadPixels();
  }

  void draw() {
    noStroke();
    rectMode(CENTER);
    pushMatrix();

    if (isTop) {
      translate(width / 2, blockSize * 1.25);
      rotate(radians(45));
    } else {
      translate(100, height / 2);
    }
    
    if (pixelImage != null) pixelImage.loadPixels();
    for (int j = 0; j < pixelHeight; j++) {
      for (int i = 0; i < pixelWidth; i++) {
        if (pixelImage != null) {
          fill(pixelImage.pixels[j*pixelHeight + i]);
        } else {
          if (isTop)
            fill(255, 0, 0); // test
          else
            fill(0, 64, 255);
        }
        float x = widthOffset + (i*pixelSize); //+ (pixelSize / 2);
        float y = widthOffset + (j*pixelSize); //+ (pixelSize / 2);

        pushMatrix();
        translate(x, y);
        //if (isTop) rotate(radians(-22.5));
        ellipse(x, y, pixelSize, pixelSize);
        popMatrix();
      }
    }
    popMatrix();
    rectMode(CORNER);
  }

  void draw(PImage image) {
    pixelImage = image;
    image.loadPixels();
    draw();
  }
}

