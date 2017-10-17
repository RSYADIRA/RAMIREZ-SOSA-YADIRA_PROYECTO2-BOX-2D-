// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

ArrayList <Star> staries;
int pantalla=0,j=1;
Star[] stars = new Star[800];

int tiempoDesdeInicio=second();
int tiempoTranscurrido=second();



PImage fondo;
PImage photo; 
PImage img;
PImage arbol;
int puntos ;



// Basic example of controlling an object with our own motion (by attaching a MouseJoint)
// Also demonstrates how to know which object was hit

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

// A reference to our box2d world
Box2DProcessing box2d;

// Just a single box this time
criatuta criatuta;

// An ArrayList of particles that will fall on the surface
ArrayList<dulces> dulces;

// The Spring that will attach to the box from the mouse
Spring spring;

// Perlin noise values
float xoff = 0;
float yoff = 1000;


void setup() {
 
  size(600,500);
  
  staries=new ArrayList<Star>();
for (int i=0; i<stars.length; i++){
    stars[i] = new Star();
  }
  
  smooth();


fondo = loadImage("cielo1.jpg");
photo = loadImage("1.2.png");
img = loadImage("2.png");
arbol =loadImage("rama.png");
  // Initialize box2d physics and create the world
  
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // Add a listener to listen for collisions!
  box2d.world.setContactListener(new CustomListener());

  // Make the box
criatuta = new criatuta(width/2,height/2);

  // Make the spring (it doesn't really get initialized until the mouse is clicked)
  spring = new Spring();
  spring.bind(width/2,height/2,criatuta);

  // Create the empty list
 dulces = new ArrayList<dulces>();


}

