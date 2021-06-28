clear all

now = tic();

N = 400;

%Distribuciones para MC
poiss0 = makedist('Poisson','lambda',0.1);
poiss1 = makedist('Poisson','lambda',1);
cauchy =  makedist('tLocationScale','mu',1,'sigma',1,'nu',1);
gamma = makedist('Gamma', 'a', 2, 'b', 0.1);
tri = makedist('Triangular', 'a', 0.8, 'b',1,'c',1.2);

%Parametros de la Tierra y sat
tierra
m=10; % masa sat


%Condiciones iniciales
h = 900*1000;
hv = h.*random(gamma,N,1);           %altitud sat
histogram(hv)
%hv = h.*exprnd(1,N,1);          

x0 = R + hv;
y0 = exprnd(0.001,N,1);            % pos iniciales
z0 = exprnd(0.001,N,1); 

incl = 51.6*pi/180;                  %inclinación de la órbita ISS
vi = sqrt(G*M/(R+h));                %velocidad orbital a h

dx0 = zeros(N,1);
dy0 = vi*cos(incl).*random(tri,N,1);        %velocidades iniciales
dz0 = vi*sin(incl).*random(tri,N,1);



CI = [x0 y0 z0 dx0 dy0 dz0];                    % vector Condiciones Iniciales

%Tiempo de órbita
torb = [0 0.2*2*pi/sqrt(G*M)*(R+h)^(3/2)];           % el 0.2 es para que haga 1/5 de orbita

S = [R+h 0 0 0 0 0] ;                            % vectores para concatenar en el for
T = [0];

%%% Sol numerica de la eq dif
for i = 1:N
    [tout,stateout] = ode45(@Satelite,torb,CI(i,:));
    
    S = cat(1, S, stateout);
    T = cat(1, T, tout);
    disp(i)
end


%paso a km
S = S./1000;


%Coordenadas resultantes

xf = S(:,1);
yf = S(:,2);
zf = S(:,3);

% Tierra 
[X,Y,Z] = sphere(100);
X = X*R/1000;
Y = Y*R/1000;
Z = Z*R/1000;


%Plot trayectorias vs tiempo
fig0=figure(1);
set(fig0,'color','white')
plot(T,xf,'b-','LineWidth',0.2)
hold on
grid on
plot(T,yf,'r.-','LineWidth',0.2)
plot(T,zf,'g--','LineWidth',0.2)
xlabel('T(s)')
ylabel('Posicion(m)')
legend('X','Y','Z')

%Plot 3D 
fig=figure(2);
set(fig,'color','white')
plot3(xf,yf,zf,'LineWidth',1)
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on
hold on
surf(X,Y,Z,'EdgeColor','none','FaceColor','interp')
axis equal

%Distribuciones CI
%figure(3)
%histogram(x0)
%figure(4)
%histogram(y0)
%figure(5)
%histogram(z0)
%figure(6)
%histogram(dx0)
%figure(7)
%histogram(dy0)
%figure(8)
%histogram(dz0)

figure(3)
histogram(xf)
title('x_{final}')
xlabel('x(km)')

figure(4)
histogram(yf)
title('y_{final}')
xlabel('y(km)')
figure(5)
histogram(zf)
title('z_{final}')
xlabel('z(km)')
figure(6)
histogram(dx0)
figure(7)
histogram(dy0)
figure(8)
histogram(dz0)


t_calc = toc(now)                       %1s (N=10); 
                                        %11.052s (N=100);
