#!/usr/bin/env python3

import re
from collections import Counter

with open('03_no_matter_how_you_slice_it.dat', 'r') as file:
    lines = file.read().splitlines()

def inches(spec):
     mo = re.match(r'#.* @ (\d+),(\d+): (\d+)x(\d+)', spec)
     left, top, width, height = int(mo.group(1)), int(mo.group(2)), int(mo.group(3)), int(mo.group(4))
     for x in range(left, left+width):
         for y in range(top, top+height):
             yield x,y
             
grid = Counter()

for line in lines:
    grid.update(inches(line))
 
count = len({ key: value for key, value in grid.items() if value > 1 })
print(f'Part 1: {count}')

def named_inches(spec):
     mo = re.match(r'#(.*) @ (\d+),(\d+): (\d+)x(\d+)', spec)
     id, left, top, width, height = mo.group(1), int(mo.group(2)), int(mo.group(3)), int(mo.group(4)), int(mo.group(5))
     for x in range(left, left+width):
         for y in range(top, top+height):
             yield id, (x,y)

grid = {}
ids = set()

for line in lines:
    for location in named_inches(line):
        id, point = str(location[0]), location[1]
        ids.add(id)
        if point in grid:
            grid[point] += ','
            grid[point] += id
        else:
            grid[point] = id
            
for key, value in grid.items():
    if ',' in value:
        for id in value.split(','):
            if id in ids:
                ids.remove(id)
                
print(f'Part 2: {ids.pop()}')

# Upon reflection, I could have combined #inches and #named_inches and transformed the output depending on what was
# needed.
