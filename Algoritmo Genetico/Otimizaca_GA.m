clear all
close all
clc

format shortg


%/////////////////PARAMETROS PARA SIMULA��O DA GRADE/////////////////////

Grade.L = 5;

Grade.ns = 1;

Grade.lambda = 1550;

Grade.teta = 0;

periodoOtimo = periodo_inicial(Grade);

%%DEFINI��O DO PROBLEMA///////////////////////////////////////////////////

Pc = 0.95;

Pm = 0.001;

Er = 0.2;

Numero_Geracoes = 100;

Tamanho_Populacao = 100;

Problema.nVar = 2;

N = Problema.nVar;  % number of genes (variables)

Tamanho_Variaveis = [1 Problema.nVar];         % TAMANHO DA MATRIZ DAS VARI�VEIS DE DECIS�O

periodo_minimo = periodoOtimo - periodoOtimo*0.1 ;

periodo_maximo = periodoOtimo + periodoOtimo*0.1 ;

h_minimo = 1;

h_maximo = 100;

Problema.lb = [periodo_minimo h_minimo];	% VALOR MIN�MO DAS VARIAVEIS DE DECIS�O

Problema.ub = [periodo_maximo h_maximo];   % VALOR M�XIMO DAS VARIAVEIS DE DECIS�O

[BestChrom]  = Algoritmo_Genetico (Tamanho_Populacao,N,Numero_Geracoes,Pc,Pm,Er,Problema,...
    Tamanho_Variaveis,Grade)

BestChrom.Gene
BestChrom.Fitness






























