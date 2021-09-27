function [ Nova_Populacao ] = elitismo(Populacao , Nova_Populacao, Er)

M = length(Nova_Populacao.Cromossomo); % number of individuals

Elite_no = round(M * Er);

[max_val , indx] = sort([ Populacao.Cromossomo(:).Funcao_Objetivo ] , 'descend');


for k = 1 : Elite_no
    
    Nova_Populacao.Cromossomo(k).Gene  = Populacao.Cromossomo(indx(k)).Gene;
    
    Nova_Populacao.Cromossomo(k).Funcao_Objetivo  = Populacao.Cromossomo(indx(k)).Funcao_Objetivo;
    
end

for k = Elite_no + 1 :  length(Nova_Populacao.Cromossomo)
    
    Nova_Populacao.Cromossomo(k).Gene  = Nova_Populacao.Cromossomo(k).Gene;
    
    Nova_Populacao.Cromossomo(k).Funcao_Objetivo  = Nova_Populacao.Cromossomo(k).Funcao_Objetivo;
    
end




end