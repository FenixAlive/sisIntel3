
%% Evolucion diferencial
close all 
clear
clc
disp('Evolucion Diferencial');

%% valores para entrenar
load handel
[tam,~] = size(y);
y = y(100:floor(tam/2),1);
[tam,~] = size(y);
y2 = y+(rand(tam,1)-0.5)/5;

%% creo constantes 
F = 1.2;
Cr = 0.9;
D = 3;
N = 200;
gen = 50;
xl = [0 2 1]';
xu = [1 1000 1000]';
%% inicia algoritmo
%cambio seed random
rng('shuffle');
%inicializo individuos aleatoriamente
x = xl + (xu - xl) .*  rand(D, N);
errores = zeros(1,N);
for i = 1:N
    errores(i) = abs(entreadaline(y,y2,tam,x(1,i),round(x(2,i)),round(x(3,i))));
end
%% comienzan las generaciones
for g = 1:gen
    g
    for i = 1:N
        % busco 3 numeros random distintos entre si y distintos al
        % individuo actual debido a esto el numero minimo de individuos
        % necesarios en el algoritmos es 4.
        r1 = randi(N);
        while(r1 == i)
            r1 = randi(N);
        end
        r2 = randi(N);
        while(r2 == i || r2 == r1)
            r2 = randi(N);
        end
        r3 = randi(N);
        while(r3 == i || r3 == r1 || r3 == r2)
            r3 = randi(N);
        end
        % se crea vector mutado por cada individuo con los numeros
        % aleatorios elegidos antes
        v = x(:, r1) + F.*(x(:, r2) - x(:, r3));
        % mescla del individuo
        u = zeros(D, 1);
        for dim = 1 : D
            if(rand()<= Cr)
                u(dim) = v(dim);
            else
                u(dim) = x(dim, i);
            end
        end
        if u(1) >= xl(1) && u(2) >= xl(2) && u(3) >= xl(3) && u(2) < xu(2) && u(3) < xu(3)
            errorTemp = abs(entreadaline(y,y2,tam,u(1),round(u(2)),round(u(3))));
            if(errorTemp < errores(i))
                x(:, i) = u;
                errores(i) = errorTemp;
            end
        end
    end
end
format long
[minimo, idx] = sort(errores);
x = x(:,idx);
errores(idx)
x(:,1)