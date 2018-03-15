class Tendance_date_gen {
  void generate(ArrayList<Mot> unfiltered_data) {
    ArrayList<Mot> data = new ArrayList<Mot>();
    float max_tendance = 0.;
    int max_count = 0;
    
    for (Mot mot : unfiltered_data) {
      if (mot.parti.equals("ALL") && mot.mois.equals("ALL")) {
        data.add(mot);
        if (max_tendance < abs(mot.tendance)) {
          max_tendance = abs(mot.tendance);
        }
        if (max_count < mot.count) {
          max_count = mot.count;
        }
      }
    }
    
    float px = width/2;
    float py = 1400;
    
    //textSize(32);
    //fill(0);
    //text("Tendance et occurence globale", 100, py + 20);
    pushMatrix();
    translate(px, py);
    noFill();
    for (Mot mot : data) {
        float ajusted_count = log(map(mot.count, 0, max_count, 1, 10)) * 220;
        float not_log_ajusted_count = map(mot.count, 0, max_count, 0, 800);
        float scaled_tendance = mot.tendance * 30 / max_tendance;
        float ajusted_tendance = map(-mot.tendance, 0, 500, PI/2, PI);
        color col;
        if (scaled_tendance < -0.1) {
          col = color(330 - scaled_tendance, 80, 100 + (scaled_tendance/2)); // pink
        }
        else if (scaled_tendance > 0.1) {
          col = color(210 + scaled_tendance, 80,100 - (scaled_tendance/2)); // blue
        } else {
          col = color(0,0,40); // grey  
        } 
        noFill();
        stroke(col);
        PVector pos = polar_to_carthesian(ajusted_count, ajusted_tendance);
        PVector pos_half = polar_to_carthesian(ajusted_count/2, map(ajusted_tendance, PI/2, PI, PI/2, 3*PI/4));
        if (mot.count > 2500) {
          bezier(0, 0, pos_half.x * 4 /2, pos_half.y /2, pos_half.x * 2.7, pos_half.y, pos.x * 2.7, pos.y);
        }
        pushMatrix();
        translate(pos.x * 2.7, pos.y); 
        fill(col);
        noStroke();
        ellipse(0, 0, not_log_ajusted_count / 8, not_log_ajusted_count / 8);
        if (mot.count > 2500) {
          textSize(not_log_ajusted_count / 20);
          fill(col);
          text(mot.label.toUpperCase(), pos.x < 0 ? - (((not_log_ajusted_count/2) / 8)) - 5 - textWidth(mot.label.toUpperCase()) : ((not_log_ajusted_count/2) / 8) + 5, not_log_ajusted_count / 50);
          fill(0, 0, 100);
          text(mot.count, - textWidth(str(mot.count))/2, not_log_ajusted_count / 60);
        }
        popMatrix();
    }
    popMatrix();
  }
  
  PVector polar_to_carthesian(float r, float angle) {
    return new PVector(r * cos(angle), r * sin(angle));
  }
}