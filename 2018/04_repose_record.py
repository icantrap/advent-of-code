#!/usr/bin/env python3

import re
import numpy as np

with open('04_repose_record.dat', 'r') as file:
    lines = file.read().splitlines()
    
def mark(schedule, id, asleep, awake):
    if id not in schedule:
        schedule[id] = np.zeros(60)
    for minute in range(asleep, awake):
        schedule[id][minute] += 1

schedule = {}

id = -1
asleep = -1
awake = -1
for line in sorted(lines):
    mo = re.search(r'Guard #(\d+)', line)
    if mo:
        id = int(mo.group(1))
    else:
        mo = re.search(r'(\d+)] f', line)
        if mo:
            asleep = int(mo.group(1))
        else:
            mo = re.search(r'(\d+)] w', line)
            if mo:
                awake = int(mo.group(1))
                mark(schedule, id, asleep, awake)

winner = max([(sum(value),key) for key, value in schedule.items()])[1]
time = max([(count, index) for index, count in enumerate(schedule[winner])])[1]

print(f'Part 1. {winner*time}')

# nested comprehension is hard, yo!
max = -1
min = -1
for key,value in schedule.items():
    for minute,count in enumerate(value):
        if count > max:
            max = count
            min = minute
            id = key
            
print(f'Part 2. {id*min}')