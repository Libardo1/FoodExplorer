

String[] restaurantIDToRestaurantInfo(processing.data.JSONObject restaurants, String[] restaurantIDs) {
  //Get the lon/lat and other info of restaurants list above

  String[] restaurantInfo = new String[0];
  for (int i = 0; i < restaurantIDs.length; i++) {
    processing.data.JSONObject oneRestaurant = restaurants.getJSONObject(restaurantIDs[i]);
    restaurantInfo = append(restaurantInfo, oneRestaurant.getString("name"));
    restaurantInfo = append(restaurantInfo, Float.toString(oneRestaurant.getFloat("longitude")));
    restaurantInfo = append(restaurantInfo, Float.toString(oneRestaurant.getFloat("latitude")));
    restaurantInfo = append(restaurantInfo, Integer.toString(oneRestaurant.getInt("review_count")));
    restaurantInfo = append(restaurantInfo, Float.toString(oneRestaurant.getFloat("stars")));
    restaurantInfo = append(restaurantInfo, oneRestaurant.getString("full_address"));
  }

  return restaurantInfo;
}

String[] termToRestaurantIDs(String[] allTerms, int termIndex, String food){
  String keyword = allTerms[termIndex];
  //println(keyword);
  
  //Extract of the dict of the keyword
  processing.data.JSONObject keywordJSON = termDicts.getJSONObject(food).getJSONObject(keyword);
  //println(keywordJSON);
  
  //List all top business for a term  
  String [] allRestaurantIDs = new String[0];
  for(int i = 0; i < keywordJSON.keys().size(); i++){
    allRestaurantIDs = append(allRestaurantIDs, keywordJSON.keys().toArray()[i].toString());
  }
  
  return allRestaurantIDs;
}

void MapRestarauntData(String[] restarauntInfo) {
  mM.clearMarkers();
  for (int i=0; i<restarauntInfo.length;i=i+6) {
    try {
      Location loca= new Location(float(restarauntInfo[i+2]), float(restarauntInfo[i+1]));
    //println(restarauntInfo[i+2]);
      loc.add(loca);
      String restName = restarauntInfo[i];
      String restAddress = restarauntInfo[i+5];
      float restRating = float(restarauntInfo[i+4]);
      int restReviewCount = int(restarauntInfo[i+3]);
      PMarker pm = new PMarker(loca, restName, restAddress, restRating, restReviewCount);
      mM.addMarker(pm);
    }
    catch(Exception e) {
      println("failure in MapRestarauntData");
    }
  }
  map.addMarkerManager(mM);
}
