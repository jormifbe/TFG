clear all

now = tic;

%%Distribucion inicial
M = 500;                                 % muestras MC
N = 5000;                               % iteraciones

sigma = 10;
rho = 28;                               % parametros Lorentz
beta = 8/3;

x = normrnd(5, 0.2, 1, M);
y = normrnd(7, 0.5, 1, M);              % distr entrada x,y,z iniciales
z = normrnd(5, 0.2, 1, M);

x0=x;
y0=y;                                   % guarda las CI
z0=z;

x0_scat = (x0 - mean(x0).*ones((size(x0))))./mean(x0).*ones((size(x0)));
y0_scat = (y0 - mean(y0).*ones((size(y0))))./mean(y0).*ones((size(y0)));     % dispersion normalizada
z0_scat = (z0 - mean(z0).*ones((size(z0))))./mean(z0).*ones((size(z0)));     % de CI respecto a medias


dt = 0.01;                              % paso dt de solucion de la diferencial

dx = zeros(N,M);
dy = zeros(N,M);                        % contendrá dxi
dz = zeros(N,M);

dx(1,:) = x;
dy(1,:) = y;
dz(1,:) = z;

x_out = dx;
y_out = dy;
z_out = dz;

for i = 1:N-1
    dx(i+1,:) = (sigma.*(y-x)).*dt;
    dy(i+1,:) = (x.*rho- z.*x - y).*dt;
    dz(i+1,:) = (x.*y - beta.*z).*dt;
    
    x = x + dx(i+1,:);
    y = y + dy(i+1,:);
    z = z + dz(i+1,:);
    
    x_out(i+1,:) = x;
    y_out(i+1,:) = y;
    z_out(i+1,:) = z;
    
    i
     
end


r_out = lorentz(mean(x),mean(y),mean(z),N);             % solucion con CI sin errores

x_ref = r_out(N,1)*ones(size(x_out));                   % estado final de la solucion con CI sin
y_ref = r_out(N,2)*ones(size(y_out));                   % errores con dim de x_out para restarlos 
z_ref = r_out(N,3)*ones(size(z_out));                   % y obtener la discrepancia entre cada 
                                                        % pto de la distr de salida y la sol sin errores              
x_scat = (x_out - x_ref)./x_ref;
y_scat = (y_out - y_ref)./y_ref;                        
z_scat = (z_out - z_ref)./z_ref;                        %discrepancias



%%% plots

%fig = figure(5);
%set(fig,'color','white')
%plot3(x_out(4000:4003,:),y_out(4000:4003,:),z_out(4000:4003,:),'-x')
%xlabel('X')
%ylabel('Y')
%zlabel('Z')
%grid on
%axis equal

fig = figure(2);
set(fig,'color','white')
plot3(x_out,y_out,z_out)
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on
axis equal

%%%% histogramas

figure(4)
histogram(x)
hold on
histogram(x0)
title('X','FontSize', 20)
xlabel('X')
legend('x_{f}','x_{0}')
figure(5)
histogram(y)
hold on
histogram(y0)
title('Y','FontSize', 20)
xlabel('Y')
legend('y_{f}','y_{0}')
figure()
histogram(z)
hold on
histogram(z0)
title('Z','FontSize', 20)
xlabel('Z')
legend('Z_{f}','Z_{0}')


%%%%% scatter plots

figure(7)
scatter(x_scat(N,:),y_scat(N,:),'k')
hold on
scatter(x0_scat,y0_scat, 0.2,'r','.')
title('XY_{f}','FontSize', 20)
legend('xy_{f}','xy_{0}')
xlabel('X')
ylabel('Y')
figure(8)
scatter(x_scat(N,:),z_scat(N,:),'k')
hold on
scatter(x0_scat,z0_scat, 0.2,'r','.')
title('XZ_{f}','FontSize', 20)
legend('xz_{f}','xz_{0}')
xlabel('X')
ylabel('Z')
figure(9)
scatter(y_scat(N,:),z_scat(N,:),'k')
hold on
scatter(y0_scat,z0_scat, 0.2,'r','.')
title('YZ_{f}','FontSize', 20)
legend('yz_{f}','yz_{0}')
xlabel('Y')
ylabel('Z')


tiempo = toc(now)