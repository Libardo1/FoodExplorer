#by jinlong yang
#jinlong.yang@mail.sdsu.edu

import nltk
import json

#Load the json file
#Note, you need to change the work directory
#path to where the json file is
review_data = []
with open('yelp_academic_dataset_review.json') as f:
    for line in f:
        review_data.append(json.loads(line))

output = dict()
count = 1

for review in review_data[:1000]:
    text = nltk.word_tokenize(review["text"])
    pos = nltk.pos_tag(text)
    adjs = dict()
    for word in pos:
        if word[1] == "JJ" and word[0] not in adjs:
            adjs[word[0]] = 1
        else:
            if word[1] == "JJ" and word[0] in adjs:
                adjs[word[0]] = adjs[word[0]] + 1
    count = count + 1
    print(count)
    print(adjs)
        
    for word, count in adjs.items():
        if word not in output:
            output[word] = [[review["review_id"],
                            review["business_id"], 
                            review["stars"],
                            count]]

        if word in output:
            output[word].append([review["review_id"],
                                 review["business_id"], 
                                 review["stars"],
                                 count])
                                                            
#print(output)
#print(len(output))
#print(output["unhappy"][0])