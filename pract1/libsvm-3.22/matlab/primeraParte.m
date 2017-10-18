load data/hart/tr.dat ; load data/hart/trlabels.dat;
load data/hart/ts.dat ; load data/hart/tslabels.dat;
arglist=argv();
if (nargin!=1)
  printf("primeraParte.m [datos lineaes si/no]");
  separables = 'no'
else
  separables=arglist{1};
endif

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


fprintf('\n\n\n\n\n\n\n\n ------------------------Datos--------------------------- \n\n\n\n\n\n\n');

if (separables == 'si')
	load data/mini/trSep.dat ; load data/mini/trSeplabels.dat;
else
	load data/mini/tr.dat ; load data/mini/trlabels.dat;
endif;
C = 1000
resLineal = svmtrain(trlabels, tr, '-t 0 -c 1000');
fprintf('\n Multiplicadores de Lagrange de los datos separables \n');
mults = [resLineal.sv_coef, resLineal.sv_indices]';
fprintf('Valor %f Indice %d\n' , mults);

#Vectores soporte de datos separables
fprintf('Vectores soporte de los datos separables \n');
resLineal.SVs(resLineal.sv_indices)


#el vector de pesos y umbral de la función discriminante lineal
#vector de pesos = Cn(coef) * muestras correspondientes ( * la etiqueta, pero ya esta aplicado por la libreria SVM)
muestras = tr(resLineal.sv_indices,:);
pesos = resLineal.sv_coef' *  muestras;
fprintf(' El vector de pesos de los datos separables es [%f %f] ', pesos(1), pesos(2));
t0 = resLineal.rho;
fprintf('El umbral de la funcion discriminante lineal de los datos lin. sep. es: %f ', t0);

# el margen correspondiente
margen2y = (t0-1)/pesos(2);
margen2x = (t0-1)/pesos(1);
margen1y = (t0+1)/pesos(2);
margen1x = (t0+1)/pesos(1);


#3. Calcular los parámetros de la frontera lineal (recta) de separación;
x1 = resLineal.rho/(pesos(1));
x2 = resLineal.rho/(pesos(2));

#Representar gráficamente los vectores de entrenamiento, marcando los que son vectores soporte, y la recta separadora correspondiente

%% Recta separadora principal
x = linspace(0,x1,100);
y = linspace(x2,0,100);

%% Recta de clase 2
rectaMargen2x = linspace(0,margen2x,100);
rectaMargen2y = linspace(margen2y,0,100);
rectaMargen1x = linspace(0,margen1x,100);
rectaMargen1y = linspace(margen1y,0,100);

%% Recta de clase 1

%% Plot the paired points in a line
fprintf('\n Vectores soporte de los datos separables marcados como X \n');
figure(1,"position",get(0,"screensize"))

if (separables == 'si')
plot(x,y,rectaMargen2x,rectaMargen2y,rectaMargen1x,rectaMargen1y,tr(trlabels==1,1),tr(trlabels==1,2),"^",tr(trlabels==2,1),tr(trlabels==2,2),"s",tr(resLineal.sv_indices,1),tr(resLineal.sv_indices,2), "x", 'markersize',20);
endif

setas = [];
if (separables != 'si')
	[num, _] = size(tr); # Numero de muestras
	arraySetas = zeros(num, 1);
	#1 - (tr(9,:)*pesos' - t0)
	# vectores soporte donde no son 0
	s = find(abs(resLineal.sv_coef) == C);
	vsNonZero = resLineal.sv_indices(s);
	#clases de cada dato transformada en 1 / -1
	clases = resLineal.sv_coef ./ abs(resLineal.sv_coef);
	setas = 1 - clases(s).*(tr(vsNonZero,:)*pesos' -t0)	;
	# son las setas de las muestras vsNonZero, el resto deben ser cero
	arraySetas(vsNonZero) = setas;
	
	plot(x,y,rectaMargen2x,rectaMargen2y,rectaMargen1x,rectaMargen1y,tr(trlabels==1,1),tr(trlabels==1,2),"^",tr(trlabels==2,1),tr(trlabels==2,2),"s",tr(resLineal.sv_indices,1),tr(resLineal.sv_indices,2), "x", 'markersize',20,
	#este plot es igual al anterior
	tr(vsNonZero,:)(:,1),tr(vsNonZero,:)(:,2), '*', 'markersize', 60);
	#text imrpimero texto en el plot
	#vamos a imprimir los coeficientes  y los setas	
	text (tr(:,1)+0.1, tr(:,2), [num2str(arraySetas)]);
	coefs = zeros(num,1);
	coefs(resLineal.sv_indices) = resLineal.sv_coef;
	
	text (tr(:,1), tr(:,2)+0.1, [num2str(coefs)]);
	
	
endif

pause();

