class Sentence {
  ArrayList<MyGif> gifs = new ArrayList<MyGif>();

  String[] wordlist;
  String words;

  boolean loaded = false;

  Sentence(String _words) {
    words = _words;
    wordlist = splitTokens(words, " ,.-?!:");
    float x = 20;
    float y = 20;
    int count = 0;
    for (int i = 0; i < wordlist.length; i ++) {
      String w = wordlist[i];
      MyGif g = new MyGif(w, x, y);
      if (g.h > 0) {
        gifs.add(g);
        y = y + g.h + 20;
        count ++;
      }
    }

    for (int j = 0; j < gifs.size(); j++) {
      MyGif gif = gifs.get(j);
      gif.resizeHeight((height - gifs.size() * 20) / gifs.size());
      gif.loc.y = gif.h * j + 10 * j + 10;
      gif.loc.x = width / 2 - gif.w;
    }
  }

  void update() {
    for (MyGif g : gifs) {
      loaded = g.loaded;
    }
  }

  void display() {

    for (MyGif g : gifs) {
      g.display();
    }
    fill(238, 52, 36);

    //textFont(font, 120);
    //text(words.toUpperCase(), width/2 + 20, 20, width/2 -40, height-40);
    textFont(font, 100);
    text(join(split(words.toUpperCase(), " "), "\n"), width/2 + 20, 20, width /2 - 20, height);

    //text(join(split(words.toUpperCase(), " "), "\n"), width/2 + 20, 20, width/2 -40, height-40);
  }
}

