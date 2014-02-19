#by jinlong yang
#jinlong.yang@mail.sdsu.edu

import json

#Create a list to load the json file
restaurants = []

#Load the json file
#Note, you need to change the work directory
#path to where the json file is
with open('restaurants.json') as f:
    for line in f:
        restaurants.append(json.loads(line))
        
#Create a dict to store all categories and their counts
categories = dict()

for r in restaurants[:]:    
    for c in r["categories"]:
        if c not in categories:
            categories[c] = 1
        else: categories[c] = categories[c] + 1

#Write the dict into a csv
import csv

writer = csv.writer(open('categories.csv', 'w'))
for key, value in categories.items():
   writer.writerow([key, value])