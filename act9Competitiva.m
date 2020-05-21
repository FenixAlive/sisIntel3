%actividad 9 red competitiva
clc
clear
close all

ng = 6;
g1 = rand(3,20)+ones(3,20).*[0;0;0];
g2 = rand(3,20)+ones(3,20).*[2;0;0];
g3 = rand(3,20)+ones(3,20).*[0;2;0];
g4 = rand(3,20)+ones(3,20).*[0;0;2];
plot3(g1(1,:),g1(2,:),g1(3,:),'ko')
hold on
grid on
view(135,35)
plot3(g2(1,:),g2(2,:),g2(3,:),'ks')
plot3(g3(1,:),g3(2,:),g3(3,:),'kp')
plot3(g4(1,:),g4(2,:),g4(3,:),'k<')
g = [g1, g2, g3, g4];
[dim, ndat] = size(g);

n=0.5;
w = rand(ng, dim)+1;
iter = 7000;
theta=zeros(ng,1);
for gen=1:iter
    for i=1:ndat
        x = g(:,i);
        for j=1:ng
            theta(j,1)=w(j,:)*w(j,:)';
        end
        vi = w*x-theta/2;
        yi = zeros(ng,1);
        [~,idx] = max(vi);
        yi(idx,1) = 1;
        w(idx,:) = w(idx,:) + n*(x'-w(idx,:));
    end
end
figure()
hold on;
grid on;
view(135,35)
color = ['bo';'r*';'m<';'gp';'kd';'cs'];
for i=1:ndat
    x = g(:,i);
    for j=1:ng
        theta(j,1)=w(j,:)*w(j,:)';
    end
    vi = w*x-theta/2;
    [~,idx] = max(vi);
    plot3(x(1),x(2),x(3),color(idx,:))
end
