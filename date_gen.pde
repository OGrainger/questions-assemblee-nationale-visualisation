class Date_gen {
  ArrayList<Date> base_dates;
  
  void generate(ArrayList<Mot> unfiltered_data) {
    base_dates = generate_dates(unfiltered_data);
    generate_terrorisme(unfiltered_data);
    generate_travail(unfiltered_data);
    generate_cahuzac(unfiltered_data);
  }
  
  void generate_terrorisme(ArrayList<Mot> unfiltered_data) {
    ArrayList<Date> terrorisme_dates = clone_array(base_dates);
    for (Date date : terrorisme_dates) {
      if (date.label.equals("2015-11")) {
        date.event = "Bataclan";
      } else if (date.label.equals("2015-01")) {
        date.event = "Charlie Hebdo";
      } else if (date.label.equals("2015-08")) {
        date.event = "Thalys";
      } else if (date.label.equals("2016-03")) {
        date.event = "Bruxelles";
      } else if (date.label.equals("2016-06")) {
        date.event = "Magnanville";
      } else if (date.label.equals("2016-07")) {
        date.event = "Nice";
      } else if (date.label.equals("2013-01")) {
        date.event = "In Amenas";
      }
    }
    for (Mot mot : unfiltered_data) {
      if ((mot.label.contains("terror") || mot.label.contains("attentat") || mot.label.contains("islam")) && mot.parti.equals("ALL") && !mot.mois.equals("ALL")) {
        for (Date date : terrorisme_dates) {
          if (date.label.equals(mot.mois)) {
            date.count = date.count + mot.count;
            date.tendance = date.tendance + mot.tendance;
          }
        }
      }
    }
    draw_dates(terrorisme_dates, 2300);
  }
  
  void generate_travail(ArrayList<Mot> unfiltered_data) {
    ArrayList<Date> travail_dates = clone_array(base_dates);
    for (Date date : travail_dates) {
      if (date.label.equals("2016-03")) {
        date.event = "Manif. contre loi travail";
      }
      if (date.label.equals("2016-05")) {
        date.event = "Grèves contre loi travail";
      }
    }
    for (Mot mot : unfiltered_data) {
      if (mot.label.contains("travail") && mot.parti.equals("ALL") && !mot.mois.equals("ALL")) {
        for (Date date : travail_dates) {
          if (date.label.equals(mot.mois)) {
            date.count = date.count + mot.count;
            date.tendance = date.tendance + mot.tendance;
          }
        }
      }
    }
    
    draw_dates(travail_dates, 3200);
  }
  
  void generate_cahuzac(ArrayList<Mot> unfiltered_data) {
    ArrayList<Date> cahuzac_dates = clone_array(base_dates);
    for (Mot mot : unfiltered_data) {
      if ((mot.label.contains("rep")) && mot.parti.equals("ALL") && !mot.mois.equals("ALL")) {
        for (Date date : cahuzac_dates) {
          if (date.label.equals(mot.mois)) {
            date.count = date.count + mot.count;
            date.tendance = date.tendance + mot.tendance;
          }
        }
      }
    }
    
    draw_dates(cahuzac_dates, 2800);
  }
  
   void draw_dates(ArrayList<Date> dates, int py) {
    
    int px = 100;
    int max_count = 0;
    //textSize(32);
    //fill(0);
    //text("Occurence par mois des mots liés au terrorisme", 100, py - 100);
    float ecart = (width - 2 * px) / dates.size();
    stroke(0);
    noFill();
    beginShape();
    curveVertex(px, py - dates.get(0).count);
    for (Date date : dates) {
      if (max_count < date.count) {
        max_count = date.count;
      }
    }
    for (Date date : dates) {
      curveVertex(px, py - map(date.count, 0, max_count, 0, 250));
      px += ecart;
    }
    curveVertex(px, py - dates.get(dates.size() - 1).count);
    endShape();
   
    px = 100;
    float max_tendance = 0.;
    for (Date date : dates) {
      if (date.tendance > max_tendance) {
        max_tendance = date.tendance;
      }
    }
    for (Date date : dates) {
      
      float scaled_tendance = date.tendance * 30 / 15;
      color col;
      if (scaled_tendance < -0.1) {
          col = color(330 - scaled_tendance, 80, 100 + (scaled_tendance/2)); // pink
        }
        else if (scaled_tendance > 0.1) {
          col = color(210 + scaled_tendance, 80,100 - (scaled_tendance/2)); // blue
        } else {
          col = color(0,0,40); // grey  
        } 
      
      stroke(col);
      fill(col);
      if (!date.event.equals("NONE")) {
        line(px, py - map(date.count, 0, max_count, 0, 250), px, py);
        ellipse(px, py, 5, 5);
      }
      noStroke();
      ellipse(px, py - map(date.count, 0, max_count, 0, 250), !date.event.equals("NONE") ? 10 : 5, !date.event.equals("NONE") ? 10 : 5);
      textSize(map(date.count, 0, max_count, 8, 24));
      fill(col);
      text(str(date.count), px - (textWidth(str(date.count))/2),  py - map(date.count, 0, max_count, 0, 250) - 12);
      pushMatrix();
      translate(px, py);
      rotate(PI/4);
      translate(5, 20);
      textSize(date.event.equals("NONE") ? 12 : 20);
      text(date.event.equals("NONE") ? date.label : date.label + " - " + date.event, 0, 0);
      popMatrix();
      px += ecart;
    }
    stroke(0);
  }
  
  ArrayList<Date> generate_dates(ArrayList<Mot> mots) {
    ArrayList<Date> dates = new ArrayList<Date>();
    for (Mot mot : mots) {
      Boolean shouldCreate = true;
      for (Date date : dates) {
        if (mot.mois.equals("ALL") || mot.mois.equals(date.label)) {
          shouldCreate = false;
        }
      }
      if (shouldCreate) {
        Date date = new Date(mot.mois, 0);
        dates.add(date);
      }
    }
    return dates;
  }
  
  ArrayList<Date> clone_array(ArrayList<Date> oldList) {
    ArrayList<Date> newList = new ArrayList<Date>();
    for (Date date : oldList) {
      newList.add(date.clone());
    }
    return newList;
  }
}

class Date {
  String label;
  int count = 0;
  float tendance = 0.;
  String event;
  Date(String label, int count) {
    this.label = label;
    this.count = count;
    this.event = "NONE";
  }
  Date clone() {
    return(new Date(this.label, this.count));
  }
}