import numpy as np
import matplotlib.pyplot as plt

#función de activación
def sign(v):
    if v >= 0:
        return 1
    else:
        return -1

#formula masa corporal, mas de 25% = 1, sino = -1
# imc = peso / estatura^2
def gordo(p, e):
    imc = p/((e/100)**2)
    if imc > 25:
        return 1
    else:
        return -1

#datos
pes = np.array([62,95,73,59,100,70,67,94,70,105,107,98,73,85,98,72,69,77,60,80,68,103,100,82,62,57,62,75,67,70,62,60,85])
est = (np.array([72,77,85,61,70,68,64,92,70,87,79,78,85,69,85,78,68,72,70,83,86,76,85,80,79,69,69,85,78,89,58,72,83])+100)

ndat = 33
peslim = [55,110]
estlim = [150, 200]
#deseado
tipo = []
for i in range(ndat):
    tipo.append(gordo(pes[i],est[i]))
tipo = np.array(tipo)

xp = np.linspace(peslim[0], peslim[1], 50)
#datos entrenamiento
n = 0.1
w = np.random.rand(3)*20-10 #bias, peso, estatura
cont = 0
prueba = 27

arr = np.random.permutation(ndat)
general = arr[prueba-ndat:]

while cont < prueba:
    plt.clf()
    for i in range(prueba):
        xf = np.array([1, pes[arr[i]], est[arr[i]]])
        e = tipo[arr[i]] - sign(np.sum(xf*w))
        if e:
            w = w + n*e*xf
            cont = 0
        else:
            cont = cont + 1
        #imprimo
        if tipo[arr[i]] == 1:
            color = 'b'
        else:
            color = 'r'
        plt.scatter(pes[arr[i]], est[arr[i]], c=color)
    yp = -(xp*w[1]+w[0])/w[2]
    plt.plot(xp, yp, c='k')
    plt.xlim(peslim[0], peslim[1])
    plt.ylim(estlim[0], estlim[1])
    plt.grid()
    plt.pause(0.01)

print('Pesos finales: ', w)

#pruebo el resultado generalizando
corr = 0
for i in range(6):
    xf = np.array([1, pes[general[i]], est[general[i]]])
    e = tipo[general[i]] - sign(np.sum(xf*w))
    if e:
        es = 'Erroneo'
    else:
        es = 'Correcto'
        corr = corr + 1
    print('datos: peso = {} kg, estatura = {} cm es {} = {}'.format(xf[1], xf[2], tipo[general[i]], es))
    if tipo[general[i]] == 1:
        color = 'g'
        mark = '<'
    else:
        mark = '>'
        color = 'y'
    plt.scatter(pes[general[i]], est[general[i]], c=color, marker=mark)

print("Porcentaje correcto: {} %".format(corr*100/6))

plt.show()
