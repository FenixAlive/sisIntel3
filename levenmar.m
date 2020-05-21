clear
clc
close all
res = 0.1;
x = -pi:res:pi;
[X,Y] = meshgrid(x);
Z = 2 * sin(X) + 3 * cos(Y);
figure
surf(X,Y,Z)
X2 = reshape(X,1,[]);
Y2 = reshape(Y,1,[]);
XT =[X2;Y2];
ZT = reshape(Z,1,[]);
net = feedforwardnet([10, 30], 'trainlm');
net = train(net, XT, ZT);
y = net(XT);
ZF =reshape(y,[63,63]);
figure
surf(X,Y,ZF)
figure
surf(X,Y,ZF-Z)