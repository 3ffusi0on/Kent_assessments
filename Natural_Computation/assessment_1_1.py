#!/usr/bin/env python

import matplotlib.pyplot as plt
import math
import sys, random

#User input
if len(sys.argv) !=  4:
    print("Usage: %s <amount of A> <amount of B> <rate>", sys.argv[0])
    sys.exit()

a = float(sys.argv[1])
b = float(sys.argv[2])
rate = float(sys.argv[3])

def calc_propensity():
    propensity = a * b * rate
    return propensity

tabA = []
tabB = []
axeX = []
propensity = calc_propensity()
time = 0.0

while propensity > 0.0:
    time = time + (-(1 / propensity) * math.log(random.random()))
    axeX.append(time)
    a -= 1
    propensity = calc_propensity()

    #Normalization
    Na = a / (a + b)
    Nb = b / (a + b)

    tabA.append(Na)
    tabB.append(Nb)
    print(propensity)

#Draw Graph
plt.plot(axeX, tabA, label="Particule A")
plt.plot(axeX, tabB, label="Particule B")
plt.ylabel('Normalized Particules A and B')
plt.xlabel('Time')
plt.legend()
plt.show()
