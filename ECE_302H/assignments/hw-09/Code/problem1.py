import numpy as np
import matplotlib.pyplot as plt

x = np.arange(-20, 24, 4)
y = x**2
y2 = 200 - 3*x

plt.title('ECE302 HW1 Problem 1 - Exploring Python')
plt.xlabel('X Axis (Units)')
plt.ylabel('Y Axis (Units)')
plt.legend()

plt.plot(x, y, label='Quadratic - Rough')
plt.plot(x, y2, label='Linear')
