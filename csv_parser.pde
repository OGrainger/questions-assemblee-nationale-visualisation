class Csv_parser {
  ArrayList<Mot> data;
  
  float percent = 0.;
  
  ArrayList<Mot> generate() {
    data = new ArrayList<Mot>();
    loadData();
    return data;
  }
  void loadData() {
    String[] csv_lines = loadStrings("CSV_test.txt");
    for (int i = 0; i < csv_lines.length; i++) {
      line_parser(csv_lines[i]);
      println("parsing : " + str(Math.round(float(i)*100/csv_lines.length)) + "%" + " - size : " + data.size());
    }
  }
  
  void line_parser(String line) {
    String[] elements = line.split(",");
    String new_label = elements[2];
    int new_count = Integer.parseInt(elements[3]);
    String new_parti = elements[1];
    String new_mois = elements[0];
    
    data_filter_all_parser(new_label, new_count, new_mois, new_parti);
    data_filter_mois_parser(new_label, new_count, new_mois, new_parti);
    data_filter_parti_parser(new_label, new_count, new_parti);
    data_no_filter_parser(new_label, new_count, new_parti);
  }
  
  void data_filter_all_parser(String l, int c, String m, String p) {
    Mot new_mot = new Mot(l, c, m, p);
    data.add(new_mot);
  }
  
  void data_filter_mois_parser(String l, int c, String m, String p) {
    boolean exists = false;
    for (Mot mot : data) {
      if (mot.equals(l, m, "ALL")) {
        exists = true;
        mot.incrementCount(c);
        mot.incrementTendance(c * getTendance(p));
        break;
      }
    }
    if (!exists) {
      Mot new_mot = new Mot(l, c, m, "ALL");
      new_mot.tendance = c * getTendance(p);
      data.add(new_mot);
    }
  }
  
  void data_filter_parti_parser(String l, int c, String p) {
    boolean exists = false;
    for (Mot mot : data) {
      if (mot.equals(l, "ALL", p)) {
        exists = true;
        mot.incrementCount(c);
        break;
      }
    }
    if (!exists) {
      data.add(new Mot(l, c, "ALL", p));
    }
  } 
  
  void data_no_filter_parser(String l, int c, String p) {
    boolean exists = false;
    for (Mot mot : data) {
      if (mot.equals(l, "ALL", "ALL")) {
        exists = true;
        mot.incrementCount(c);
        mot.incrementTendance(c * getTendance(p));
        break;
      }   
    }
    if (!exists) {
      Mot new_mot = new Mot(l, c);
      new_mot.tendance = c * getTendance(p);
      data.add(new_mot);
    }
  }
}