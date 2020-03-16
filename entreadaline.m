function errfin = entreadaline(y, y2, tam, n, ordFil, lote)
mini = floor(tam/lote);
y_new = zeros(tam,1);
%% datos para adaline
w = rand(ordFil+2,1);
res = zeros(ordFil+2,1);
res =  res ./ ordFil;
%actualizo pesos
w = w + n.*res;
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
errfin = sum((y-y_new).^2);
end