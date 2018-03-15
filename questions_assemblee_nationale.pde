import processing.pdf.*;
import java.awt.*;

void setup() {
  size(2480, 3508, PDF, "output.pdf");
  background(255);
  
  println("STARTED");
  textFont(createFont("BebasNeueRegular", 32), 32);
  
  println("LOADING FONT : OK");

  PImage image = loadImage("mask.png");
  image.resize(width, height);
  Shape imageShape = new ImageShaper().shape(image, #000000);
  ShapeBasedPlacer placer = new ShapeBasedPlacer(imageShape);
  colorMode(HSB, 360, 100, 100);
  ArrayList<Mot> data = new Csv_parser().generate();
  println("SIZE : " + str(data.size()));
  
  new WordCram(this)
    .fromWords(new Word_cloud_gen().generate(data))
    .withFont(createFont("BebasNeueBook", 32))
    .withPlacer(placer)
    .withNudger(placer)
    .sizedByWeight(8, 120) 
    .minShapeSize(0)
    .angledAt(0)
    .drawAll();
  println("WORDCRAM : OK");  
  new Date_gen().generate(data);
  println("DATE : OK");  
  new Tendance_date_gen().generate(data);
  println("TENDANCE - DATE : OK");    
  new Text_gen().generate();
  print("Done !");
}