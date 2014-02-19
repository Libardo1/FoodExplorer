int pressT1 = 1;
int pressT2 = 0;
int pressT3 = 0;
int pressT4 = 0;
int pressT5 = 0;
int pressT6 = 0;
int pressT7 = 0;
int pressT8 = 0;
int pressT9 = 0;
int pressT10 = 0;
int currFoodInt = 1;
boolean arrowPressed1,arrowPressed2 = false;

String[] TermLabels;
int termInd;
color textCol = color(100,120,105);

void selectFoodSlideBar(){
  fill(150);
  rect(width/10.2,20,510,40);
  stroke(255,0,0);
  strokeWeight(2);
  
  PFont f = createFont("Arial", 25);
  textFont(f);
  textSize(16);
  fill(250);
  textAlign(LEFT);
    fill(255,255,255,150);
  rect(width/10,20,165,40);
  rect(420,20,170,40);
  String foodType = "";
  String[] foods = {"italian","chinese","mexican","american","pizza","steakhouses","buffets","japanese","burgers","italian","chinese"};
  textAlign(CENTER);
  fill(0);
  text(foods[currFoodInt-1], width/5, 43);
  textSize(25);
  fill(250,250,210);
  text(foods[currFoodInt], width/2.4, 46);
  textSize(16);
  fill(0);
  text(foods[currFoodInt+1],width/1.6, 43);
  foodType=(foods[currFoodInt]);
  
  TermLabels=foodToTerms(termList, foodType);
  createButtons();  
  String[] allTerms = foodToTerms(termList, foodType);
  //Fucntion 2: return top restaurant IDs given a food type and a term
  String[] allRestaurantIDs = termToRestaurantIDs(allTerms, termInd, foodType);
  //Function 3: return restaurant info given a list of restaurant IDs
  String[] restaurantInfo = restaurantIDToRestaurantInfo(restaurants, allRestaurantIDs);
  
  MapRestarauntData(restaurantInfo);


  // Rect Faded out

  ///////////////////
  //switch between restaraunt types
  if(arrowPressed1){
    fill(255,0,0);
  }else{
    fill(0,255,0);
  }
  //rect(164,35,15,15);
  triangle(76,35,76,55,60,45);
  
  if(arrowPressed2){
    fill(255,0,0);
  }else{
    fill(0,255,0);
  }
  triangle(594,35,594,55,610,45);
  //////////////////
  arrowPressed1=false;
  arrowPressed2=false;
}

void createButtons() {
  //Plot the cursor coordinates
  fill(0);
  //text(mouseX + " , "+ mouseY, width/2, height-10);
  
  
  //Plot the title
  textAlign(RIGHT);
  PFont f = createFont("Bitstream Charter Bold", 22);
  textFont(f);
  fill(0);
  text("PICK A WORD", width-9 + 1, 50 + 1);
  fill(100);
  text("PICK A WORD", width-9, 50);
  
  textAlign(CENTER);
  if(pressT1 == 0) {
    fill(textCol);
    textSize(25);
    text(TermLabels[0],width-75, 90);
  } else if(pressT1 == 1) {
    fill(0,255,0);
    //println("t1");
    textSize(25);
    text(TermLabels[0],width-75, 90);
    termInd = 0;
  }
  if(pressT2 == 0){
    fill(textCol);
    textSize(25);
    text(TermLabels[1], width-75, 130);
  } else if(pressT2 == 1) {
    fill(0,255,0);
    textSize(25);
    text(TermLabels[1], width-75, 130);
    termInd = 1;
  }
  if(pressT3 == 0){
    fill(textCol);
    textSize(25);
    text(TermLabels[2], width-75, 170);
  } else if(pressT3 == 1) {
    fill(0,255,0);
    textSize(25);
    text(TermLabels[2], width-75, 170);
    termInd = 2;
  }
  if(pressT4 == 0){
    textSize(25);
    fill(textCol);
    text(TermLabels[3], width-75, 210);
  } else if(pressT4 == 1) {
    fill(0,255,0);
    textSize(25);
    text(TermLabels[3], width-75, 210);
    termInd = 3;
  }
  if(pressT5 == 0){
    textSize(25);
    fill(textCol);
    text(TermLabels[4], width-75, 250);
  } else if(pressT5 == 1) {
    fill(0,255,0);
    textSize(25);
    text(TermLabels[4], width-75, 250);
    termInd = 4;
  }
  if(pressT6 == 0){
    textSize(25);
    fill(textCol);
    text(TermLabels[5], width-75, 290);
  } else if(pressT6 == 1) {
    fill(0,255,0);
    textSize(25);
    text(TermLabels[5], width-75, 290);
    termInd = 5;
  }
  if(pressT7 == 0){
    textSize(25);
    fill(textCol);
    text(TermLabels[6], width-75, 330);
  } else if(pressT7 == 1) {
    fill(0,255,0);
    textSize(25);
    text(TermLabels[6], width-75, 330);
    termInd = 6;
  }
  if(pressT8 == 0){
    textSize(25);
    fill(textCol);
    text(TermLabels[7], width-75, 370);
  } else if(pressT8 == 1) {
    fill(0,255,0);
    textSize(25);
    text(TermLabels[7], width-75, 370);
    termInd = 7;
  }
  if(pressT9 == 0){
    textSize(25);
    fill(textCol);
    text(TermLabels[8], width-75, 410);
  } else if(pressT9 == 1) {
    fill(0,255,0);
    textSize(25);
    text(TermLabels[8], width-75, 410);
    termInd = 8;
  }
  if(pressT10 == 0){
    textSize(25);
    fill(textCol);
    text(TermLabels[9], width-75, 450);
  } else if(pressT10 == 1) {
    fill(0,255,0);
    textSize(25);
    text(TermLabels[9], width-75, 450);
    termInd = 9;
  }
}

