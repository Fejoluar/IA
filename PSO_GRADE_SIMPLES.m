clear all
close all
clc

%PARÂMETROS PARA DETERMINAR O CHUTE INICIAL DO PERÍODO////////////////////

format shortg

tic


L = 5;

ns = 1;

lambda = 1550;

teta = 0;

periodoOtimo = periodo_inicial(ns,lambda,teta)

%%DEFINIÇÃO DO PROBLEMA///////////////////////////////////////////////////


Numero_Variaveis = 2;        % NUMERO DE VARIÁVEIS DE DECISÃO

Tamanho_Variaveis = [1 Numero_Variaveis];         % TAMANHO DA MATRIZ DAS VARIÁVEIS DE DECISÃO

periodo_minimo = periodoOtimo - periodoOtimo*0.5 ;

periodo_maximo = periodoOtimo + periodoOtimo*0.5 ;

h_minimo = 1;

h_maximo = 100;

Valor_Minimo = [periodo_minimo h_minimo]	% VALOR MINÍMO DAS VARIAVEIS DE DECISÃO

Valor_Maximo = [periodo_maximo h_maximo]    % VALOR MÁXIMO DAS VARIAVEIS DE DECISÃO



%% PARÂMETROS DPSO
Maxima_Iteracao = 100;   % NÚMERO MÁXIMO DE ITERAÇÕES

Numero_Particula = 100;     % QUANTIDADE DE PARTÍCULAS

w = 0.7;           % COEFICIENTE DE INÉRCIA

C1 = 2;

C2 = 2;

Velocidade_Maxima = (Valor_Maximo - Valor_Minimo) .* 0.1;

Velocidade_Minima  = - Velocidade_Maxima;

posicao_historico = zeros(Numero_Particula , Maxima_Iteracao , Numero_Variaveis );


% Inicialização das particulas/////////////////////////////////////////


particula_vazia.Posicao = [];

particula_vazia.Velocidade = [];

particula_vazia.Custo = [];

particula_vazia.Melhor.Posicao = [];

particula_vazia.Melhor.Funcao_Objetivo = [];

%Criação das particulas///////////////////////////////////////////////

particula = repmat( particula_vazia, Numero_Particula, 1);

% Inicialização da melhor função objetivo

MelhorGlobal.Funcao_Objetivo = -inf;


    
    % Inicialização das partículas
    
    for k=1:Numero_Particula
        
        % Geração da posições iniciais das partículas
        
        particula(k).Posicao = unifrnd(Valor_Minimo, Valor_Maximo, Tamanho_Variaveis);
        
        
        % Inicialização Velocidade
        
        particula(k).Velocidade = zeros(Tamanho_Variaveis);
        
        % particula(i).Velocidade = 0.1.*  particula(i).Posicao;
        
        % Evolução
        
        particula(k).Funcao_Objetivo =  sensibilidade_grade_simples(L,ns,lambda,teta,particula(k).Posicao(1),particula(k).Posicao(2));
        
        %Armazenamento da melhor posicão de cada partícula
        
        particula(k).Melhor.Posicao = particula(k).Posicao;
        
        particula(k).Melhor.Funcao_Objetivo = particula(k).Funcao_Objetivo;
        
        % Carregamento do melhor global
        
        if particula(k).Melhor.Funcao_Objetivo > MelhorGlobal.Funcao_Objetivo
            
            MelhorGlobal.Funcao_Objetivo = particula(k).Melhor.Funcao_Objetivo;
            
            MelhorGlobal.Posicao = particula(k).Posicao;
            
            
        end
        
    end
    
    
    Melhor_Funcao_Objetivo = zeros(Maxima_Iteracao, 1);
    
    
    
    
    for it=1: Maxima_Iteracao
        
        for k=1:Numero_Particula
            
            posicao_atual = particula(k).Posicao;
            
            posicao_historico(k,it,:) = posicao_atual;
            
            SENSI(k,it,:) = particula(k).Funcao_Objetivo;
            
           
 
            %Nova velocidade
            
            particula(k).Velocidade = w*particula(k).Velocidade ...
                +  C1*rand(Tamanho_Variaveis).*(particula(k).Melhor.Posicao - particula(k).Posicao) ...
                +  C2*rand(Tamanho_Variaveis).*(MelhorGlobal.Posicao - particula(k).Posicao);
            
            % Checando velocidade
            
            index1 = find(particula(k).Velocidade > Velocidade_Maxima);
            
            index2 = find(particula(k).Velocidade < Velocidade_Minima);
            
            particula(k).Velocidade(index1) = Velocidade_Maxima(index1);
            
            particula(k).Velocidade(index2) = Velocidade_Minima(index2);
            
            % ATUALIZANDO POSIÇÃO
            
            particula(k).Posicao = particula(k).Posicao + particula(k).Velocidade;
            
            % Checando posição
            
            indice_posicao1 = find(  particula(k).Posicao > Valor_Maximo);
            
            indice_posicao2 = find(  particula(k).Posicao < Valor_Minimo);
            
            particula(k).Posicao(indice_posicao1) = Valor_Maximo(indice_posicao1);
            
            particula(k).Posicao(indice_posicao2) = Valor_Minimo(indice_posicao2);
            
            % ATUALIZANDO VALOR DA FUNÇÃO OBJETIVO
            
            particula(k).Funcao_Objetivo = sensibilidade_grade_simples(L,ns,lambda,teta,particula(k).Posicao(1),particula(k).Posicao(2));
            
            
            % Carregamento da melhor posição de cada partícula
            
            if particula(k).Funcao_Objetivo > particula(k).Melhor.Funcao_Objetivo
                
                particula(k).Melhor.Posicao = particula(k).Posicao;
                particula(k).Melhor.Funcao_Objetivo = particula(k).Funcao_Objetivo;
                
                
                if particula(k).Melhor.Funcao_Objetivo > MelhorGlobal.Funcao_Objetivo
                    
                    MelhorGlobal = particula(k).Melhor;
                    
                end
                
            end
            
        end
        
        Melhor_Funcao_Objetivo(it) = MelhorGlobal.Funcao_Objetivo;
        
        disp(['Iteração ' num2str(it) ': SENSIBILIDADE = ' num2str( Melhor_Funcao_Objetivo(it)) '  periodo =  ' num2str(  MelhorGlobal.Posicao(1))...
            '  amplitude =  ' num2str( MelhorGlobal.Posicao(2))     ] );
        
        curva(it) = MelhorGlobal.Funcao_Objetivo;
        
           figure(1)
            clf;
             plot(posicao_historico(:,it,1),posicao_historico(:,it,2),'bx');             % DESENHANDO A MOVIMENTAÇÃO DAS PARTÍCULAS
         
             pause(0.0001);
             
        
        
    end
  
 
    















