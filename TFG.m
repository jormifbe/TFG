clear all
%% PÉNDULO g

N = 250   %numeros aleatorios generados
nbins = 100

T = [2.52 2.51 2.5 2.51 2.52 2.53 2.52 2.51 2.51];           %medidas de ejemplo
mu_T = mean(T);                                              %para T tomamos media y std
sigma_T = std(T);
                             
mu_l = 1.592;                                                %para l, distr centrada en valor
sigma_l = 0.005;                                             % std es error de la medida

T_sim = normrnd(mu_T, sigma_T, N);
l_sim = normrnd(mu_l, sigma_l, N);                          % nums aleatorios distr gauss  

figure(1)
histogram(T_sim, nbins,'FaceColor','#FF7659')
xlabel('T(s)','FontName', 'Cambria Math','FontAngle', 'italic')                                              %histogramas de
ylabel('cuentas','FontAngle', 'italic')                                           %parametros de
title('T','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic')                                                  %entrada


figure(2)
histogram(l_sim, nbins,'FaceColor','#FFFA59')
xlabel('l(m)','FontName', 'Cambria Math','FontAngle', 'italic')                                              
ylabel('cuentas','FontAngle', 'italic')
title('l','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');


g = 4*(pi^2).*l_sim./(T_sim.^2);                             %cálculo de g
mu_g = mean(g(:));
sigma_g = std(g(:));                                         %std de los valores de g (error)


figure(3)
histogram(g, nbins,'FaceColor','#FFA938')
xlabel('g(m/s^{2})','FontName', 'Cambria Math','FontAngle', 'italic')                                        %histograma de g
ylabel('cuentas','FontAngle', 'italic')
title('g','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');


%% CILINDRO

r = normrnd(2, 0.5, N);                                  %radios aleatorios distr normal

figure(4)
histogram(r, nbins,'FaceColor','#38E3FF')
xlabel('r(mm)','FontName', 'Cambria Math','FontAngle', 'italic')
title('r','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');

h =normrnd(6.33, 1, N);                                               % h independiente

figure(5)
histogram(h, nbins,'FaceColor','#FF6141')
xlabel('h(mm)','FontName', 'Cambria Math','FontAngle', 'italic')
title('h','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');

S = 2*pi.*r.^2 + 2*pi.*h.*r;                            %Superficie
V = pi.*h.*r.^2;                                        %volumen

mu_S = mean(S(:))
sigma_S = std(S(:))

mu_V = mean(V(:))
sigma_V = std(V(:))


figure(6)
histogram(S, nbins,'FaceColor','#DE49FC')
xlabel('S(mm^{2})','FontName', 'Cambria Math','FontAngle', 'italic')
title('S','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');

figure(7)
histogram(V, nbins,'FaceColor','#DE49FC')
xlabel('V(mm^{3})','FontName', 'Cambria Math','FontAngle', 'italic')
title('V','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');