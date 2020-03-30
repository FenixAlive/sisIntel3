%actividad 5
%red neuronal unicapa
%Muñoz Franco Luis Angel
clc
clear
close all
%% creando datos de entrenamiento
dpg = 10; %datos por grupo
grupos = 4;
tdat = dpg*grupos;
g1 = rand(2,dpg)+1;
g2 = rand(2,dpg)-2;
g3 = [rand(1,dpg)-2; rand(1,dpg)+1];
g4 = [rand(1,dpg)+1; rand(1,dpg)-2];
data = [g1 g2 g3 g4];
data(3,:)=ones(1,tdat);
deseado = zeros(4, tdat);
for i=0:3
    deseado((i+1),dpg*i+1:dpg*(i+1)) = ones(1,dpg);
end
a = 1;
logis = @(v) 1 ./ (1+exp(a.*v));
dlogis = @(v) a.*v.*(1-v);
n = 0.01;
w = rand(4,3);

%% comienza algoritmo
% por lotes
cuenta = 0;
terr = 1;
maxerr = 0.00001;
veces = 500000;

while cuenta < veces && terr > maxerr
    v = w*data;
    y = logis(v);
    error = deseado-y;
    res = n .* error .* dlogis(v);
    res = res * data' ./ tdat;
    w = w + res;
    cuenta = cuenta + 1;
    terr = sum(sum(abs(res)));
end

%% imprimir resultados
w
%% graficar
figure();
hold on
grid on
for x = -3:0.2:3
    for y = -3:0.2:3
        t = logis(w*[x; y; 1]);
        [mx, idx] = max(t);
        if idx == 1
            plot(x,y,'c.');
        elseif idx == 2
            plot(x,y,'y.');
        elseif idx == 3
            plot(x,y,'m.');
        elseif idx == 4
            plot(x,y,'r.');
        end
    end
end
plot(g1(1,:), g1(2,:),'bo');
plot(g2(1,:), g2(2,:),'ko');
plot(g3(1,:), g3(2,:),'go');
plot(g4(1,:), g4(2,:),'ro');