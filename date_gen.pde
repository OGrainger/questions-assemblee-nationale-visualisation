class Date_gen {
  ArrayList<Date> base_dates;
  
  void generate(ArrayList<Mot> unfiltered_data) {
    base_dates = generate_dates(unfiltered_data);
    generate_terrorisme(unfiltered_data);
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
      }
    }
    for (Mot mot : unfiltered_data) {
      if ((mot.label.contains("terror") || mot.label.contains("attentat") || mot.label.contains("islam")) && mot.parti.equals("ALL") && !mot.mois.equals("ALL")) {
        for (Date date : terrorisme_dates) {
          if (date.label.equals(mot.mois)) {
            date.count = date.count + mot.count;
          }
        }
      }
    }
    
    int px = 100;
    int py = 2000;
    int max_count = 0;
    textSize(32);
    fill(0);
    text("Occurence par mois des mots liés au terrorisme", 100, py - 100);
    float ecart = (width - 2 * px) / terrorisme_dates.size();
    stroke(0);
    noFill();
    beginShape();
    curveVertex(px, py - terrorisme_dates.get(0).count);
    for (Date date : terrorisme_dates) {
      if (max_count < date.count) {
        max_count = date.count;
      }
      curveVertex(px, py - 2 * date.count);
      px += ecart;
    }
    curveVertex(px, py - terrorisme_dates.get(terrorisme_dates.size() - 1).count);
    endShape();
   
    px = 100;
    for (Date date : terrorisme_dates) {
      if (!date.event.equals("NONE")) {
        stroke(0, 100, 80);
        line(px, py - 2 * date.count, px, py);
        ellipse(px, py, 5, 5);
      }
      noStroke();
      fill(0, date.event.equals("NONE") ? 0 : 100, date.event.equals("NONE") ? 0 : 80);
      ellipse(px, py - 2 * date.count, date.event.equals("NONE") ? 5 : 10, date.event.equals("NONE") ? 5 : 10);
      textSize(map(date.count, 0, max_count, 8, 32));
      fill(0, 100, date.count * 80 / max_count);
      text(str(date.count), px - (textWidth(str(date.count))/2),  py - 2 * date.count - 12);
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