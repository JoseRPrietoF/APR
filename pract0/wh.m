function [w]=wh(data)
# n�mero de muestras de aprendizaje y n�mero de columnas
[N,M]=size(data);

# ponemos un uno
x = [1,data(:,1)']'

theta = [1,1];


w = sum((sum((theta.*x),2)-data(:,2)) .* x)


endfunction
