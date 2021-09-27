function R = reflectancia_grade_simples(L,ns,lambda,teta,periodo,h)


K0 = 2*pi/lambda;

Kg = 2*pi/periodo;

n2 = Babar_Weaver_Ouro(lambda);

K1 = ns*K0;

K2 = n2*K0;



for n = 1:2*L+1
    
    
    Kx = ns*K0*sind(teta);
    
    Kz = ns*K0*cosd(teta);
    
    Kn(n) = Kx + (n-L-1)*Kg;
    
    if (abs(K1)^2) >= Kn(n)^2
        
        beta1(n) = sqrt(K1^2 - Kn(n)^2);
        
    else
        
        beta1(n) = -(j*sqrt(Kn(n)^2 - K1^2));
        
    end
    
    
    if (abs(K2)^2) >= Kn(n)^2
        
        beta2(n) = sqrt(K2^2 - Kn(n)^2);
        
    else
        
        beta2(n) = -(j*sqrt(Kn(n)^2 - K2^2));
        
    end
    
    
end


%MATRIZES F

for m=1:2*L+1
    
    for n=1:2*L+1
        
        
        F0(m,1) = (Kz^2-(m-L-1)*Kg*Kx)/(ns^2*Kz);
        
        F1(m,n) = ( beta1(n)^2-(m-n)*Kg*Kn(n))/(ns^2*beta1(n));
        
        F2(m,n) = ( beta2(n)^2-(m-n)*Kg*Kn(n))/(n2^2*beta2(n));
        
        
        
    end
    
    
end


for m = 1:2*L+1
    
    for n=1:2*L +1
        
        
        
        M1(m,n) = besselj(m-n,h*beta2(n));
        
        M2(m,n) = besselj(m-n,-h*beta1(n));
        
        M3(m,n) = F2(m,n)*besselj(m-n,h*beta2(n));
        
        M4(m,n) = F1(m,n)*besselj(m-n,-h*beta1(n));
        
        S1(m,1) = besselj(m-L-1,h*Kz);
        
        S2(m,1) = F0(m,1)*besselj(m-L-1,h*Kz);
        
        
        
    end
    
    
    
end

M = [M1 -M2;M3 M4];

Y = [S1;S2];

B = M;

B(:,3*L+2) = Y;

r = det(B)/det(M);

R = abs(r)^2;





end












