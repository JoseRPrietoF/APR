function [w]=wh(data)
# número de muestras de aprendizaje y número de columnas
[N,M]=size(data);

# ponemos un uno
x = [1,data(:,1)']'

theta = [1,1];


w = sum((sum((theta.*x),2)-data(:,2)) .* x)


endfunction
