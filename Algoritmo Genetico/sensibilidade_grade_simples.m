function S = sensibilidade_grade_simples(Grade,periodo,h)

% restri1 = 2*h/periodo - 0.1 < 0 ;

% restri2 = periodo - (lambda - 2) >= 0;
% 
% restri3 = periodo - (lambda + 2) <= 0;

deltan = 0.0001;

R1 = reflectancia_grade_simples(Grade.L,Grade.ns,Grade.lambda,Grade.teta,periodo,h);

R2 = reflectancia_grade_simples(Grade.L,Grade.ns + deltan,Grade.lambda,Grade.teta,periodo,h);

S = abs((R2 - R1)/deltan);


% if restri1 == 1 
% 
%     S = S;
% 
% else
% 
%     S = S - 1000000000000;
% 
% % 
% end


% if restri2 == 1 && restri3 == 1  
% 
%      S = S - 1000000000000;
% 
% else
% 
%     S = S ;


end

