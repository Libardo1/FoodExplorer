import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import java.util.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
UnfoldingMap map;
processing.data.JSONObject restaurants;
processing.data.JSONArray restaurantsFile;
processing.data.JSONArray termCountsFile;
processing.data.JSONObject termDicts;
processing.data.JSONObject termList;

String PRestName;
String PRestAddress;
float PRestRating;
int PRestReviewCount;
public static boolean mouseO = false;

List<Location> loc;
List locMarkers = new ArrayList();
MarkerManager mM = new MarkerManager();
Marker m;
public void setup() {
  frame.setTitle("Food Finder"); 
  size(800, 600, P2D);
  noStroke();
  loc = new ArrayList<Location>();

  ///====JSON FUNCTION====================

  try {
    restaurantsFile = loadJSONArray("relevant_restaurants.json");
    restaurants = restaurantsFile.getJSONObject(0);
    termCountsFile = loadJSONArray("term_counts.json");
    termDicts = loadJSONObject("term_dicts.json");
    termList = termCountsFile.getJSONObject(0);
  }
  catch(Exception e) {
    println("File import in setup method failed to initialize");
  }

  try {
    map = new UnfoldingMap(this, 0, 0, 640, height, new OpenStreetMap.CloudmadeProvider("473dc610e8984c109317b4e565f75b1c", 2));
    map.setTweening(true);
    //  map.zoomToLevel(10);
    map.zoomAndPanTo(new Location(33.4f, -112.0f), 10);
    MapUtils.createDefaultEventDispatcher(this, map);
  }
  catch(Exception e) {
    text("No Map to Display\n, check network connection", width/2, height/2);
    println("Failure to initialize map, check network connection");
  }
}

public void draw() {
  //frameRate(60);
  background(245, 250, 242);
  for (int w=0; w<950; w+=10) {
    stroke(240, 240, 240, 50);
    strokeWeight(1);   
    line(0, w+10, width, w+10); //horiz
  }
  for (int w=0; w<950; w+=10) {
    stroke(240, 240, 240, 50);
    strokeWeight(1);   
    line(w+10, 0, w+10, height); //horiz
  }
  try {
    map.draw();
  }
  catch(Exception e) {
    textSize(25);
    text("No Map to Display\n, check network connection", width/2, height/2);
    println("Map drawing failed, check network");
  }

  // createButtons(); 
  selectFoodSlideBar();
 // println(mouseO);
  if (mouseO){
   // println("true");
    fill(255);
    strokeWeight(1);
    float Tw = 0;
    if(textWidth(PRestAddress)>textWidth(PRestName)){
      Tw=textWidth(PRestAddress);
    }else{
      Tw=textWidth(PRestName);
    }
    
    rect(mouseX, mouseY - 100, Tw+20, 200);
    fill(0);
    textAlign(LEFT);
    text(PRestName, mouseX + 5, mouseY - 76);
    text("Rating: "+PRestRating, mouseX + 5, mouseY - 40);
    text(PRestAddress, mouseX + 5, mouseY - 5); //<>//
    
  }
  mouseO=false;
}

String [] foodToTerms(processing.data.JSONObject termList, String food) {
  //Read in the term list for a type of food
  processing.data.JSONObject terms = termList.getJSONObject(food);
  //println(terms);

  //List all top terms for a food
  String [] allTerms = new String[0];
  for (int i = 0; i < terms.keys().size(); i++) {
    allTerms = append(allTerms, terms.keys().toArray()[i].toString());
  }
  return allTerms;
}

void buttons() {
}


public class PMarker extends SimplePointMarker {
  PGraphics pg;
  float x;
  float y;
  int radius;
  String p1;
  String p2;
  float p3;
  int p4;
  public PMarker(Location location, String PRName, String PRAddress, Float PRRating, int PRCount) {
    super(location);
    this.p1 = PRName;
    this.p2 = PRAddress;
    this.p3 = PRRating;
    this.p4 = PRCount;
  }
  public void draw(PGraphics pg, float x, float y) {
    this.pg = pg;
    this.x = x;
    this.y = y;
    this.radius = 10;
    pg.pushStyle();
    pg.stroke(0);
    pg.strokeWeight(.1);
    mouseOver();
    pg.ellipse(x, y, radius, radius);
    //pg.fill(255, 100);
    //  pg.ellipse(x, y, 30, 30);
    pg.popStyle();
  } 
  public void mouseOver() {
    if (dist(mouseX, mouseY, x, y) < radius) {
      FoodExplorer.mouseO=true;
      pg.fill(255, 0, 0);
      fill(255);
      //println(PRestName);
      PRestName = this.p1;
      PRestAddress = this.p2;
      PRestRating = this.p3;
      PRestReviewCount = this.p4;
    }
    else {
      pg.fill(0, 0, 255);
    } //<>//
  }
}
