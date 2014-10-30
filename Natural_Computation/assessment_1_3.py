#!/usr/bin/env python

import matplotlib.pyplot as plt
import math
import sys, random


a = 1
b = 1
c = 1
rate_ka = 0.0
rate_kb = 0.0
rate_kc = 1.0

P_one = a * b * rate_kc
P_two = rate_ka
P_three = rate_kb
P = P_one + P_two + P_three


tabA = []
tabB = []
tabC = []
axeX = []
time = 0.0

for i in range(0, 300):
    time = time + (-(1 / P) * math.log(random.random()))
    axeX.append(time)


    r = random.random()
    tabA.append(a)
    tabB.append(b)
    tabC.append(c)



##Draw Graph
plt.plot(axeX, tabA, label="Particule A")
plt.plot(axeX, tabB, label="Particule B")
plt.plot(axeX, tabC, label="Particule C")
plt.ylabel('Particules A and B and C')
plt.xlabel('Time')
plt.legend()
plt.show()
