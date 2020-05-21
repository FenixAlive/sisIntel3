%Alexis Torres Cortés. Codigo: 217808788
%Práctica 6 Perceptron multicapa
clc
clear
close all

figure(1);
hold on; grid on;
axis([-2 2 -2 2]);
title('Datos Originales');
xlabel('X1');
ylabel('X2');

%% Datos de Entrenamiento
x1 = [0; 0; 1; 1];
x2 = [0; 1; 0; 1];

X = [x1 x2]';

% Tamaño y Salida Deseada
[fila,colum] = size(X);
Yd = [0; 1; 1; 0]';
plot(X(1,[1 4]),X(2,[1 4]),'ko','LineWidth',1.5);
plot(X(1,2:3),X(2,2:3),'k.','MarkerSize',18);

% Neuronas
Lc = 3;
wo = zeros(Lc,fila);
ws = zeros(1,Lc);
Bo = zeros(Lc,colum);
Bs = zeros(1,colum);

%% Función
a = 0.9;
sigmoid = @(v) 1./(1+exp(-a.*v));
sigmoid_d = @(yi) a.*yi.*(1 - yi);
lineal= @(v) v;
 
% Pesos y Bias
wo = rand(Lc,fila) + randi([-1,0],[Lc,fila]);
ws = rand(1,Lc) + randi([-1,0],[1,Lc]);
Bo = rand(Lc,1) + randi([-1,0],[Lc,1]);
Bs = rand + randi([-1,0],[1,1]);
%Bo = rand(Lc,colum) + randi([-1,0],[Lc,colum]);
%Bs = rand(1,colum) + randi([-1,0],[1,colum]);

fprintf('  w(0) = \n');
disp(wo); disp(ws); disp(Bo); disp(Bs);

   % Velocidad de aprendizaje
eta = 0.13;

   % Variables
NoI = 50000;       % Iteraciones

% MÉTODO ESTOCASTICO
for i=0:NoI
    y1 = sigmoid(wo*X + Bo.*ones(Lc,colum));
    y2 = ws*y1 + Bs.*ones(1,colum);
    
    e = Yd - y2;
    
    ws = ws + eta*e.*[1 1 1 1]*y1';
    Bs = Bs + eta*(e.*[1 1 1 1])*ones(colum,1);
    
    phi = 1.*e;
    wo = wo + eta*sigmoid_d(y1).*(ws'*phi)*X';             % sigmoid_d(y1)
    Bo = Bo + eta*sigmoid_d(y1).*(ws'*phi)*ones(colum,1);
end

%% PRUEBAS DE GENERALIZACIÓN
Xg = [x1 x2; x1 x2]'+(rand(2,8)-.5)/3
%Xg = unifrnd(0,1,[10,2]);

Y1 = sigmoid(wo*Xg + Bo.*ones(Lc,8));
Y2 = sigmoid(ws*Y1 + Bs.*ones(1,8))
for j=1:length(Y2)
    Y(j) = fnc(Y2(j));
end
Y

mm = 1;
for n=-2:0.05:2
    for m=-2:0.05:2
        M1 = sigmoid(wo*[n;m] + Bo);
        M2 = ws*M1 + Bs;
        M(mm) = fnc(M2);
        
        if M(mm) == 1
            plot(n,m,'b.','MarkerSize',10)
        else
            plot(n,m,'k.','MarkerSize',10)
        end
        
        mm = mm + 1;
    end
end


function out = fnc(in)
    if in > 0.5
        out = 1;
    else
        out = 0;
    end
end
