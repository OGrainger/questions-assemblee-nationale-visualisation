class Tendance_date_gen {
  void generate(ArrayList<Mot> unfiltered_data) {
    ArrayList<Mot> data = new ArrayList<Mot>();
    float max_tendance = 0.;
    int max_count = 0;
    
    for (Mot mot : unfiltered_data) {
      if (mot.parti.equals("ALL") && mot.mois.equals("ALL")) {
        data.add(mot);
        if (max_tendance < abs(mot.tendance)) {
          max_tendance = mot.tendance;
        }
        if (max_count < mot.count) {
          max_count = mot.count;
        }
      }
    }
    
    float px = width/2;
    float margin = 500.;
    float py = height/4;
    textSize(32);
    fill(0);
    text("Tendance et occurence globale", 100, py + 20);
    pushMatrix();
    translate(px, py);
    
    for (Mot mot : data) {
      //println(mot.tendance);
      if (mot.count > 800 || abs(mot.tendance) > 100) {
        float ajusted_count = map(mot.count, 0, max_count, 0, 800);
        float scaled_tendance = mot.tendance * 30 / max_tendance;
        color col;
        if (scaled_tendance < -1) {
          col = color(330 - scaled_tendance, 80, 100 + (scaled_tendance/2)); // pink
        }
        else if (scaled_tendance > 1) {
          col = color(240,80,100 - (scaled_tendance/2)); // blue
        } else {
          col = color(0,0,40); // grey  
        }
        float x_pos = map(mot.tendance, -max_tendance, max_tendance, -width/2 + margin, width/2 - margin);
        noFill();
        stroke(col);
        bezier(0, 0, 0, ajusted_count / 2, x_pos / 2, ajusted_count, x_pos, ajusted_count);
        pushMatrix();
        translate(x_pos, ajusted_count); 
        fill(col);
        noStroke();
        ellipse(0, 0, ajusted_count / 20, ajusted_count / 20);
        textSize(ajusted_count / 30);
        text(mot.label.toUpperCase(), x_pos < 0 ? - ((ajusted_count + 10) / 20) - textWidth(mot.label.toUpperCase()) : (ajusted_count + 10) / 20, ajusted_count / 60);
        popMatrix();
      }
    }
    popMatrix();
  } 
}