function periodo = periodo_inicial(Grade)


nm = Babar_Weaver_Ouro(Grade.lambda);

em =  nm^2;

e1 =  (Grade.ns)^2;

er = (real(em));

ei = (imag(em));

periodo = Grade.lambda/( sqrt((e1*er)/(e1+er)) - Grade.ns*sind(Grade.teta));


end