void mousePressed(){
  if(mouseX < 76 && mouseX>60 && mouseY < 50 && mouseY>15) {
    arrowPressed1=true;
    if(currFoodInt>1) {
      currFoodInt--;
      map.zoomAndPanTo(new Location(33.5f, -112.0f), 10);
    } else {
      currFoodInt=9;
      map.zoomAndPanTo(new Location(33.5f, -112.0f), 10);
    }
  } else if(mouseX > 590 && mouseX<610 && mouseY < 50 && mouseY>15) {
    arrowPressed2=true;
    if(currFoodInt<9) {
      currFoodInt++;
      map.zoomAndPanTo(new Location(33.5f, -112.0f), 10);
    } else {
      currFoodInt=1;
      map.zoomAndPanTo(new Location(33.5f, -112.0f), 10);
    }
  } else if(mouseX < width && mouseX>width-150 && mouseY < 90 && mouseY>78) {
    if(pressT1==0) {
      pressT1=1;
      pressT2=pressT3=pressT4=pressT5=pressT6=pressT7=pressT8=pressT9=pressT10=0;
    } else {
      pressT1=0;
    }
  }  else if(mouseX < width && mouseX>width-150 && mouseY < 130 && mouseY> 118) {
    if(pressT2==0) {
      pressT2=1;
      pressT1=pressT3=pressT4=pressT5=pressT6=pressT7=pressT8=pressT9=pressT10=0;
    } else {
      pressT2=0;
    }
  }  else if(mouseX < width && mouseX>width-150 && mouseY < 170 && mouseY>158) {
    if(pressT3==0) {
      pressT3=1;
      pressT1=pressT2=pressT4=pressT5=pressT6=pressT7=pressT8=pressT9=pressT10=0;
    } else {
      pressT3=0;
    }
  }  else if(mouseX < width && mouseX>width-150 && mouseY < 210 && mouseY>198) {
    if(pressT4==0) {
      pressT4=1;
      pressT1=pressT2=pressT3=pressT5=pressT6=pressT7=pressT8=pressT9=pressT10=0;
    } else {
      pressT4=0;
    }
  }  else if(mouseX < width && mouseX>width-150 && mouseY < 250 && mouseY>238) {
    if(pressT5==0) {
      pressT5=1;
      pressT1=pressT2=pressT3=pressT4=pressT6=pressT7=pressT8=pressT9=pressT10=0;
    } else {
      pressT5=0;
    }
  } else if(mouseX < width && mouseX>width-150 && mouseY < 290 && mouseY>278) {
    if(pressT6==0) {
      pressT6=1;
      pressT1=pressT2=pressT3=pressT4=pressT5=pressT7=pressT8=pressT9=pressT10=0;
    } else {
      pressT6=0;
    }
  } else if(mouseX < width && mouseX>width-150 && mouseY < 330 && mouseY>318) {
    if(pressT7==0) {
      pressT7=1;
      pressT1=pressT2=pressT3=pressT4=pressT5=pressT6=pressT8=pressT9=pressT10=0;
    } else {
      pressT7=0;
    }
  } else if(mouseX < width && mouseX>width-150 && mouseY < 370 && mouseY>358) {
    if(pressT8==0) {
      pressT8=1;
      pressT1=pressT2=pressT3=pressT4=pressT5=pressT6=pressT7=pressT9=pressT10=0;
    } else {
      pressT8=0;
    }
  } else if(mouseX < width && mouseX>width-150 && mouseY < 410 && mouseY>398) {
    if(pressT9==0) {
      pressT9=1;
      pressT1=pressT2=pressT3=pressT4=pressT5=pressT6=pressT7=pressT8=pressT10=0;
    } else {
      pressT9=0;
    }
  } else if(mouseX < width && mouseX>width-150 && mouseY < 450 && mouseY>438) {
    if(pressT10==0) {
      pressT10=1;
      pressT1=pressT2=pressT3=pressT4=pressT5=pressT6=pressT7=pressT8=pressT9=0;
    } else {
      pressT10=0;
    }
  }
}
