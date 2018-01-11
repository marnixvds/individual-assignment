# -*- coding: utf-8 -*-
"""
Created on Thu Jan 11 12:45:44 2018

@author: marni
"""

# Import the JSON and CSV packages
import json
import csv
from datetime import datetime

# Load in the conflict JSON data
with open('conflict_sample.json') as file:
    data = json.load(file)

#Create a new library for all the data of interest
data_kenya = []
#Indicate the columns that I might use in my analysis, and skip the rest of the columns.
interesting_columns = {'id', 'year', 'type_of_violence', 'dyad_name', 'latitude', 'longitude', 'date_start', 'date_end', 'best'}
#Start selection process
#Select for country: 'Kenya'
for item in range(len(data)): #Loop over all items
    data[item]['date_start'] = datetime.strptime(data[item]['date_start'], '%Y-%m-%dT%H:%M:%S') #Format the dates correctly, so I can select them later
    data[item]['date_end'] = datetime.strptime(data[item]['date_end'], '%Y-%m-%dT%H:%M:%S')
    #If the country corresponds to Kenya, and the date is in between the range of interest
    if (data[item]['country'] == 'Turkey') & (data[item]['date_start'] >= datetime(1998, 5, 11)) & (data[item]['date_start'] < datetime(1999, 5, 11)) :
        data_kenya.append({ key:value for key,value in data[item].items() if key in interesting_columns })


# Open the output CSV file we want to write to
with open('preprocessed_data.csv', 'w', newline='') as file:
    csvwriter = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_NONNUMERIC)
    
    csvwriter.writerow(['id', 'year', 'type_of_violence', 'dyad_name', 'latitude', 'longitude', 'date_start', 'date_end', 'best'])
    for item in range(len(data_kenya)):
        csvwriter.writerow(data_kenya[item].values())
    # Actually write the data to the CSV file here.
    # You can use the same csvwriter.writerow command to output the data 
    #   as is used above to output the headers.