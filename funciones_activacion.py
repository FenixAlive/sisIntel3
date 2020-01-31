# elaborado por Luis Angel Muñoz Franco
import numpy as np
import matplotlib.pyplot as plt
from math import exp


# declaro funciones
def escalon(x):
    res = []
    for i in x:
        if i < 0:
            res.append(0)
        else:
            res.append(1)
    return res


def lineal_tramos(x):
    res = []
    for v in x:
        if v <= 0:
            res.append(0)
        elif v >= 1:
            res.append(1)
        else:
            res.append(v)
    return res


def sigmoidal(x):
    a = 2
    res = []
    for v in x:
        res.append(1/(1+exp(-a*v)))
    return res


def signo(x):
    res = []
    for v in x:
        if v < 0:
            res.append(-1)
        elif v > 0:
            res.append(1)
        else:
            res.append(0)
    return res


def lineal(x):
    A = 1
    res = []
    for v in x:
        res.append(A*v)
    return res


def gaussiana(x):
    A = 1
    B = 3
    res = []
    for v in x:
        res.append(A*exp(-B*v**2))
    return res


def sinusoidal(x):
    A = 3
    B = 2
    C = 1
    return A*np.sin(B*x+C)


def leaky_relu(x):
    res = []
    for v in x:
        if v < 0:
            res.append(0.01*v)
        else:
            res.append(v)
    return res


def main():
    # declaro espacio de la variable independiente
    x = np.linspace(-3, 3, 100)

    # ploteo
    print("\n\t Funciones de Activación: ")
    print("\n1-Escalón")
    print("2-Lineal a tramos")
    print("3-Sigmoidal")
    print("4-Signo")
    print("5-Lineal")
    print("6-Gaussiana")
    print("7-Sinusoidal")
    print("8-Leaky ReLU (Personal)")
    opc = input("\nElige una del 1 al 8: ")
    if opc == "1":
        plt.plot(x, escalon(x))
    elif opc == "2":
        plt.plot(x, lineal_tramos(x))
    elif opc == "3":
        plt.plot(x, sigmoidal(x))
    elif opc == "4":
        plt.plot(x, signo(x))
    elif opc == "5":
        plt.plot(x, lineal(x))
    elif opc == "6":
        plt.plot(x, gaussiana(x))
    elif opc == "7":
        plt.plot(x, sinusoidal(x))
    elif opc == "8":
        plt.plot(x, leaky_relu(x))

    plt.show()


if __name__ == "__main__":
    main()
