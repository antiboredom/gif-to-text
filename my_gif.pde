class MyGif extends Thread {
  JSONObject json;
  String src, word;
  Gif img;
  PVector loc;
  float w = 0, h = 0;
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
  }

  void loadimg() {
    println("searching for: " + word);
    TableRow result = table.findRow(word.toLowerCase(), "word");
    if (result != null) {
      src = result.getString("url");
      if (!src.equals("none")) {
        h = 160;
        w = result.getFloat("width") * (h / result.getFloat("height"));

        this.start();//loadgif();
        println("loaded " + word);
      }
    }
  }

  void resizeHeight(float _h) {
    w = w * _h / h;
    h = _h;
  }

  void loadgif() {
    println("starting to load " + word + " from " + src);

    img = new Gif(applet, src);
    img.loop(); 
    img.play();
    img.ignoreRepeat();
    loaded = true;

    interrupt();
  }
}
