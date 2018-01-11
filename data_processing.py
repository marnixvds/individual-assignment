# -*- coding: utf-8 -*-
"""
Created on Thu Jan 11 12:45:44 2018

@author: marni
"""

# Import the JSON and CSV packages
import json
import csv

# Load in the conflict JSON data
with open('conflict_sample.json') as file:
    data = json.load(file)

data_kenya = []
#Start selection process
#Select for country: 'Kenya'
for item in range(len(data)):
    if data[item]['country'] == 'Turkey' & data[item]['date_start'] > '1998-05-10':
        data_kenya.append(data[item])


## Open the output CSV file we want to write to
#with open('preprocessed_data.csv', 'w', newline='') as file:
#    csvwriter = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_NONNUMERIC)
#    
#    csvwriter.writerow(['Country', 'Column A', 'Column B', 'Column C', 'etc.'])
#    # Actually write the data to the CSV file here.
#    # You can use the same csvwriter.writerow command to output the data 
#    #   as is used above to output the headers.