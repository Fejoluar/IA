function [parente1, parente2] = selecao(Populacao)

M = length(Populacao.Cromossomo(:));

if any([Populacao.Cromossomo(:).Funcao_Objetivo] < 0 ) 
    
    % Fitness scaling in case of negative values scaled(f) = a * f + b
    
    a = 1;
    
    b = abs( min(  [Populacao.Cromossomo(:).Funcao_Objetivo] )  );
    
    Scaled_fitness = a *  [Populacao.Cromossomo(:).Funcao_Objetivo] + b;
    
    normalized_fitness = [Scaled_fitness] ./ sum([Scaled_fitness]);
    
else
    
    normalized_fitness = [Populacao.Cromossomo(:).Funcao_Objetivo] ./ sum([Populacao.Cromossomo(:).Funcao_Objetivo]);
    
end


[sorted_fintness_values , sorted_idx] = sort(normalized_fitness , 'descend');

for i = 1 : length(Populacao.Cromossomo)
    
    temp_Populacao.Cromossomo(i).Gene = Populacao.Cromossomo(sorted_idx(i)).Gene;
    
    temp_Populacao.Cromossomo(i).fitness = Populacao.Cromossomo(sorted_idx(i)).Funcao_Objetivo;
    
    temp_Populacao.Cromossomo(i).normalized_fitness = normalized_fitness(sorted_idx(i));
    
end


cumsum = zeros(1 , M);

for i = 1 : M
    
    for j = i : M
        
        cumsum(i) = cumsum(i) +  temp_Populacao.Cromossomo(j).normalized_fitness;
        
    end
    
end


R = rand(); % in [0,1]

parent1_idx = M;

for i = 1: length(cumsum)
    
    if R > cumsum(i)
        
        parent1_idx = i - 1;
        
        break;
        
    end
    
end

parent2_idx = parent1_idx;

while_loop_stop = 0; % to break the while loop in rare cases where we keep getting the same index

while parent2_idx == parent1_idx
    
    while_loop_stop = while_loop_stop + 1;
    
    R = rand(); % in [0,1]
    
    if while_loop_stop > 20
        
        break;
        
    end
    
    for i = 1: length(cumsum)
        
        if R > cumsum(i)
            
            parent2_idx = i - 1;
            
            break;
            
        end
        
    end
    
end

parente1 =  temp_Populacao.Cromossomo(parent1_idx);

parente2 =  temp_Populacao.Cromossomo(parent2_idx);

end