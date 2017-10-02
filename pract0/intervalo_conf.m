load "dat.tgz"
#data01 ya etiquetadas
#data sin etiquetar

a = (data(:,1)+data(:,2) - 1.6) > 0; # Etiquetamos

#contamos errores
c = data01(:,3) != a;
n_errores = sum(c);
[total,_] = size(c);
pe = n_errores / total;
i_conf = 1.96*sqrt((pe*(1-pe))/total)

ariba = pe + i_conf
abajo = pe - i_conf

