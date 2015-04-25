/*
polyhedrons 3

david cool
http://davidcool.com
http://generactive.net
http://mystic.codes

April, 2015

based on:
Spherical Coordinates Tutorial File
April, 2008
blprnt@blprnt.com
*/

//import processing.opengl.*; // not needed for processing 3 ???
import ddf.minim.*;
import ddf.minim.analysis.*;
import java.util.*;

Minim minim;
AudioPlayer song;
FFT fft;
float eRadius;
float zoom = 0.025;
boolean toggle = true;
ArrayList<Sphere> spheres = new ArrayList<Sphere>();
PFont f;
int r = 200;
int i = 0;

void setup() {
  //code here is executed once, when the app initializes
  size(displayWidth,displayHeight,OPENGL);
  minim = new Minim(this);
  song = minim.loadFile("LAMB In Binary.mp3", 2048);
  fft = new FFT(song.bufferSize(), song.sampleRate());
  smooth();
  lights();
  background(0);
  frameRate(15);
  noCursor();
  //create an instance of the Sphere Class
  for (int i = 0; i < 5; i++) {
    spheres.add(new Sphere());
    spheres.get(i).radius = 200;
  }
  f = createFont("Arial",16,true);
};

void draw() {
  noCursor();
  background(0);
  fft.forward(song.mix);
  pointLight(200, 200, 200, width/2, height/2, 200);
  ambientLight(102, 102, 102);
  spotLight(51, 102, 126, 80, 20, 40, -1, 0, 0, PI/2, 2);
  i = 0;
  for (Sphere s: spheres) {
    pushMatrix();
    s.update(r + int(fft.getBand(i) * 2) );
    s.render();
    popMatrix();
    i++;
  }
  if (toggle) {
    textFont(f,24); 
    fill(255);
    textAlign(CENTER);
    text("Left click to add polyhedrons, right click to destroy!",width/2,height/2 - 25);
    text("Use the mouse wheel or trackpad up/down scroll to zoom.",width/2,height/2 + 25);
  }
};

void mousePressed() {
  if (mouseButton == LEFT) {
    toggle = false;
    spheres.get(0).addSphereItem("SmallHexagrammicHexecontahedron");
    spheres.get(1).addSphereItem("SmallHexagrammicHexecontahedron");
    spheres.get(2).addSphereItem();
    spheres.get(3).addSphereItem();
    spheres.get(4).addSphereItem();
  } else if (mouseButton == RIGHT) {
    spheres.get(0).removeSphereItem();
    spheres.get(1).removeSphereItem();
    spheres.get(2).removeSphereItem();
    spheres.get(3).removeSphereItem();
    spheres.get(4).removeSphereItem();
  }
  song.play();
};

void mouseWheel(MouseEvent e) {
  zoom += map(e.getCount(), -10, 10, 0.001, -0.001);
  zoom = constrain(zoom, 0.00001, 1.5);
};

void keyPressed() {
  if (key == ' ') {
    spheres.clear();
    song.close();
    minim.stop();
    setup();
  }
  if (key == CODED) {
    if (keyCode == LEFT) {
    } 
    if (keyCode == RIGHT) {
    }
    if (keyCode == UP) {
    } 
  }
};