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
Sentence sentence;
//animal farm
//fox news for dumbies
//gawker

void setup() {
  //size(displayWidth, displayHeight);
  size(1280, 720);
  table = loadTable("gifs.csv", "header");

  String[] lines = loadStrings("manifesto.txt");
  sample = join(lines, " ");
  words = splitTokens(sample, " ,.-?!:");
  lastUpdated = millis();
  applet = this;
  
  makeSentence();
}

void makeSentence() {
  String newSentence = "";
  for (int i = startAt; i < startAt + 5; i++) {
    if (i < words.length - 1) {
      newSentence += words[i] + " ";
    }
  }
  if (startAt + 5 >= words.length) {
    startAt = 0;
  } 
  else {
    startAt += 5;
  }

  sentence = new Sentence(newSentence);
}

void draw() {
  background(255);

  sentence.display();

  if (millis() - lastUpdated > 5000) {
    lastUpdated = millis();
    makeSentence();
  }
}

class Sentence {
  ArrayList<MyGif> gifs = new ArrayList<MyGif>();

  String[] wordlist;
  String words;

  Sentence(String _words) {
    words = _words;
    wordlist = split(words, " ");
    float x = 0;
    float y = 0;
    for (int i = 0; i < 5; i ++) {
      String w = wordlist[i];
      MyGif g = new MyGif(w, x, y);
      gifs.add(g);
      if (x + 20 + g.w < width) {
        x += g.w + 20;
      } 
      else {
        g.loc.x = 20;
        x = g.w;
        y += g.h + 20;
        g.loc.y = y;
      }
    }
  }

  void display() {

    for (MyGif g : gifs) {
      g.display();
    }

    textSize(100);
    fill(255, 0, 0);
    text(words, 20, height - 200, width - 20, height/2);
  }
}

class MyGif extends Thread {
  JSONObject json;
  String src, word;
  Gif img;
  PVector loc;
  float w = 200, h = 200;
  boolean loaded = false;
  PGraphics graphic;

  boolean running = true;    // Is the thread running?  Yes or no?
  int wait;                  // How many milliseconds should we wait in between executions?
  String id;                 // Thread name
  int count;                 // counter

  MyGif(String _word, float x, float y) {
    word = _word;
    loc = new PVector(x, y);
    loadimg();
  }

  void start () {
    running = true;
    super.start();
  }

  void run () {
    loadgif();
  }

  void display() {
    if (loaded) {
      image(img, loc.x, loc.y, w, h);
    } 
    else {
      fill(255, 0, 0);
      rect(w, h, loc.x, loc.y);
    }
  }

  void loadimg() {
    println("searching for: " + word);
    TableRow result = table.findRow(word.toLowerCase(), "word");
    if (result != null) {
      src = result.getString("url");
      if (!src.equals("none")) {
        h = 150;
        w = result.getFloat("width") * (h / result.getFloat("height"));

        this.start();//loadgif();
        println("loaded " + word);
      }
    }
  }

  void loadblank() {
    graphic = createGraphics(100, gifheight);
    graphic.beginDraw();
    graphic.background(150);
    graphic.endDraw();
    w = graphic.width;
    h = graphic.height;
  }

  void loadgif() {
    println("starting to load " + src);
    img = new Gif(applet, src);
    img.loop(); 
    img.play();
    img.ignoreRepeat();
    loaded = true;
    interrupt();
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getAmount();
  ymove += e;
}

