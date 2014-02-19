#by jinlong yang
#jinlong.yang@mail.sdsu.edu

import nltk
import json

#Load the json file
#Note, you need to change the work directory
#path to where the json file is
reviews = []
with open('restaurant_reviews.json') as f:
    for line in f:
        reviews.append(json.loads(line))

#Create a list for restaurant info
restaurants = []

with open('restaurants.json') as f:
    for line in f:
        restaurants.append(json.loads(line))

#Define 10 food types
food_types = ["mexican", "american", "pizza", 
              "sandwiches", "chinese", "italian",
              "burgers", "japanese", "buffets", 
              "steakhouses", "other"]

#Create a dict for all business ids for each type of food
#Each value in the dict is a list
id_list = {}
for f in food_types:
    id_list[f] = []


#Define a look up for restaurant types
def search_id(x):
    return {
        'Mexican': "mexican",
        'American (Traditional)': "american",
        'American (New)': "american",
        "Pizza": "pizza",
        "Sandwiches": "sandwiches",
        "Chinese": "chinese",
        "Italian": "italian",
        "Burgers": "burgers",
        "Japanese": "japanese",
        "Sushi Bars": "japanese",
        "Buffets": "buffets",
        "Steakhouses": "steakhouses"
        }.get(x, "other")

#Extract all ids for each type of food
for r in restaurants:
    for c in r["categories"]:
        id_list[search_id(c)].append(r["business_id"])
        
#Delete the "other" key
id_list.pop("other", None)
food_types.pop(-1)

#Create a term dict: [food][term][business_id: count]
term_dicts = {}
for f in food_types:
    term_dicts[f] = {}

#Create a term count dict: [food][term: count]
term_counts = {}
for f in food_types:
    term_counts[f] = {}

#Counter for processing   
count = 1

#Iterate all reviews and fill in term_dicts and term_counts
for r in reviews:
    for f in food_types:
        if r["business_id"] in id_list[f]:
            food = f
            break
        else:
            food = ""
    if food != "":
        text = nltk.word_tokenize(r["text"])
        pos = nltk.pos_tag(text)
        for tagged in pos:
            term = tagged[0].lower()
            if term.isalpha() and tagged[1] == "JJ":
                if term in term_dicts[food]:
                    term_counts[food][term] = term_counts[food][term] + 1
                    if r["business_id"] in term_dicts[food][term]:
                        term_dicts[food][term][r["business_id"]] = term_dicts[food][term][r["business_id"]] + 1
                    else: term_dicts[food][term][r["business_id"]] = 1
                else:
                    term_dicts[food][term] = {}
                    term_dicts[food][term][r["business_id"]] = 1
                    term_counts[food][term] = 1
                        
    count = count + 1
    print(count)
    
   
#Save meta-data
with open('term_dicts_meta.json', 'w') as outfile:
    json.dump(term_dicts, outfile)

with open('term_counts_meta.json', 'w') as outfile:
    json.dump(term_counts, outfile)
    

#Sort out and subset the top terms and top restaurants
term_counts_selected = {}
import operator
for f in term_counts:
    term_counts_selected[f] = dict(sorted(term_counts[f].iteritems(), key=operator.itemgetter(1), reverse=True)[:20])

term_dicts_filtered = {}

for f in term_dicts:
    term_dicts_filtered[f] = {}
    for t in term_counts_selected[f]:
        term_dicts_filtered[f][t] = dict(sorted(term_dicts[f][t].iteritems(), key=operator.itemgetter(1), reverse=True)[:25])
        
#Create a json for relevant restaurants
relevant_restaurants = {}

relevant_ids = []
for f in term_dicts_filtered:
    for t in term_dicts_filtered[f]:
        for k, v in term_dicts_filtered[f][t].items():
            #print(k)
            relevant_ids.append(k)

for r in restaurants:
    if r["business_id"] in relevant_ids:
        relevant_restaurants[r["business_id"]] = {}
        relevant_restaurants[r["business_id"]]["name"] = r["name"]
        relevant_restaurants[r["business_id"]]["review_count"] = r["review_count"]
        relevant_restaurants[r["business_id"]]["full_address"] = r["full_address"]
        relevant_restaurants[r["business_id"]]["longitude"] = r["longitude"]
        relevant_restaurants[r["business_id"]]["stars"] = r["stars"]
        relevant_restaurants[r["business_id"]]["latitude"] = r["latitude"]
    
#Write the json files
with open('term_dicts.json', 'w') as outfile:
    json.dump(term_dicts_filtered, outfile)

with open('term_counts.json', 'w') as outfile:
    outfile.write("[")
    json.dump(term_counts_selected, outfile)
    outfile.write("]")
    
with open("relevant_restaurants.json", "w") as outfile:
    outfile.write("[")
    json.dump(relevant_restaurants, outfile)
    outfile.write("]")
    
#relevant_restaurants["glalhJa7wFWPIoJLBvKGfQ"]