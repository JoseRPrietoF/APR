load "dat.tgz";


[N,M]=size(data);

Sx = sum(data(:,1));
Sxx = sum(data(:,1).^2);
Sy = sum(data(:,2));
Sxy = sum(data(:,1) .* data(:,2));

m = (N*Sxy - Sx*Sy)/(N*Sxx - Sx^2)
b = ( Sy - m*Sx )/N
