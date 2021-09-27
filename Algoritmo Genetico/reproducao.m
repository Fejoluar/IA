function [criancao1 , crianca2] = reproducao(parente1 , parente2, Pc, Problema)

criancao1.Gene = zeros(1,Problema.nVar);

crianca2.Gene = zeros(1,Problema.nVar);

for k = 1 : Problema.nVar
    
    beta = rand();
    
    criancao1.Gene(k) = beta .* parente1.Gene(k) + (1-beta)*parente2.Gene(k); 
    
    crianca2.Gene(k) = (1-beta) .* parente1.Gene(k) + beta*parente2.Gene(k);
    
    if criancao1.Gene(k) > Problema.ub(k) 
        
        criancao1.Gene(k)  =  Problema.ub(k);
        
    end
    
    if criancao1.Gene(k) < Problema.lb(k)
        
        criancao1.Gene(k) = Problema.lb(k);
        
    end
    
    if crianca2.Gene(k) > Problema.ub(k) 
        
        crianca2.Gene(k)  =  Problema.ub(k);
        
    end
    
    if crianca2.Gene(k) < Problema.lb(k)
        
        crianca2.Gene(k) = Problema.lb(k);
        
    end
    
end

R1 = rand();

if R1 <= Pc
    
    criancao1 = criancao1;
    
else
    
    criancao1 = parente1;
    
end

R2 = rand();

if R2 <= Pc
    
    crianca2 = crianca2;
    
else
    
    crianca2 = parente2;
    
end

end