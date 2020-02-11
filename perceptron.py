from mpl_toolkits import mplot3d
import numpy as np
import matplotlib.pyplot as plt


#función de activacion
def sign(v):
    if v >= 0:
        return 1
    else:
        return -1


#inicializo grafica
fig = plt.figure()
ax = plt.axes(projection='3d')

#creo la tabla de verdad
tabla = []

for A in range(2):
    for B in range(2):
        for C in range(2):
            if not ((A or B) and C):
                tabla.append([A, B, C, 1])
            else:
                tabla.append([A, B, C, -1])

ntabla = np.array(tabla)
print("Tabla de Verdad:")
print(ntabla)


fila, col = ntabla.shape

#dibujar linea
xline=np.linspace(-0.5,1.5,20)
A, B = np.meshgrid(xline, xline)


#quito el resultado y en la ultima fila pongo el bias
xtabla = np.hstack((ntabla[:,:-1], np.ones((fila,1),'int')))

#creo pesos random
w = np.random.rand(4)

#entrenamiento
cont = 0
i = 0
n = 0.1
arr = np.random.permutation(fila)

while cont != fila:
    e = ntabla[arr[i],-1]-sign(np.sum(w*xtabla[arr[i],:]))
    if e:
        w = w + n*e*xtabla[arr[i],:]
        cont = 0
    else:
        cont = cont + 1
    i = i+1
    if i >= fila:
        i = 0
    #grafico en cada iteracion
    plt.clf()
    ax = plt.axes(projection='3d')
    for j in range(fila):
        if ntabla[j,3] == 1:
            ax.scatter3D(ntabla[j,0], ntabla[j,1], ntabla[j,2], c='r', marker='<')
        else:
            ax.scatter3D(ntabla[j,0], ntabla[j,1], ntabla[j,2], c='b', marker='o')
    C = (-w[0]*A-w[1]*B-w[3])/w[2]
    ax.plot_wireframe(A, B, C, color='grey')
    ax.set_xlim(-0.5, 1.5)
    ax.set_ylim(-0.5, 1.5)
    ax.set_zlim(-0.5, 1.5)
    plt.pause(0.01)

print("Pesos Finales:")
print(w)

#pruebas con ruido
prueba = np.hstack((xtabla[:,0:-1]+(np.random.rand(8,3)-0.5)/3, np.ones((fila,1),'int')))
aci=0
como_es = ""
for j in range(fila):
    res = sign(np.sum(w*prueba[j,:]))
    e = ntabla[j,-1] - res
    if e == 0:
        aci = aci + 1
        como_es = "Correcto"
    else:
        como_es = "Erroneo"
    print("Valores: A: {0:0.4f}, B: {1:0.4f}, C: {2:0.4f} = {3} es {4}".format(prueba[j,0], prueba[j,1], prueba[j,2], res, como_es))

    if ntabla[j,3] == 1:
        ax.scatter3D(prueba[j,0], prueba[j,1], prueba[j,2], c='y', marker='<')
    else:
        ax.scatter3D(prueba[j,0], prueba[j,1], prueba[j,2], c='g', marker='o')
print("Porcentaje correcto = {} %".format(aci*100/fila))
plt.show()
