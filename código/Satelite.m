function drdt = Satelite(t,CI)

x = CI(1);
y = CI(2);
z = CI(3);

vel = CI(4:6);                 % 1) r' = v

planet
m = 10;

mu = (m*M)/(m+M);
alpha = G*m*M;

r = CI(1:3);    % r = [x;y;z]
rn = norm(r);   % norma
ru = r/rn;      % vector unitario


accel = -(alpha/mu).*ru./(rn.^2);                   % 2) mu r'' = - a/r^3 r



drdt = [vel;accel];   % sist eq diferenciales homogeneas      
