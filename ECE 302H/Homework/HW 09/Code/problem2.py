#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov  5 19:47:47 2025

@author: dawson
"""

import numpy as np
import matplotlib.pyplot as plt

INFINITY = 1000
STEP = 0.001

x = np.arange(-3 * np.pi, 3 * np.pi, STEP)

y = ((x + np.pi) % (2 * np.pi)) - np.pi
    
y2 = 2 * (-1) ** (1 + 1) * (1 / 1) * np.sin(1 * x)

y3 = 0
for n in range(1, 4):
    y3 += 2 * (-1) ** (n + 1) * (1 / n) * np.sin(n * x)
    
y4 = 0
for n in range(1, 11):
    y4 += 2 * (-1) ** (n + 1) * (1 / n) * np.sin(n * x)
    
fig, axes = plt.subplots(1, constrained_layout=True)

fig.suptitle('ECE302 HW9 Problem 2 - Fourier Series Plotting')

axes.plot(x, y, label='Sawtooth')
axes.plot(x, y2, label='Fundamental')
axes.plot(x, y3, label='Sum of first 3 harmonics')
axes.plot(x, y4, label='Sum of first 10 harmonics')
axes.set_xlabel('Angular Displacement (rad)')
axes.set_ylabel('Amplitude')
axes.legend()


x = np.arange(1, 11)
y = np.abs(2 * (-1 ** (x + 1)) * (1 / x))
y2 = []

for n in range(1, 11):
    if n % 2 == 0:
        y2.append(np.pi)
    else:
        y2.append(0)

fig, axes = plt.subplots(2, constrained_layout=True)

fig.suptitle('ECE302 HW9 Problem 2 - Fourier Series 10th Harmonic Frequency Domain')

axes[0].stem(x, y)
axes[0].set_xscale('log')
axes[0].set_yscale('log')
axes[0].set_title('Magnitude vs. Angular Frequency')
axes[0].set_xlabel('Angular Frequency (log)')
axes[0].set_ylabel('Magnitude (log)')

axes[1].stem(x, y2)
axes[1].set_xscale('log')
axes[1].set_title('Phase vs. Angular Frequency')
axes[1].set_xlabel('Angular Frequency (log)')
axes[1].set_ylabel('Phase')