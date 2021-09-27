function Populacao = inicializacao(Tamanho_Populacao,Problema,Tamanho_Variaveis,Grade)


for k=1:Tamanho_Populacao
    
    % Geração Inicial da População
    
    Populacao.Cromossomo(k).Gene = unifrnd(Problema.lb,Problema.ub, Tamanho_Variaveis);
    
    Populacao.Cromossomo(k).Funcao_Objetivo = sensibilidade_grade_simples(Grade,...
        Populacao.Cromossomo(k).Gene(1),Populacao.Cromossomo(k).Gene(2));
    
    
end
