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

xp = np.linspace(-3, 3, 50)
#datos entrenamiento
n = 0.2
w1 = np.random.rand(3);#bias,x,y
w2 = np.random.rand(3);
cont = 0
arr = np.random.permutation( col )


while cont < col*fila:
    for d in range(col):
        for g in range(fila):
            xf = np.array([1, xt[g, arr[d]], yt[g, arr[d]]])
            d1, d2 = grupo(g)
            e1 = d1 - sign(np.sum(xf*w1))
            e2 = d2 - sign(np.sum(xf*w2))
            if e1:
                w1 = w1 + n*e1*xf
                cont = 0
            if e2:
                w2 = w2 + n*e2*xf
                cont = 0
            if not e1 and not e2:
                cont = cont + 1
        #imprimir plot
        plt.clf()
        for i in range(fila):
            plt.scatter(xt[i,:], yt[i,:])
        plt.grid()
        yp1 = -(xp*w1[1]+w1[0])/w1[2]
        plt.plot(xp, yp1, c='k')
        yp2 = -(xp*w2[1]+w2[0])/w2[2]
        plt.plot(xp, yp2, c='k')
        plt.xlim(-3,3)
        plt.ylim(-4,4)
        plt.pause(0.01)

print('Pesos Finales: ')
print('Primer perceptrón: ', w1)
print('Segundo Perceptrón: ', w2)

yp1 = -(xp*w1[1]+w1[0])/w1[2]
plt.plot(xp, yp1, c='k')

yp2 = -(xp*w2[1]+w2[0])/w2[2]
plt.plot(xp, yp2, c='k')


plt.show()
