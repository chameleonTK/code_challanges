
int radious = 100;
int padding = 10;
int margin = 10;

Circle[] axisX;
Circle[] axisY;
Curve[][] curves;

float speed = 0.01;
float theta = 0;
PGraphics pg;
void setup() {
  size(1050, 1050);
  
  axisX = new Circle[(int)(width/radious)];
  axisY = new Circle[(int)(width/radious)];
  curves = new Curve[axisY.length][axisX.length];
  
  int r = radious - padding;
  for (int i=0; i < axisX.length; i++) {
    float itsColor = i*360/axisX.length;
    
    float cx = i*radious + r/2;
    float cy = r/2 + margin;
    axisX[i] = new Circle(itsColor, cx + margin, cy, r, i);
    axisY[i] = new Circle(itsColor, cy, cx + margin, r, i);
  }
  
  for (int j=0; j < axisY.length; j++) {
    for (int i=0; i < axisX.length; i++) {
      float colorX = i*360/axisX.length;
      float colorY = j*360/axisY.length;
      curves[j][i] = new Curve((colorX+colorY)/2);
    }
  }
  
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(0);
  pg.endDraw();
  
}

void draw() {
  colorMode(HSB);
  background(0);
  stroke(0);
  strokeWeight(2);
 
 image(pg, 0, 0);
  for (int i=1; i<axisX.length; i++) {
    axisX[i].draw(theta);
    axisX[i].drawVerticalLine(theta);
  }
  
  for (int j=1; j<axisY.length; j++) {
    axisY[j].draw(theta);
    axisY[j].drawHorinzontalLine(theta);
  }
  
  pg.beginDraw();
  pg.stroke(255);
  for (int j=0; j < axisY.length; j++) {
    for (int i=0; i < axisX.length; i++) {
      curves[j][i].addPoint(axisX[i].px, axisY[j].py);
      curves[j][i].draw(pg);
    }
  }
  
  pg.endDraw();
  
  theta += speed;
  if (theta >= 2*PI || theta<0) {
    //theta = 0;
    speed *= -1;
    
    //for (int j=0; j < axisY.length; j++) {
    //  for (int i=0; i < axisX.length; i++) {
    //    curves[j][i].reset();
    //  }
    //}
    pg.beginDraw();
    pg.background(0);
    pg.endDraw();
  }
}
