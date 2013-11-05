import gifAnimation.*;

int gifwidth = 200;
int gifheight = 200;
int columns = 10;
float ymove = 0;
Table table;
PApplet applet;
String sample;// = "A spectre is haunting Europe -- the spectre of communism. All the powers of old Europe have entered into a holy alliance to exorcise this spectre: Pope and Tsar, Metternich and Guizot, French Radicals and German police-spies.";

ArrayList<MyGif> gifs = new ArrayList<MyGif>();
//animal farm
//fox news for dumbies
//gawker

void setup() {
  size(displayWidth, displayHeight);
  //size(600, 600);
  table = loadTable("gifs.csv", "header");

  String[] lines = loadStrings("manifesto.txt");
  sample = join(lines, " ");
  String words[] = splitTokens(sample, " ,.-?!:");

  float x = 0;
  float y = 0;
  applet = this;

  for (int i = 0; i < 100; i ++) {
    String w = words[i];
    MyGif g = new MyGif(w, x, y);
    gifs.add(g);
    if (x + g.w < width) {
      x += g.w;
    } 
    else {
      g.loc.x = 0;
      x = g.w;
      y += gifheight;
      g.loc.y = y;
    }
  }
}

void draw() {
  background(0);

  translate(0, ymove);
  for (MyGif g : gifs) {
    g.display();
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
      image(img, loc.x, loc.y);
    } 
    else {
      //rect(w, h, loc.x, loc.y);
    }
    text(word, loc.x, loc.y + 15);
  }

  void loadimg() {
    println("searching for: " + word);
    TableRow result = table.findRow(word.toLowerCase(), "word");
    if (result != null) {
      src = result.getString("url");
      if (!src.equals("none")) {
        w = result.getFloat("width") * (200 / result.getFloat("height"));
        h = 200;
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


