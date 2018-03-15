class Text_gen {
  void generate() {
    
    String title = "OCCURRENCE DES MOTS DANS LES QUESTIONS POSÉES AU GOURVERNEMENT";
    String h2 = "Données reccueillies pour la XIVe législation, valable de Juillet 2012 à Février 2017";
    
    String data_1_line_1 = "Ces deux graphes représentent l'orientation politique et l'occurrence des mots les plus représentés.";
    String data_1_line_2 = "La couleur correspond à l'orientation et la taille à l'occurrence. De plus, dans le deuxième graphe,\n";
    String data_1_line_3 = "l'angle correspond à l'orientation. Le chiffre représente l'occurrence.";
    
    String data_2_line_1 = "Ces graphes représentent la variation d'occurrence et l'orientation politique";
    String data_2_line_2 = "de mots ou groupes de mots sur plusieurs mois.";
    
    String data_2_graph_1 = "Mots liés aux attentats";
    String data_2_graph_2 = "Mots liés à Cahuzac";
    String data_2_graph_3 = "Mots liés au travail";
    
    String footer = "Code source : https://github.com/OGrainger/questions-assemblee-nationale-visualisation - Nécessite le parse disponible ici : https://github.com/OGrainger/questions-assemblee-nationale-parser - Les données sources sont accessibles ici : http://data.assemblee-nationale.fr/travaux-parlementaires/questions/questions-au-gouvernement"; 


    
    float margin = 100;
    
    noStroke();
    fill(0, 0, 30);  // dark grey
    textSize(64);
    text(title, (width - textWidth(title)) / 2, 120);
    textSize(48);
    fill(0, 0, 50);  // grey
    text(h2, (width - textWidth(h2)) / 2, 210);
    
    textSize(24);
    text(data_1_line_1, width - textWidth(data_1_line_1) - margin, 1200);
    text(data_1_line_2, width - textWidth(data_1_line_2) - margin, 1230);
    text(data_1_line_3, width - textWidth(data_1_line_3) - margin, 1260);
    
    text(data_2_line_1, margin, 2070);
    text(data_2_line_2, margin, 2100);
    
    textSize(32);
    fill(0,0,50);
    text(data_2_graph_1, margin, 2400);
    text(data_2_graph_2, margin, 2900);
    text(data_2_graph_3, margin, 3300);
    
    
    stroke(0,0,80); // light grey
    strokeWeight(1);
    line(margin, 240, width - margin, 240);
    
    textSize(18);
     fill(0,0, 70);
    text(footer, margin, height - margin/2);
    
  }
}