void draw() {
  
  
   switch(pantalla){ 
   case 0:
 
  
background(#D6FFFE);
  translate(width/2, height/2);
    for (int i=0; i<stars.length; i++){
    stars[i]. update();
    stars[i]. show();
    }
    
   textSize(40);
  fill(#FF557D);
  text("FALL LEAVES",-100,-100);
  
  textSize(15);
  fill(#986EFC);
  text("El otoño ha llegado y es momento de divertirte ayudando",-170,-70);
  
   textSize(15);
  fill(#986EFC);
  text("a Yell a atrapar las hojas que caen del árbol. ",-170,-50);
    
     textSize(15);
  fill(#986EFC);
  text("Tienes 30 segundos para atrapar el mayor número de hojas.",-170,-30); 
  
  
     textSize(15);
  fill(0);
  text("Para atrapar hojas lo único que tienes que hacer es dirijir a Yell,",-210,10); 
  
       textSize(15);
  fill(0);
  text("manteniendo el clic izquierdo presionado y moviendo el mouse ",-210,30); 
  
       textSize(15);
  fill(0);
  text(" en la dirección que desees.",-100,50); 
  
    textSize(17);
  fill(#FA4C83);
  text("¡Da clic en la pantalla y presiona la letra X para comenzar a jugar! ",-260,150);
    
  if(keyPressed){
    if((key=='x')||(key=='X')){
    pantalla=1;
    }  //cierre de if'x'
  }  //cierre de keyPressed
break; 

case 1:

 
  //background(#B9DAE3);
  comienzo();
  
  image( fondo,0, 0);
   fill(#FF76CF);
  rect(100,420,160,30);
  
    fill(#FF76CF);
  rect(460,420,110,30);
  
   tiempoTranscurrido = second()- tiempoDesdeInicio ;
  if (tiempoDesdeInicio > 0){
    
    fill(0);
    text(tiempoTranscurrido,480,430);
    textSize(20);
  }//Cierre de if
  
  if((tiempoTranscurrido==30)||(tiempoTranscurrido==-1)){
  pantalla=2;
  }
 
 
    
  
    fill(0);
  textSize(13);
  text("Tiempo:",415,430);
  
  
 image( arbol,-10, -200);

  if (random(1) < 0.2) {
    float sz = random(4,8);
    dulces.add(new dulces(width/2,-20,sz));
  }


  // We must always step through time!
  box2d.step();

  // Make an x,y coordinate out of perlin noise
 // float x = noise(xoff)*width;
 // float y = noise(yoff)*height;
 // xoff += 0.01;
 // yoff += 0.01;

  // This is tempting but will not work!
  // box.body.setXForm(box2d.screenToWorld(x,y),0);

  // Instead update the spring which pulls the mouse along
  if (mousePressed) {
    spring.update(mouseX,mouseY);
  } else {
    //spring.update(x,y);
  }
  //box.body.setAngularVelocity(0);

  // Look at all particles
  for (int i = dulces.size()-1; i >= 0; i--) {
    dulces p = dulces.get(i);
    p.display();
    // Particles that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (p.done()) {
      dulces.remove(i);
    }
  }

  // Draw the box
  criatuta.display();

  // Draw the spring
  // spring.display();
  
  fill(0);
  textSize(13);
  text("Puntos:",50,430);
 
break;

case 2:

  background(#D7F0EA);
  translate(width/2, height/2);
    for (int i=0; i<stars.length; i++){
    stars[i]. update();
    stars[i]. show();
    }
  
 textSize(40);
 fill(#FF0F68);
 text("¡¡¡FIN DEL JUEGO!!!",-160,-40);

  
  break;
  
 }//cierre SWITCH
  
  
  
  
}


void comienzo(){
  if(keyPressed){
  if((key=='x')||(key=='X')){
    tiempoDesdeInicio = second();
    }//cierre de if
  }//cierre de keypressed
}//cierre comienzo


//-------------------------------------------------------------------------

// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2012
// Box2DProcessing example

// A rectangular box

class criatuta {

  // We need to keep track of a Body and a width and height
  Body body;
  float w;
  float h;

  // Constructor
  criatuta(float x_, float y_) {
    float x = x_;
    float y = y_;
    w = 200;
    h = 200;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h);
    body.setUserData(this);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;

  }
  

  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    //float a = body.getAngle();

    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    //rotate(-a);
    fill(175);
    stroke(0);
    //rect(0,0,200,200);
    image( photo,-100,-30);
    popMatrix();
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_) {
    // Define and create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.1;

    body.createFixture(fd);
    //body.setMassFromShapes();

    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(random(-.5, .5), random(.5, 1)));
    body.setAngularVelocity(random(-.5, .5));
  }
}


//--------------------------------------------------------------------------------------
// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// ContactListener to listen for collisions!

import org.jbox2d.callbacks.ContactImpulse;
import org.jbox2d.callbacks.ContactListener;
import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;

 class CustomListener implements ContactListener {
  CustomListener() {
  }

  // This function is called when a new collision occurs
   void beginContact(Contact cp) {
    // Get both fixtures
    Fixture f1 = cp.getFixtureA();
    Fixture f2 = cp.getFixtureB();
    // Get both bodies
    Body b1 = f1.getBody();
    Body b2 = f2.getBody();
    // Get our objects that reference these bodies
    Object o1 = b1.getUserData();
    Object o2 = b2.getUserData();

puntos= puntos+10;

    // If object 1 is a Box, then object 2 must be a particle
    // Note we are ignoring particle on particle collisions
    if (o1.getClass() == criatuta.class) {
      dulces p = (dulces) o2;
      p.change();
    } 
    // If object 2 is a Box, then object 1 must be a particle
    else if (o2.getClass() == criatuta.class) {
      dulces p = (dulces) o1;
      p.change();
    }
    
  }

   void endContact(Contact contact) {
    // TODO Auto-generated method stub
  }

   void preSolve(Contact contact, Manifold oldManifold) {
    // TODO Auto-generated method stub
  }

   void postSolve(Contact contact, ContactImpulse impulse) {
    // TODO Auto-generated method stub
  }
}

//----------------------------------------------------------------------------
// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// A circular particle

class dulces {

  // We need to keep track of a Body and a radius
  Body body;
  float r;
  
  color col;


  dulces(float x, float y, float r_) {
    r = r_;
    // This function puts the particle in the Box2d world
   makeBody(x, y, r);
    body.setUserData(this);
    //col = color(175);
   
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Change color when hit
  void change() {
    col = color(#D897D0);
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+r*.20) {
      killBody();
      
 
 println("Colision!!");
      fill(0);
      textSize(17);
      text(puntos,110,430);
      return true;
    }
    return false;
  }


  // 
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    //fill(col);
    noStroke();
    strokeWeight(1);
    image(img,-10,-10);
   // ellipse(0, 0, 15, 15);
    // Let's add a line so we can see the rotation
    //line(0, 0, r, 30);
    popMatrix();
  }

  // Here's our function that adds the particle to the Box2D world
  void makeBody(float x, float y, float r) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = .3;

    // Attach fixture to body
    body.createFixture(fd);

    body.setAngularVelocity(random(-10,10));
  }
}

//-----------------------------------------------------------------------
// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// Class to describe the spring joint (displayed as a line)

class Spring {

  // This is the box2d object we need to create
  MouseJoint mouseJoint;

  Spring() {
    // At first it doesn't exist
    mouseJoint = null;
  }

  // If it exists we set its target to the mouse location 
  void update(float x, float y) {
    if (mouseJoint != null) {
      // Always convert to world coordinates!
      Vec2 mouseWorld = box2d.coordPixelsToWorld(x,y);
      mouseJoint.setTarget(mouseWorld);
    }
  }

  void display() {
    if (mouseJoint != null) {
      // We can get the two anchor points
      Vec2 v1 = null;
      mouseJoint.getAnchorA(v1);
      Vec2 v2 = null;
      mouseJoint.getAnchorB(v2);
      // Convert them to screen coordinates
      v1 = box2d.coordWorldToPixels(v1);
      v2 = box2d.coordWorldToPixels(v2);
      // And just draw a line
      stroke(0);
      strokeWeight(1);
      line(v1.x,v1.y,v2.x,v2.y);
    }
  }


  // This is the key function where
  // we attach the spring to an x,y location
  // and the Box object's location
  void bind(float x, float y, criatuta criatuta) {
    // Define the joint
    MouseJointDef md = new MouseJointDef();
    
    // Body A is just a fake ground body for simplicity (there isn't anything at the mouse)
    md.bodyA = box2d.getGroundBody();
    // Body 2 is the box's boxy
    md.bodyB = criatuta.body;
    // Get the mouse location in world coordinates
    Vec2 mp = box2d.coordPixelsToWorld(x,y);
    // And that's the target
    md.target.set(mp);
    // Some stuff about how strong and bouncy the spring should be
    md.maxForce = 1000.0f * criatuta.body.m_mass;
    md.frequencyHz = 1.0f;
    md.dampingRatio = 1f;

    // Wake up body!
    //box.body.wakeUp();

    // Make the joint!
    mouseJoint = (MouseJoint) box2d.world.createJoint(md);
  }

  void destroy() {
    // We can get rid of the joint when the mouse is released
    if (mouseJoint != null) {
      box2d.world.destroyJoint(mouseJoint);
      mouseJoint = null;
    }
  }

}



//---------------------------------------------------------------------
class Star {
float x;
float y;
float z;

Star() {
  x= random(-width, width);
  y=random(-height, height);
  z=random(width);
 }
 void update() {
   z = z-4;
  if(z < 1){
  z = width;
  x= random(-width, width);
  y=random(-height, height);
  }
  
 }
   void show() {
   fill(#F8ADFC);
   noStroke();
 float sx = map(x/z, 0, 1, 0, width);
  float sy = map(y/z, 0, 1, 0, height);
  
  float r = map(z,0,width,16,0);
   ellipse(sx,sy,r,r);
   
  }
}