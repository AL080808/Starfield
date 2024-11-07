// Array to store all particles
Particle[] particles;

// Number of particles in the starfield
int numParticles = 200;

void setup() {
  size(800, 600);
  particles = new Particle[numParticles];

  // Initialize particles array with Particle objects and one OddballParticle
  for (int i = 0; i < particles.length; i++) {
    if (i == 0) {
      particles[i] = new OddballParticle(width / 2, height / 2, random(TWO_PI), random(0.5, 2));
    } else {
      particles[i] = new RegularParticle(width / 2, height / 2, random(TWO_PI), random(0.5, 2));
    }
  }
}

void draw() {
  background(0, 0, 20); // Dark blue-black for space background

  // Move and show all particles
  for (int i = 0; i < particles.length; i++) {
    particles[i].move();
    particles[i].show();
    particles[i].checkEdges(); // Keep particle on screen by resetting it if it moves off-screen
  }
}

// Particle interface
interface Particle {
  void move();
  void show();
  void checkEdges();
}

// RegularParticle class implementing Particle interface
class RegularParticle implements Particle {
  double x, y, speed, angle;
  color particleColor;
  float size;

  RegularParticle(double startX, double startY, double ang, double spd) {
    x = startX;
    y = startY;
    angle = ang;
    speed = spd;
    particleColor = color(random(150, 255), random(150, 255), random(200, 255)); // Light star colors
    size = random(2, 5); // Random size for variation
  }

  public void move() {
    speed += 0.015;
    x += cos((float)angle) * speed;
    y += sin((float)angle) * speed;
  }

  public void show() {
    fill(particleColor);
    noStroke();
    ellipse((float)x, (float)y, size, size);
  }
  
  public void checkEdges() {
    if (x < 0 || x > width || y < 0 || y > height) {
      x = width / 2;
      y = height / 2;
      speed = random(0.5, 2);
      particleColor = color(random(150, 255), random(150, 255), random(200, 255));
      size = random(2, 5);
    }
  }
}

// OddballParticle class implementing Particle interface
class OddballParticle implements Particle {
  double x, y, speed, angle;
  color particleColor;
  float size;

  OddballParticle(double startX, double startY, double ang, double spd) {
    x = startX;
    y = startY;
    angle = ang;
    speed = spd;
    particleColor = color(255, 215, 0); // Golden color for a bright star
    size = random(6, 8); // Larger size for distinction
  }

  public void move() {
    speed += 0.02; // Move Oddball slightly faster
    x += cos((float)angle) * speed * 1.5;
    y += sin((float)angle) * speed * 1.5;
    angle += 0.1;
  }

  public void show() {
    fill(particleColor);
    noStroke();
    ellipse((float)x, (float)y, size, size);
  }
  
  public void checkEdges() {
    if (x < 0 || x > width || y < 0 || y > height) {
      x = width / 2;
      y = height / 2;
      speed = random(0.5, 2);
      size = random(6, 8);
    }
  }
}
