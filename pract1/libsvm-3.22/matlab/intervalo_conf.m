function [arriba,abajo] = intervalo_conf(data01, a)

#contamos errores
c = data01 != a;
n_errores = sum(c);
[total,_] = size(c);
pe = n_errores / total;
i_conf = 1.96*sqrt((pe*(1-pe))/total);

arriba = pe + i_conf;
abajo = pe - i_conf;

end

