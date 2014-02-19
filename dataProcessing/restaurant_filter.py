#by jinlong yang
#jinlong.yang@mail.sdsu.edu

import json

#Create a list to load the json file
business_data = []

#Load the json file
#Note, you need to change the work directory
#path to where the json file is
with open('yelp_academic_dataset_business.json') as f:
    for line in f:
        business_data.append(json.loads(line))

#Create a list to store all restaurant jsons and
#another for business ids of restaurants for future look-up
restaurants = []
business_id_list = []

#Subset all restaurant jsons and their business ids
for business in business_data:
    if "Restaurants" in business["categories"]:
        restaurants.append(business)
        business_id_list.append(business["business_id"])

#Save the subset of restaurant json file
with open('restaurants.json', 'w') as outfile:
  for r in restaurants:
      json.dump(r, outfile)
      outfile.write("\n")

#Create a list to load the json file
review_data = []

#Load the json file
#Note, you need to change the work directory
#path to where the json file is
with open('yelp_academic_dataset_review.json') as f:
    for line in f:
        review_data.append(json.loads(line))

#Create a list to store all restaurant review jsons
restaurants_reviews = []

#Subset restaurant review jsons
for review in review_data:
    if review["business_id"] in business_id_list:
        restaurants_reviews.append(review)

#Save the subset of restaurant json file
with open('restaurant_reviews.json', 'w') as outfile:
    for r in restaurants_reviews:
        json.dump(r, outfile)
        outfile.write("\n")