%Actividad 6 red multicapa
%% datos
clc
clear
close all
%entrada y bias
data = [0 1 0 1; 0 0 1 1];
%resultado deseado
des = [0 1 1 0]; 
% grafico datos originales
forec = ['bo';'ro'];
figure()
hold on
for i=1:4
    plot(data(1,i),data(2,i), forec(des(i)+1,:), 'LineWidth', 3);
end
title("Representacion compuerta XOR con entradas A, B, azul 0, rojo 1")
xlabel('A');
ylabel('B');
grid on;
%% preparo red
%% funcion activacion
%rapidez de la curva
a = 1;
%logistica
logis = @(v) 1 ./ (1+exp(-a.*v));
%derivada de logística entra en 'y' la salida ya pasada por la logistica
dlogis = @(y) a.*y.*(1-y);
% derivada función lineal
derlin = [1 1 1 1];
%capa oculta, fila neuronas, columnas datos de entrada
%|_woc_|_A_|_B_| *noi=neurona oculta numero
%| no1 |1,1|1,2| 
%| no2 |2,1|2,2|
%|_no3_|3,1|3,2|
wj = rand(3,2);
bj = rand(3,1);
%capa de salida, 1 neurona de salida, 4 de entrada con el bias
%|_wfin_|_no1_|_no2_|_no3_| *noi= neurona oculta numero
%|__ns__|_1,1_|_1,2_|_1,3_| *ns= neurona de salida
wk = rand(1,3);
bk = rand();

n = 0.05;

iter = 10000;
%% inicia algoritmo de entrenamiento por lotes
for gen=1:iter
    % salidas
    % w = 3x2, x = 2x4, b = 3*4
    yj = logis(wj*data+[bj bj bj bj]);
    yk = wk*yj+[bk bk bk bk];
    %error
    error = des - yk;
    dk = error.*derlin;
    %actualizar pesos
    derj = dlogis(yj);
    wdk = wk'*dk;
    wj = wj + n*derj.*wdk*data';
    bj = bj + n*derj.*wdk*[1;1;1;1];
    
    wk = wk + n*dk * yj';
    bk = bk + n*dk*[1;1;1;1];
end

fprintf("\n\nError final: %.12f", sum(error)/4);
fprintf("\n\nPesos capa oculta: ");
fprintf("\n|_woc_|___A____|___B____|\n| No1 | %.4f | %.4f |\n| No2 | %.4f | %.4f |\n|_No3_| %.4f | %.4f | ", wj(1,1), wj(1,2),wj(2,1), wj(2,2),wj(3,1),wj(3,2));
fprintf("\n\n Bias Capa Oculta: ");
fprintf("\n No1 = %.4f, No2= %.4f, No3 = %.4f", bj(1), bj(2),bj(3));

fprintf("\n\nPesos capa de salida: ")
fprintf("\n|_wfin_|__No1___|__No2___|__No3___| *Noi= neurona oculta numero\n|__Ns__| %.4f | %.4f | %.4f | *Ns= neurona de salida", wk(1), wk(2), wk(3));
fprintf("\n\n Bias capa de Salida: Ns = %.4f", bk)

%grafico los puntos
backc = ['c+';'m+'];
for xp=-0.2:0.04:1.2
    for yp=-0.2:0.04:1.2
        yt = logis(wj*[xp;yp]+bj);
        yft = wk*yt+bk;
        rest = umbral(yft);
        plot(xp,yp,backc(rest+1,:))
    end
end

%% probar con puntos con ruido
datos = 8;
ndata = [data data]+(rand(2,datos)-0.5)/2;
yj = logis(wj*ndata+bj);
yk = wk*yj+bk;
res = umbral(yk);

fprintf("\n\n Nuevo entrenamiento: ")
fprintf("\n|_n_|___A____|___B____|_S_| *n=numero de dato, *s = salida de la red")
for i = 1:datos
    fprintf("\n| %d | %.4f | %.4f | %d |", i, ndata(1,i), ndata(2,i), res(i))
end
fprintf("\n")


function s = umbral(d)
    t = length(d);
    s =zeros(1,t);
    for i = 1:t
        if d(i) > .5
            s(i) = 1;
        else
            s(i) = 0;
        end
    end
end