class Gradient_gen {
  
  int pos_x = 100;
  int pos_y = 1800;
  float size_x = 400;
  float size_y = 50;
  
  String[] partis = {"SRC", "SER", "GDR", "UMP", "LES-REP", "RRDP", "ECOLO", "UDI"};
  
  void generate() {
    draw_gradient();
    draw_legend();
  }

  void draw_gradient() {
    noFill();
    strokeCap(SQUARE);
    for (int cursor_x = pos_x; cursor_x <= pos_x+size_x; cursor_x++) {
      color c = get_color(map(float(cursor_x), pos_x, pos_x+size_x, -1, 1));
      stroke(c);
      line(cursor_x, pos_y, cursor_x, pos_y+size_y);
    }
  }
  
  void draw_legend() {
    fill(0, 0, 50);  // grey
    textSize(24);
    text("Légende", pos_x, pos_y + size_y + 40);
    
    
    ArrayList<Groupe_parti> groupe_partis = groupe_parti_gen();
    
    textSize(18);

    for (Groupe_parti parti : groupe_partis) {
      fill(parti.col);
      stroke(parti.col);
      line(parti.pos_x, pos_y, parti.pos_x, pos_y - 20);
      pushMatrix();
      translate(parti.pos_x, pos_y - 20);
      ellipse(0, 0, 10, 10);
      rotate(-PI/4);
      text(parti.label, 10, -10);
      popMatrix();
    }
  }
  
  ArrayList<Groupe_parti> groupe_parti_gen() {
    ArrayList<Groupe_parti> groupe_partis = new ArrayList<Groupe_parti>();
    for (String parti : partis) {
      Boolean tendanceAlreadyExists = false;
      float tendance = getTendance(parti);
      for (Groupe_parti gp : groupe_partis) {
        if (gp.tendance == tendance) {
          tendanceAlreadyExists = true;
          gp.label += ", " + parti;
        }
      }
      if (!tendanceAlreadyExists) {
        Groupe_parti ngp = new Groupe_parti();
        ngp.tendance = getTendance(parti);
        ngp.col = get_color(ngp.tendance);
        ngp.pos_x = map(ngp.tendance, -1, 1 ,pos_x, pos_x+size_x);
        ngp.label = parti;
        groupe_partis.add(ngp);
      }
    }
    
    return groupe_partis;
  }
  
  color get_color(float x) {
    float scaled_x = x * 30;
    if (scaled_x < 0.) {
      return color(330 - scaled_x, 80, 100 + (scaled_x/2)); // pink
    } else {
      return color(210 + scaled_x, 80,100 - (scaled_x/2)); // blue
    }
  }
}

class Groupe_parti {
  float tendance;
  float pos_x;
  String label;
  color col;
  
  String toString() {
    return label + "\t|" + tendance + "\t|" + pos_x + "\t|" + "\t|" + col;
  }
}