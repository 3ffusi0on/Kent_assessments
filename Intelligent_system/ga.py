#!/bin/env python3.4

import matplotlib.pyplot as plt
import math
import sys, random
import numpy as np

random.seed(12)

class GA:
    def __init__(self):
        self.population_size = 250
        self.population = []
        self.l_x = []
        self.l_y = []
        self.l_error = []
        self.next_gen = []
        self.nb_to_keep = 0

    def mutation(self, unit):
        new_unit = unit[:]
        new_unit[random.randrange(0, 5)] = float(random.randrange(-10000, 10000))
        return new_unit

    def crossover(self, unitA, unitB):
        new_unit = unitB[:]
        nb = random.randrange(1, 4)
        for i in range(0, nb):
            new_unit[i] = unitA[i]
        return new_unit

    def individual(self):
        indi = [float(random.randrange(-5000, 5000)), #a
                float(random.randrange(-5000, 5000)), #b
                float(random.randrange(-5000, 5000)), #c
                float(random.randrange(-5000, 5000)), #d
                float(random.randrange(-5000, 5000)), #e
                float(random.randrange(-5000, 5000))] #f
        return indi

    def open_file(self):
        """open and read the file + fill list with X,Y pair"""
        lines = [line.strip() for line in open('datfile.dat')]
        for l in lines:
            pair = l.split()
            if len(pair) > 1:
                self.l_x.append(float(pair[0]))
                self.l_y.append(float(pair[1]))

    def first_gen(self):
        """1st Generation (ex: [2, 4, 5, 123, 34, 9] * N  individuals)"""
        for i in range(0, self.population_size):
            #TODO make a random choice for every random function
            indi = self.individual()
            self.population.append(indi)

    def evaluation(self):
        """create list of errors"""
        self.l_error = []
        for indi in self.population:
            error = 0.
            for i in range(0, len(self.l_x)):
                f_x = indi[0] \
                + indi[1] * self.l_x[i] \
                + pow(indi[2], 2) * self.l_x[i] \
                + pow(indi[3], 3) * self.l_x[i] \
                + pow(indi[4], 4) * self.l_x[i] \
                + pow(indi[5], 5) * self.l_x[i]
                error = error + math.fabs(self.l_y[i] - f_x)
            self.l_error.append(error)

    def selection(self):
        """select the best individuals"""
        self.nb_to_keep = int(self.population_size * 0.20)
        for i in range(0, self.nb_to_keep):
            min_val = min(self.l_error)
            index = self.l_error.index(min_val)
            self.next_gen.append(self.population[index])

    def modification(self):
        """Mutatikon & crossover & new individual"""
        nb_to_create = self.population_size - self.nb_to_keep
        for i in range(0, nb_to_create):
            nb = random.random()
            #50% chance to crossover two individual
            if (nb <= 0.5):
                n1 = random.randrange(0, self.nb_to_keep)
                n2 = random.randrange(0, self.nb_to_keep)
                new_indi = self.crossover(self.population[n1], self.population[n2])
            #25% to mutate one individual
            elif (nb <= 0.75):
                new_indi = self.mutation(self.population[random.randrange(0, self.nb_to_keep)])
            #25% to create a new random individual
            else:
                new_indi = self.individual()
            self.next_gen.append(new_indi)

    def run(self):
        """Run the GA"""
        self.open_file()
        self.first_gen()
        min_val = 0
        while True:
            self.next_gen = []
            self.evaluation()
            self.selection()
            self.modification()
            tmp = min(self.l_error)
            if (tmp != min_val):
                min_val = tmp
                index = self.l_error.index(min_val)
                print("Min:", min_val, self.population[index])
            self.population = self.next_gen

    def graph(self, a,b,c,d,e,f):
        """draw the grap"""
        x = np.array(range(-25, 925))
        y = eval(str(a)+'+'\
                +str(b)+'*x+'\
                +str(c)+'*x**2+'\
                +str(d)+'*x**3+'\
                +str(e)+'*x**4+'\
                +str(f)+'*x**5')
        plt.plot(x, y)
        plt.show()

#Start the program
Gen_algo = GA()
#Gen_algo.run()
Gen_algo.graph(-10000, 7699, -9397, 342, 0.00234, 0.033)
