load data/hart/tr.dat ; load data/hart/trlabels.dat;
load data/hart/ts.dat ; load data/hart/tslabels.dat;
% Create New Figure

#pintamos todos los datos
#plot (tr(:,1),tr(:,2),"x")

#pintamos los datos separados por clase/color
#plot(tr(trlabels==1,1),tr(trlabels==1,2),"x",tr(trlabels==2,1),tr(trlabels==2,2),"s")

res = svmtrain(trlabels, tr, '-t 2 -c 1');
a = svmpredict(tslabels,ts, res,' ');
fprintf('\nIntervalo de confianza.\n');
[i_ariba, i_abajo] = intervalo_conf(a, tslabels)

#printamos los datos por color y ademas mostrando los vectores soporte
%plot(tr(trlabels==1,1),tr(trlabels==1,2),"x",tr(trlabels==2,1),tr(trlabels==2,2),"s", tr(res.sv_indices,1),tr(res.sv_indices,2), "^",'color',[0,1,0], 'markersize',20)





#Parte para etregar
#Parte separable
load data/mini/trSep.dat ; load data/mini/trSeplabels.dat;
resLineal = svmtrain(trlabels, tr, '-t 0 -c 1000');
fprintf('\n Multiplicadores de Lagrange de los datos separables \n');
mults = [resLineal.sv_coef, resLineal.sv_indices]';
fprintf('Valor %f Indice %d\n' , mults);

#Vectores soporte de datos no separables
#TODO


#el vector de pesos y umbral de la función discriminante lineal
#vector de pesos = Cn(coef) * muestras correspondientes ( * la etiqueta, pero ya esta aplicado por la libreria SVM)
muestras = tr(resLineal.sv_indices,:);
pesos = resLineal.sv_coef' *  muestras;
fprintf(' El vector de pesos de los datos separables es [%f %f] ', pesos(1), pesos(2));

#TODO
fprintf('El umbral de la funcion discriminante lineal de los datos lin. sep. es: %f ', resLineal.rho);

#d) el margen correspondiente
#TODO


#3. Calcular los parámetros de la frontera lineal (recta) de separación;
x1 = resLineal.rho/(pesos(1));
x2 = resLineal.rho/(pesos(2));

#Representar gráficamente los vectores de entrenamiento, marcando los que son vectores soporte, y la recta separadora correspondiente
#TODO igual que en el primera punto? una grafica?

%% Setup a vector of x values
x = linspace(0,x1,100);
%% Setup a vector of y values
y = linspace(x2,0,100);
%% Plot the paired points in a line
fprintf('\n Vectores soporte de los datos separables marcados como X \n');

plot(x,y,tr(trlabels==1,1),tr(trlabels==1,2),"^",tr(trlabels==2,1),tr(trlabels==2,2),"s",tr(resLineal.sv_indices,1),tr(resLineal.sv_indices,2), "x", 'markersize',20)










#Parte no separable
#load data/mini/tr.dat ; load data/mini/trlabels.dat;
#resLineal = svmtrain(trlabels, tr, '-t 0 -c 1000');
#fprintf('\n Multiplicadores de Lagrange de los datos no separables \n');
#mults = [resLineal.sv_coef, resLineal.sv_indices]';
#fprintf('Valor %f Indice %d\n' , mults);

#Vectores soporte de datos no separables
#fprintf('\n Vectores soporte de los datos no separables marcados como X \n');
#plot(tr(trlabels==1,1),tr(trlabels==1,2),"^",tr(trlabels==2,1),tr(trlabels==2,2),"s",tr(resLineal.sv_indices,1),tr(resLineal.sv_indices,2), "x", 'markersize',20)

#el vector de pesos y umbral de la función discriminante lineal


#d) el margen correspondiente
