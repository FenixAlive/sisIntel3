% Adalaine, regresion lineal
%estocastico
close all
clear
%% datos

data = [50.0000  100.0000  200.0000  250.0000  300.0000  350.0000  400.0000  425.0000  475.0000  500.0000  600.0000  650.0000  750.0000 800.0000  850.0000  900.0000  950.0000  100.0000;...
    0.1500    0.2000    0.2250    0.2000    0.3000    0.3750    0.2900    0.3200    0.4000    0.4250    0.4750    0.4500    0.6000 0.5500    0.7500    0.5250    0.6500    0.6750];

[min, ~] = min(data(1,:));
[max, ~] = max(data(1,:));
tam = length(data);
datanorm = [(data(1,:) - min)./(max-min); data(2,:)];
xplot = -.3:0.1:1.3;

%% Elegir tipo de entrenamiento
cual = 0;
while cual < 1 || cual > 3
    clc
    fprintf("\n\n\tAlgoritmo Adaline: \n\n\t 1-Heuristico\n\t 2-Mini-Lotes\n\t 3-Lotes\n\n\t")
    cual = input('Elige tipo de entrenamiento: ');
end

switch cual
    case 1
        tipo = 'Heuristico'
        mini = tam;
        n = 0.02;
        veces = 100;
        maxerr = 1e-3;
    case 2
        tipo = 'Mini-Lotes'
        mini = 3;
        n = 0.05;
        veces = 1000;
        maxerr = 1e-4;
    case 3
        tipo = 'Lotes'
        mini = 1;
        n = 1;
        veces = 2000;
        maxerr = 1e-15;
end
% se tienen 2 for anidados el primero para decidir cuantos minilotes hacer
% y el segundo para recorrer los elementos de ese mini-lote, en caso de
% elegir un mini-lote entonces el entrenamiento se hace por lotes ya que se
% entrena cada vez que se revisan todos los elementos, en caso de elegir un
% numero intermedio de mini-lotes en este caso 3 pues se hacen ese numero
% de minilotes con el numero de elementos divididos para esos minilotes, y
% en caso de elegir 18 minilotes que es el numero de elementos entonces se
% hace busqueda heuristica

%debido a las capacidades de cada tipo de entrenamiento pongo distintas
%veces que se repita y error maximo.

%% datos para adaline
w = rand(2,1);
cuenta = 1;
toterr = 1;
lote = floor(tam/mini);
while cuenta < veces && abs(toterr) > maxerr
    orden = randperm(tam);
    sumerr = 0;
    for i = 1:mini
        %plot 1
        clf()
        %plot(datanorm(1,:),datanorm(2,:),'ob')
        hold on
        grid on
        res = [0;0];
        for j = 1:lote
            num = (i-1)*lote+j;
            x = [datanorm(1,orden(num)); 1];
            y = w'*x;
            error = datanorm(2,orden(num))-y;
            sumerr = sumerr+error;
            res = res + x.*error;
            %plot 2
            plot(datanorm(1,orden(num)),datanorm(2,orden(num)),'om')
        end
        %actualizo pesos
        res = res./lote;
        w = w + n.*res;
        %plot 3
        axis([-.23 1.23 -.23 1.23])
        y = xplot.*w(1)+w(2);
        plot(xplot, y, 'r')
        title(["Adaline "+ tipo ," Error General: "+num2str(toterr), "Iteracion: "+num2str(cuenta)])
        pause(0.01)
    end
    toterr = sumerr / (mini*lote);
    cuenta = cuenta +1;
    
end
fprintf("\n\n\tError final: %.10f \n\n\tPeso: %.4f\n\tBias: %.4f \n", toterr, w(1), w(2))
clf()
plot(datanorm(1,:),datanorm(2,:),'ob')
hold on
grid on
axis([-.23 1.23 -.23 1.23])
y = xplot.*w(1)+w(2);
plot(xplot, y, 'r')
title(["Adaline "+ tipo ," Error General: "+num2str(toterr), "Iteracion: "+num2str(cuenta)])