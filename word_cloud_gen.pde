import wordcram.*;

class Word_cloud_gen {
  ArrayList<Mot> data = new ArrayList<Mot>();
  Word[] words;
  
  float max_tendance = 0.;
  
  Word[] generate(ArrayList<Mot> unfiltered_data) {
    for (Mot mot : unfiltered_data) {
      if (mot.parti.equals("ALL") && mot.mois.equals("ALL")) {
        data.add(mot);
        if (max_tendance < abs(mot.tendance)) {
          max_tendance = mot.tendance;
        }
      }
    }
    loadWords();
    return words;
  }
  
  void loadWords() { 
    words = new Word[data.size()];
    for (int i = 0; i < data.size(); i++) {
      words[i] = parseWord(data.get(i));
    }
  }
  
  Word parseWord(Mot mot) {
    
    String name = mot.label.toUpperCase();
    float frequency = float(mot.count);
    
    Word word = new Word(name, frequency);
    
    float scaled_tendance = mot.tendance * 30 / max_tendance;
    
    if (scaled_tendance < 0) {
      word.setColor(color(330 - scaled_tendance, 80, 100 + (scaled_tendance/2))); // pink
    }
    else {
      word.setColor(color(210 + scaled_tendance,80,100 - (scaled_tendance/2))); // blue
    }
    
    return word;
  }
}