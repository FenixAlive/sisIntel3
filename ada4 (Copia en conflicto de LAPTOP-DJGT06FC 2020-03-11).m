% Demo
clear, close all, clc

%Cargar Hansel (Pre cargado en Matlab)
filename = '../TenDuelCommandments.mp3';
[y, Fs] = audioread(filename, 'native');
%load handel
[tam,~] = size(y);
y = y(floor(tam/7):floor(tam*2/7),1);
[tam,~] = size(y);
player0 = audioplayer(y, Fs);

%% Create figure
xplot = 0:1/Fs:(tam-1)/Fs;
figure('units','normalized','outerposition',[0 0 1 1])
hold on; grid on;
set(gcf,'color','w');
subplot(3,1,1)
bar(xplot, y,'r')
title('Senal Original')

%Senal con ruido
y2 = y+(rand(tam,1)-0.5)/3;
player1 = audioplayer(y2, Fs);

%% parametros del adaline
% Vector para guardar las salidas de cada instante de tiempo.
y_new = zeros(tam,1);


% adaline como filtro.
ordFil = 3;
n = .53;
%% datos para adaline
w = rand(ordFil+2,1);
res = zeros(ordFil+2,1);
%Datos completos mediante minilotes
lote = 9;
mini = floor(tam/lote);
for i = 1:mini
    res = zeros(ordFil+2,1);
    for j= 1:lote
        num = (i-1)*lote+j;
        if num > ordFil
            x = [y2(num-ordFil:num, 1); 1];
        else
            x = [y2(1:num,1); zeros(ordFil+1-num,1); 1];
        end
        y_new(num,1) = w'*x;
        error = y(num,1)-y_new(num,1);
        res = res + x.*error;
    end
    res = res ./ lote;
    %actualizo pesos
    w = w + n.*res;
end

%%Graficas
subplot(3,1,2)
bar(xplot, y2,'b')
title('Senal con ruido')

subplot(3,1,3)
bar(xplot, y_new,'k')
title('Senal filtrada')
xlabel('Segundos')

figure('units','normalized','outerposition',[0 0 1 1])
hold on; grid on;
set(gcf,'color','w');

subplot(2,1,1)
bar(xplot, y-y2,'b')
title('Original vs Ruido')

subplot(2,1,2)
bar(xplot, y-y_new,'k')
title('Diferencia Original vs Filtrada')
xlabel('Segundos')


play(player0)
pause(16)
play(player1)
pause(16)
player2 = audioplayer(y_new, Fs);
play(player2)