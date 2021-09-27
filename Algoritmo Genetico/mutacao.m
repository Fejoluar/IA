function [crianca] = mutacao(crianca, Pm, Problema)

Gene_no = length(crianca.Gene);

for k = 1: Gene_no
    
    R = rand();
    
    if R < Pm
        
        crianca.Gene(k) = (Problema.ub(k) - Problema.lb(k)) * rand() + Problema.lb(k);
        
    end
    
end

end