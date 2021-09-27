function [Melhor_Cromossomo]  = Algoritmo_Genetico (Tamanho_Populacao,N,MaxGen,Pc,Pm,Er,Problema,...
    Tamanho_Variaveis,Grade)

cgcurve = zeros(1,MaxGen);

%%  Inicialização

Populacao = inicializacao(Tamanho_Populacao,Problema,Tamanho_Variaveis,Grade)

for i = 1 : Tamanho_Populacao
    
     Populacao.Cromossomo(i).Funcao_Objetivo = sensibilidade_grade_simples(Grade,...
        Populacao.Cromossomo(i).Gene(1),Populacao.Cromossomo(i).Gene(2));
    
end

all_fitness_values = [ Populacao.Cromossomo(:).Funcao_Objetivo ];

[cgcurve(1) , ~ ] = max( all_fitness_values);

g = 1;

disp(['Generation #' , num2str(g)]);

%% Main loop
for g = 2 : MaxGen
    

    disp(['Generation #' , num2str(g)]);
    
    % Calcualte the fitness values
    
    for i = 1 : Tamanho_Populacao
        
         Populacao.Cromossomo(i).Funcao_Objetivo = sensibilidade_grade_simples(Grade,...
        Populacao.Cromossomo(i).Gene(1),Populacao.Cromossomo(i).Gene(2));
        
    end
    
    drawnow
    
    for k = 1: 2: Tamanho_Populacao
        
        % Selection
        
       [parente1, parente2] = selecao(Populacao);
        
        % Crossover
        
      [crianca1 , crianca2] = reproducao(parente1 , parente2, Pc, Problema);
        
        % Mutation
        
        [crianca1] = mutacao(crianca1, Pm, Problema);
        
        [crianca2] = mutacao(crianca2, Pm, Problema);
        
        Nova_Populacao.Cromossomo(k).Gene = crianca1.Gene;
        
        Nova_Populacao.Cromossomo(k+1).Gene = crianca2.Gene;
        
    end
    
    for i = 1 : Tamanho_Populacao
        
        Nova_Populacao.Cromossomo(i).Funcao_Objetivo = sensibilidade_grade_simples(Grade,...
        Nova_Populacao.Cromossomo(k).Gene(1),Nova_Populacao.Cromossomo(k).Gene(2));
    
    end
    
    % Elitismo
    
    [ Nova_Populacao ] = elitismo(Populacao , Nova_Populacao, Er);
    
    Populacao = Nova_Populacao;
    
    
all_fitness_values = [ Populacao.Cromossomo(:).Funcao_Objetivo ];

 [cgcurve(g) , ~ ] = max( all_fitness_values);
 
cgcurve(g)

end

for i = 1 : Tamanho_Populacao
    
    Populacao.Cromossomo(i).Funcao_Objetivo = sensibilidade_grade_simples(Grade,...
        Populacao.Cromossomo(k).Gene(1),Populacao.Cromossomo(k).Gene(2));
    
end


[max_val , indx] = sort([ Populacao.Cromossomo(:).Funcao_Objetivo ] , 'descend');
    
Melhor_Cromossomo.Gene    = Populacao.Cromossomo(indx(1)).Gene;

Melhor_Cromossomo.Fitness = Populacao.Cromossomo(indx(1)).Funcao_Objetivo;
 
end