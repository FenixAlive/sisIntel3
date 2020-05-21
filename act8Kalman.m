%kalman actividad 8
clc
clear
close all;
res = 0.1;
x = -pi:res:pi;
[X,Y] = meshgrid(x);
Z = 2 * sin(X) + 3 * cos(Y);
surf(X,Y,Z)
title("Funcion Original")
hold on
grid on
figure()
pause(0.01)

neuronas_ocultas = 30;
datos_entrada = 2;
datos_salida = 1;
%% datos kalman
%considerando una sola capa oculta
L = (datos_entrada+1)*neuronas_ocultas+(neuronas_ocultas+1)*datos_salida;
P = diag(rand(L,1));
Q0 = rand(L,1);
Q = diag(Q0);
R0 = rand(datos_salida,1);
R = diag(R0);
%% datos red
n = 1; %eta, factor de aprendizaje
%rapidez de la curva
a = 1;
%logistica
logis = @(v) 1 ./ (1+exp(-a.*v));
%derivada de la salida con respecto al peso para el calculo de H
dh = @(n) exp(-n)./(1+exp(-n)).^2;
%pesos
wo = rand(neuronas_ocultas, datos_entrada+1);
ws = rand(datos_salida, neuronas_ocultas+1);

%% entrenamiento
iter = 100;
ndat = length(x);
Zred = zeros(ndat,ndat);
%primer dato de x es 1 que representa el bias
for gen = 1:iter
    clc
    fprintf("Generación: %d\n",gen);
    irand = randperm(ndat);
    jrand = randperm(ndat);
    for i = 1:ndat
        for j= 1:ndat
            i = irand(i);
            j = jrand(j);
            Xi = [1; X(i,j); Y(i,j)];
            no = wo*Xi;
            yo = [1; logis(no)];
            ys = ws*yo;
            e = Z(i,j)-ys;
            W = [reshape(wo',1,[]),reshape(ws',1,[])]';
            dn = dh(no)*Xi';
            H = [];
            for hi = 1:neuronas_ocultas
                H = [H, dn(hi,:)*ws(hi+1)];
            end
            H = [ H, yo']';
            K = (R+H'*P*H)\(P*H); %inversa de matlab K = P*H*inv(R+H'*P*H)
            W = W + n*(K*e);
            P = P - K*H'*P+Q;
            %recreando pesos
            wo = reshape(W(1:neuronas_ocultas*(datos_entrada+1)),[datos_entrada+1, neuronas_ocultas])';
            ws = reshape(W(neuronas_ocultas*(datos_entrada+1)+1:end),[datos_salida, neuronas_ocultas+1]);
        end
    end
    if mod(gen,20)==0
        for i = 1:ndat
            for j= 1:ndat
                Xi = [1; X(i,j); Y(i,j)];
                no = wo*Xi;
                yo = [1; logis(no)];
                ys = ws*yo;
                Zred(i,j) = ys;
            end
        end
        clf()
        error = Z-Zred;
        surf(X,Y,error)
        title("Error, Gen: "+num2str(gen))
        axis([-pi pi -pi pi -inf inf])
        sum(rms(error))
        pause(0.01)
    end
end
for i = 1:ndat
    for j= 1:ndat
        Xi = [1; X(i,j); Y(i,j)];
        no = wo*Xi;
        yo = [1; logis(no)];
        ys = ws*yo;
        Zred(i,j) = ys;
    end
end
error = Z-Zred;
surf(X,Y,error)
title("Error Final")
axis([-pi pi -pi pi -inf inf])
figure()
surf(X,Y,Zred)
title("Grafica creada por Red")
axis([-pi pi -pi pi -inf inf])
sum(rms(error))

