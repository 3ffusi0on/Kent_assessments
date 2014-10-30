#!/usr/bin/env python

import matplotlib.pyplot as plt
import math
import sys, random

a = 100
b = 10
c = 100
rate_ka = 1.0
rate_kb = 1.0
rate_da = 1.0
rate_db = 1.0
K_a = 1.0
K_b = 1.0
h = 1.0
l = 1.0

def calc_propensity(x, k):
    propensity = x * k
    return propensity

P_one = calc_propensity(c, rate_kb * ((math.pow(a, h) * K_b) / ( (K_a + math.pow(a, h) * (K_b + math.pow(b, l)) ) )))
P_two = calc_propensity(b, rate_db)
P_three = calc_propensity(c, rate_ka * ((math.pow(b, l) * K_a) / ( (K_a + math.pow(a, h) * (K_b + math.pow(b, l)) ) )))
P_four = calc_propensity(a, rate_da)
P = P_one + P_two + P_three + P_four


tabA = []
tabB = []
tabC = []
axeX = []
time = 0.0

for i in range(0, 300):
    time = time + (-(1 / P) * math.log(random.random()))
    axeX.append(time)


    r = random.random()
    if r >= 0.0 and r < P_one / P:
        c -= 1
        b += 1
    elif r >= P_one / P and r < (P_one + P_two) / P:
        b -= 1
        c += 1
    elif r >= (P_one + P_two) / P and r < (P_one + P_two + P_three) / P:
        c -= 1
        a += 1
    else:
        a -= 1
        c += 1

    P_one = calc_propensity(c, rate_kb * ((math.pow(a, h) * K_b) / ( (K_a + math.pow(a, h) * (K_b + math.pow(b, l)) ) )))
    P_two = calc_propensity(b, rate_db)
    P_three = calc_propensity(c, rate_ka * ((math.pow(b, l) * K_a) / ( (K_a + math.pow(a, h) * (K_b + math.pow(b, l)) ) )))
    P_four = calc_propensity(a, rate_da)
    P = P_one + P_two + P_three + P_four

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
