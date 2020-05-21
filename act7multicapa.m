clear
clc
close all
res = 0.1;
x = -pi:res:pi;
[X,Y] = meshgrid(x);
Z = 2 * sin(X) + 3 * cos(Y);
surf(X,Y,Z)
hold on
grid on
pause(0.01)

%% preparo red
%capas ocultas
numoci = 10;
numocj = 30;

%% funcion activacion
%rapidez de la curva
a = 1;
%logistica
logis = @(v) 1 ./ (1+exp(-a.*v));
%derivada de logística entra en 'y' la salida ya pasada por la logistica
dlogis = @(y) a.*y.*(1-y);

wi = rand(numoci,2);
bi = rand(numoci,1);

wj = rand(numocj,numoci);
bj = rand(numocj,1);
%capa de salida, 1 neurona de salida, 4 de entrada con el bias
%|_wfin_|_no1_|_no2_|_no3_| *noi= neurona oculta numero
%|__ns__|_1,1_|_1,2_|_1,3_| *ns= neurona de salida
wk = rand(1,numocj);
bk = rand();
n= 0.002;

%% entrenamiento
iter = 5000;
ndat = length(x);
Zred = zeros(ndat,ndat);
for gen = 1:iter
    irand = randperm(ndat);
    jrand = randperm(ndat);
    for i = 1:ndat
        for j= 1:ndat
            i = irand(i);
            j = jrand(j);
            Xi = [X(i,j);Y(i,j)];
            yi = logis(wi*Xi+bi);
            yj = logis(wj*yi+bj);
            yk = wk*yj+bk;
            des = Z(i,j);
            % error
            error = des - yk;
            %actualizar pesos
            dk = 1*error;
            wdk = wk'*dk;
            dj = dlogis(yj).*wdk;
            wdj = wj'*dj;
            di = dlogis(yi).*wdj;
            
            wi = wi + n*di*Xi';
            bi = bi + n*di*1;
            wj = wj + n*dj*yi';
            bj = bj + n*dj*1;
            wk = wk + n*dk * yj';
            bk = bk + n*dk*1;
        end
    end
    if mod(gen,20)==0
        for i = 1:ndat
            for j= 1:ndat
                Xi = [X(i,j);Y(i,j)];
                yi = logis(wi*Xi+bi);
                yj = logis(wj*yi+bj);
                yk = wk*yj+bk;
                Zred(i,j) = yk;
            end
        end
        clf()
        surf(X,Y,Z-Zred)
        title("Error, Gen: "+num2str(gen))
        axis([-pi pi -pi pi -.2 .2])
        pause(0.01)
    end
end
% comprobar funcionamiento
for i = 1:ndat
    for j= 1:ndat
        Xi = [X(i,j);Y(i,j)];
        yi = logis(wi*Xi+bi);
        yj = logis(wj*yi+bj);
        yk = wk*yj+bk;
        Zred(i,j) = yk;
    end
end
figure()
surf(X,Y,Z-Zred)
title("Error despues")
axis([-pi pi -pi pi -.2 .2])
figure
surf(X,Y,Z)
title("Original")
axis([-pi pi -pi pi -5 5])
figure
surf(X,Y,Zred)
title("Creada con red")
axis([-pi pi -pi pi -5 5])
