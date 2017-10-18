load data/spam/tr.dat ; load data/spam/trlabels.dat;
load data/spam/ts.dat ; load data/spam/tslabels.dat;
arglist=argv();
if (nargin!=1)
  printf("primeraParte.m [datos lineaes si/no]");
  separables = 'no'
else
  separables=arglist{1};
endif
