%actividad 5
%red neuronal unicapa
%Munoz Franco Luis Angel
clc
clear
close all
%% creando datos de entrenamiento
dpg = 15; %datos por grupo
grupos = 4;
tdat = dpg*grupos;
g1 = rand(2,dpg)*15+5;
g2 = rand(2,dpg)*17-23;
g3 = [rand(1,dpg)*23-27; rand(1,dpg)*30+7];
g4 = [rand(1,dpg)*27+5; rand(1,dpg)*33-35];
data = [g1 g2 g3 g4];
figure();
hold on
grid on
forec = ['bo';'ko';'go';'ro'];
for i = 1:grupos
    plot(data(1,dpg*(i-1)+1:dpg*i), data(2,dpg*(i-1)+1:dpg*i),forec(i,:));
end
title("Datos sin Normalizar")
% normalizando información
[maxx,~] = max(data(1,:));
[maxy,~] = max(data(2,:));
[minx,~] = min(data(1,:));
[miny,~] = min(data(2,:));
data(1,:) = (data(1,:) - minx)./(maxx-minx);
data(2,:) = (data(2,:) - miny)./(maxy-miny);
%agrego el bias
data(3,:)=ones(1,tdat);
%hago los deseados
deseado = zeros(grupos, tdat);
for i=1:grupos
    deseado((i),dpg*(i-1)+1:dpg*(i)) = ones(1,dpg);
end
%% funcion activacion
%rapidez de la curva
a = 1;
%logistica
logis = @(v) 1 ./ (1+exp(-a.*v));
%derivada de logística
dlogis = @(v) a.*v.*(1-v);
%factor de aprendizaje
n = 0.01;
%pesos incluyendo bias
w = rand(grupos,3);
%veces que se repite el algoritmo
veces = 500000;

%% comienza algoritmo
% por lotes con lo cual se hace el calculo de 
% todos los datos al mismo tiempo

for i = 1:veces 
    y = logis(w*data);
    error = deseado-y;
    w = w + ((n .* error .* dlogis(y)) * data') ./ tdat;
end

%% imprimir resultados
w
%% graficar
figure();
hold on
grid on
backc = ['c+';'y+';'b+';'m+'];
for xp = -0.2:0.02:1.2
    for yp = -0.2:0.02:1.2
        t = logis(w*[xp; yp; 1]);
        [~, idx] = max(t);
        plot(xp,yp,backc(idx,:));
    end
end
forec = ['bo';'ko';'go';'ro'];
for i = 1:grupos
    plot(data(1,dpg*(i-1)+1:dpg*i), data(2,dpg*(i-1)+1:dpg*i),forec(i,:));
end
title("Datos normalizados y clasificados correctamente")