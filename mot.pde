public class Mot {
  public String label;
  public int count = 0;
  public String mois = "ALL";
  public String parti = "ALL";
  public float tendance = 0.;
   
  Mot(String label, int count, String mois, String parti) {
    this.label = label;
    this.count = count;
    this.mois = mois;
    this.parti = parti;
  }
  
  Mot(String label, int count) {
    this.label = label;
    this.count = count;
  }
  
  Mot(String label) {
    this.label = label;
  }
  
  public String toString() {
    return this.label + "\t\t| " + this.count + "\t\t| " + this.mois + "\t\t| " + this.parti + "\t\t| " + str(this.tendance / this.count);
  }
  
  public Boolean equals(String l, String m, String p) {
    return this.label.equals(l) && this.mois.equals(m) && this.parti.equals(p);
  }
  
  public void incrementCount(int i) {
    this.count = this.count + i;
  }
  
  public void incrementTendance(float t) {
    this.tendance = this.tendance + t;
  }
}