function r_out = lorentz(x,y,z,N)

sigma = 10;
rho = 28;
beta = 8/3;

dt = 0.01;

dx = zeros(N,1);
dy = zeros(N,1);
dz = zeros(N,1);

dx(1,1) = x;
dy(1,1) = y;
dz(1,1) = z;

r_out = [dx dy dz];

for i = 1:N-1
    dx(i+1,1) = (sigma*(y-x))*dt;
    dy(i+1,1) = (x*rho- z*x - y)*dt;
    dz(i+1,1) = (x*y - beta*z)*dt;
    
    x = x + dx(i+1,1);
    y = y + dy(i+1,1);
    z = z + dz(i+1,1);
    
    r_out(i+1,1) = x;
    r_out(i+1,2) = y;
    r_out(i+1,3) = z;
    
    disp(i)
    
end

fig = figure();
set(fig,'color','white')
plot3(r_out(:,1),r_out(:,2),r_out(:,3),'r')
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on
axis equal





