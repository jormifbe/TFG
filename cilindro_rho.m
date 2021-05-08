clear all

mu = [2 6.3];                      %medias cada vector
sigma = [0.5  0.7                    % matriz covarianza
       0.7  2.0];

n = 50000;

Z = mvnrnd(mu, sigma, n);             

r = Z(:,1);                        %asignacion de vectores
h = Z(:,2);                        % r y h para la matriz de salida

S = 2*pi.*r.^2 + 2*pi.*h.*r;      %Calculo S y V                      
V = pi.*h.*r.^2;      

%plots
figure(1)
histogram(r,'FaceColor','#38E3FF')
xlabel('r(mm)','FontName', 'Cambria Math','FontAngle', 'italic')
title('r','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');

figure(2)
histogram(h,'FaceColor','#FF6141')
xlabel('h(mm)','FontName', 'Cambria Math','FontAngle', 'italic')
title('h','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');

figure(3)
histogram(S,'FaceColor','#DE49FC')
xlabel('S(mm^{2})','FontName', 'Cambria Math','FontAngle', 'italic')
title('S','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');

figure(4)
histogram(V,'FaceColor','#DE49FC')
xlabel('V(mm^{3})','FontName', 'Cambria Math','FontAngle', 'italic')
title('V','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');
