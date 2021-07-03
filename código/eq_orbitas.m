clear all

now = tic();

N = 2500;

%Distribuciones para MC
poiss0 = makedist('Poisson','lambda',0.1);
poiss1 = makedist('Poisson','lambda',1);
cauchy =  makedist('tLocationScale','mu',1,'sigma',10,'nu',1);
gamma = makedist('Gamma', 'a', 3, 'b', 4);
tri = makedist('Triangular', 'a', 0.8, 'b',1,'c',1.2);

%Parametros de la Tierra y sat
tierra
m=10; % masa sat


%Condiciones iniciales
h = 400*1000;
hv = h.*normrnd(1, 0.1, N,1);           %altitud sat
histogram(hv)
%hv = h.*exprnd(1,N,1);          

x0 = R.*ones(N,1) + hv;
y0 = exprnd(1,N,1);            % pos iniciales
z0 = exprnd(1,N,1); 

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

x_plot = zeros(N,1);
y_plot = zeros(N,1);
z_plot = zeros(N,1);                            % inicializacion vectores que solo contendrán
vx_plot = zeros(N,1);                           % el estado final
vy_plot = zeros(N,1);
vz_plot = zeros(N,1);


%%% Sol numerica de la eq dif
for i = 1:N
    [tout,stateout] = ode45(@Satelite,torb,CI(i,:));
    disp(i)
    % Solo dejamos pasar puntos de la trayectoria con sentido fisico (>R tierra)
           
    S = cat(1, S, stateout);
    T = cat(1, T, tout);
    
   
    
    ult = length(stateout);
    
    x_plot(i) = stateout(ult,1);
    y_plot(i) = stateout(ult,2);
    z_plot(i) = stateout(ult,3);                % solo estado final
    vx_plot(i) = stateout(ult,4);
    vy_plot(i) = stateout(ult,5);
    vz_plot(i) = stateout(ult,6);
    
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



%Plot 3D 
fig=figure(2);
set(fig,'color','white')
plot3(xf,yf,zf,'b.','MarkerSize',1)
xlabel('X (km)')
ylabel('Y (km)')
zlabel('Z (km)')
grid on
hold on
surf(X,Y,Z,'EdgeColor','none','FaceColor','interp')
axis equal

%Distribuciones CI y EF
figure(6)
histogram(dx0)
title('v_{x_{inicial}}', 'FontSize', 22)
xlabel('v_{x}(m/s)', 'FontSize', 20)
ylabel('frecuencia')
figure(7)
histogram(dy0)
title('v_{y_{inicial}}', 'FontSize', 22)
xlabel('v_{y}(m/s)', 'FontSize', 20)
ylabel('frecuencia')
figure(8)
histogram(dz0)
title('v_{z_{inicial}}', 'FontSize', 22)
xlabel('v_{z}(m/s)', 'FontSize', 20)
ylabel('frecuencia')

figure(3)
histogram(vx_plot)
title('v_{x_{final}}', 'FontSize', 22)
xlabel('v_{x}(m/s)', 'FontSize', 20)
ylabel('frecuencia')

figure(4)
histogram(vy_plot)
title('v_{y_{final}}', 'FontSize', 22)
xlabel('v_{y}(m/s)', 'FontSize', 20)
ylabel('frecuencia')

figure(5)
histogram(vz_plot)
title('v_{z_{final}}', 'FontSize', 22)
xlabel('v_{z}(m/s)', 'FontSize', 20)
ylabel('frecuencia')

                                                     
figure(3)
histogram(x_plot)
title('x_{final}', 'FontSize', 22)
xlabel('x(m)', 'FontSize', 20)
ylabel('frecuencia')

figure(4)
histogram(y_plot)
title('y_{final}', 'FontSize', 22)
xlabel('y(m)', 'FontSize', 20)
ylabel('frecuencia')

figure(5)
histogram(z_plot)
title('z_{final}', 'FontSize', 22)
xlabel('z(m)', 'FontSize', 20)
ylabel('frecuencia')

figure(6)
histogram(x0)
title('x_{inicial}', 'FontSize', 22)
xlabel('x(m)', 'FontSize', 20)
ylabel('frecuencia')
figure(7)
histogram(y0)
title('y_{inicial}', 'FontSize', 22)
xlabel('y(m)', 'FontSize', 20)
ylabel('frecuencia')
figure(8)
histogram(z0)
title('z_{inicial}', 'FontSize', 22)
xlabel('z(m)', 'FontSize', 20)
ylabel('frecuencia')



% Estadística distr salida
mu_x = mean(x_plot)
sigma_x = std(x_plot)

mu_y = mean(y_plot)
sigma_y = std(y_plot)

mu_z = mean(z_plot)
sigma_z = std(z_plot)

medianaX = median(x_plot)
curtX = kurtosis(x_plot)
asimX = skewness(x_plot)

medianaY = median(y_plot)
curtY = kurtosis(y_plot)
asimY = skewness(y_plot)

medianaZ = median(z_plot)
curtZ = kurtosis(z_plot)
asimZ = skewness(z_plot)

tiempo = toc(now)                                     
