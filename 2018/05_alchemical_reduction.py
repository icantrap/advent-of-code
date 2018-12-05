#!/usr/bin/env python3

import pdb

with open('05_alchemical_reduction.dat', 'r') as file:
    lines = file.read().splitlines()

formula = list(lines[0])

def react(formula):
    polymer = []

    for rhs in formula:
        if len(polymer) < 1:
            polymer += rhs
        else:
            lhs = polymer[-1]

            if lhs != rhs and lhs.upper() == rhs.upper():
                polymer.pop()
            else:
                polymer += rhs

    return polymer

polymer = react(formula)
print(f'Part 1. {len(polymer)}')

from string import ascii_lowercase

# nested comprehension!!!
# inner: take the polymer and remove all the elements that match the target
# outer: do the inner for each letter, run it through #react and find the length
answer = min(len(react([ch for ch in polymer if ch.lower() != target])) for target in ascii_lowercase)
print(f'Part 2. {answer}')
# was it worth it? not sure