import gifAnimation.*;

int gifwidth = 200;
int gifheight = 200;
int columns = 10;
float ymove = 0;
Table table;
PApplet applet;
String sample;// = "A spectre is haunting Europe -- the spectre of communism. All the powers of old Europe have entered into a holy alliance to exorcise this spectre: Pope and Tsar, Metternich and Guizot, French Radicals and German police-spies.";
String[] words;
int lastUpdated;
int startAt = 0;
int incrementBy = 5;
int slideTime = 2500;
Sentence sentence;
PFont font;
boolean looping = true;
//animal farm
//fox news for dumbies
//gawker
//ArialNarrow-Bold

void setup() {
  frameRate(24);
 
  size(1280, 720);
  table = loadTable("gifs.csv", "header");

  String[] lines = loadStrings("manifesto.txt");
  sample = join(lines, " ");
  words = splitTokens(sample, " ");
  lastUpdated = millis();
  applet = this;

  font = loadFont("ArialNarrow-Bold-90.vlw");

  makeSentence();
}

void makeSentence() {
  String newSentence = "";
  for (int i = startAt; i < startAt + incrementBy; i++) {
    if (i < words.length - 1) {
      newSentence += words[i] + " ";
    }
  }
  if (startAt + incrementBy >= words.length) {
    startAt = 0;
  } 
  else {
    startAt += incrementBy;
  }

  sentence = new Sentence(newSentence);

}

void draw() {
  background(255);

  sentence.display();

  if (millis() - lastUpdated > slideTime) {
    lastUpdated = millis();
    makeSentence();
  }
  
}

void keyReleased() {
  looping = !looping;
  if (looping) { loop(); }
  else { noLoop(); }
}




