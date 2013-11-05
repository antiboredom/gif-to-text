//import gifAnimation.*;

int gifwidth = 200;
int gifheight = 200;
int columns = 10;
Table table;
//PApplet applet;
String sample = "A spectre is haunting Europe -- the spectre of communism. All the powers of old Europe have entered into a holy alliance to exorcise this spectre: Pope and Tsar, Metternich and Guizot, French Radicals and German police-spies.";

ArrayList<MyGif> gifs = new ArrayList<MyGif>();
//animal farm
//fox news for dumbies
//gawker

void setup() {
  //size(displayWidth, displayHeight);
  size(600, 600);
  table = new Table("gifs.csv", "header");
  String words[] = splitTokens(sample, " ,.-?!:");
  float x = 0;
  float y = 0;
  //applet = this;

  for (String w : words) {

    println("__" + w + "__");
    MyGif g = new MyGif(w, x, y);
    gifs.add(g);
    if (x + g.w < width) {
      x += g.w;
    } 
    else {
      g.loc.x = 0;
      x = g.w;
      y += gifheight;
    }
  }
}

void draw() {
  for (MyGif g : gifs) {
    g.display();
  }
}

class MyGif {
  JSONObject json;
  String src, word;
  PImage img;
  PVector loc;
  float w, h;
  boolean loaded = false;
  PGraphics graphic;

  MyGif(String _word, float x, float y) {
    word = _word;
    loc = new PVector(x, y);
    loadimg();
  }  

  void display() {
    if (loaded) {
      image(img, loc.x, loc.y);
    } 
    else {
      image(graphic, loc.x, loc.y);
    }
    text(word, loc.x, loc.y + 15);
  }

  void loadimg() {
    TableRow result = table.matchRow(word.toLowerCase(), "word");
    src = result.getString("url");
    if (src != "none") {
      w = result.getFloat("width");
      h = result.getFloat("height");

      img = loadImage(src);
      //      img = new Gif(applet, src);
      //      img.loop();
      //      img.play();
      //      img.ignoreRepeat();
      loaded = true;
      println("loaded " + word);
    } 
    else {
      graphic = createGraphics(100, gifheight);
      graphic.beginDraw();
      graphic.background(150);
      graphic.endDraw();
      w = graphic.width;
      h = graphic.height;
    }
  }
}

//class Table {
//  int rowCountLocal;
//  String[][] data;
//  
//  Table(String filename) {
//    String[] rows = loadStrings(filename);
//    
//    data = new String[rows.length][];
//    rowCountLocal = 0;
//    for (int i = 0; i < rows.length; i++) {
//      if (trim(rows[i]).length() == 0) {
//        continue; // skip empty rows
//      }
//      if (rows[i].startsWith("#")) {
//        continue;  // skip comment lines
//      }
//      // split the row on the tabs
//      String[] pieces = split(rows[i], ',');
//      // copy to the table array
//      data[rowCountLocal] = pieces;
//      rowCountLocal++;
//    }
//  }
//  
//  int getRowCount() {
//    return rowCountLocal;
//  }
//  
//  String getString(int rowIndex, int column) {
//    return data[rowIndex][column];
//  }
//  
//  int getInt(int rowIndex, int column) {
//    return parseInt(getString(rowIndex, column));
//  }
//  
//  float getFloat(int rowIndex, int column) {
//    return parseFloat(getString(rowIndex, column));
//  }
//  
//  
//}

