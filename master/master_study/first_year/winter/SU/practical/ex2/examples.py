import numpy as np
import matplotlib.pyplot as plt

A = np.arange(50)
A[::2] # pouze sude prvky

# jednicky na diagonale (bez eye() / diag())
order = 5
W = np.zeros(order * order)
W[::order+1] = 1
np.reshape(W, [5, 5])

V = np.arange(50)
np.reshape(V, [5, 10])
V.T #transponovani

B = np.random.uniform(size=[10, 5])
#avg = np.sum(B, 0)
avg = np.average(B, 0)

B[B < avg] = 0

x = np.linspace(0, 10)
y = np.sin(x)

plt.plot(x, y) # napojí se na poslední vizualizační okno
# (v případě, že žádné neexistuje, vytvoří ho) a vykreslí do něj xy graf.
#np.linspace(min, max, granularity)
#plt.hist(x) # opět do posledního okna vykreslí histogram.
#plt.figure() # vytvoří nové vizualizační okno.
#plt.show()
#plt.title()
#plt.xlabel()
#plt.ylabel()
#plt.legend()
#plt.axis(xMin, xMax, yMin, yMax)