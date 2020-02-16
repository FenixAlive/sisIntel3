import numpy as np
import matplotlib.pyplot as plt

#función de activacion
def sign(v):
    if v >= 0:
        return 1
    else:
        return -1


#primer grupo: -1 = (1,2), 1 = (0, 3)
#segundo grupo: -1 = (0,1), 1 = (2, 3)
def grupo(g):
    if g == 0:
        return (1, -1)
    elif g == 1:
        return (-1, -1)
    elif g == 2:
        return (-1, 1)
    elif g == 3:
        return (1, 1)


#valores a plotear
x = [[1.4, 1.9, 0.8, 1.0, 1.8],
    [0.8, 0.7, 0.1, -0.4, -0.2],
    [-2.0, -1.4, -0.8, -1.8, -1.5],
    [-0.6, 0.4, 0, 0.3, 0.8]]
y = [[0.2, 0.7, 0.6, 0.8, 1.8],
    [1.6, 1.8, 1.2, 1.8, 0.9],
    [0.8, 0.2, 0.2, -0.6, -1.5],
    [-1.2, -0.6, 0.2, 0.5, -1.4]]

xt = np.array(x)
yt = np.array(y)
fila, col = xt.shape

for i in range(fila):
    plt.scatter(xt[i,:], yt[i,:])
plt.grid()



n = 0.1
w = np.random.rand(3);
cont = 0
i = 0
arr = np.random.permutation( col )
prueba = arr[-1]
entre = col - 1
arr = arr[:-1]

print(arr, prueba)

while cont < entre:
    for d in range(entre):
        for g in range(fila):
            print(xt[g,arr[d]], d, g)
            d1, d2 = grupo(g)
            e1 = d1-sign()
    break


plt.show()
