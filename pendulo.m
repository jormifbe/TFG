clear all
%% PÉNDULO g

M = 50;                                                       % medidas para evitar Student
N = 250;                                                      %numeros generados para Montecarlo
nbins = 100;                                                  %barras histograma
mbins = 5;

T = [2.52 2.51 2.5 2.51 2.52 2.53 2.52 2.51 2.51];           %medidas de ejemplo
mu_T = mean(T);                                              %para T tomamos media y std
sigma_T = std(T);
                             
mu_l = 1.592;                                                %para l, distr centrada en valor
sigma_l = 0.005;                                             % std es error de la medida


T_teo = normrnd(mu_T, sigma_T, M, 1);
l_teo = normrnd(mu_l, sigma_l, M, 1) ;                      % nums aleatorios distr gauss (analitico) 

T_sim = normrnd(mu_T, sigma_T, N);
l_sim = normrnd(mu_l, sigma_l, N);                          % nums aleatorios distr gauss (Montecarlo) 

figure(1)
histogram(T_sim, nbins,'FaceColor','#FF7659')
xlabel('T(s)','FontName', 'Cambria Math','FontAngle', 'italic')                                              %histogramas de
ylabel('cuentas','FontAngle', 'italic')                                                                      %parametros de
title('T','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic')             %entrada


figure(2)
histogram(l_sim, nbins,'FaceColor','#FFFA59')
xlabel('l(m)','FontName', 'Cambria Math','FontAngle', 'italic')                                              
ylabel('cuentas','FontAngle', 'italic')
title('l','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');


figure(3)
histogram(T_teo, mbins,'FaceColor','#66ff8f')
xlabel('T(s)','FontName', 'Cambria Math','FontAngle', 'italic')                                              %histogramas de
ylabel('cuentas','FontAngle', 'italic')                                                                      %parametros de
title('T','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic')             %entrada


figure(4)
histogram(l_teo, mbins,'FaceColor','#66ff8f')
xlabel('l(m)','FontName', 'Cambria Math','FontAngle', 'italic')                                              
ylabel('cuentas','FontAngle', 'italic')
title('l','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');


g = 4*(pi^2).*l_sim./(T_sim.^2);                             %cálculo de g
mu_g = mean(g(:));
sigma_g = std(g(:))                                        %std de los valores de g (error)
moda = mode(g(:));
mediana = median(g(:));
curt = kurtosis(g(:));
asim = skewness(g(:));
x=(g-mu_g)/sigma_g   ;                   %el test se hace para distr centrada en 1
Normalidad = kstest(x(:));





figure(5)
histogram(g, nbins,'FaceColor','#FFA938')
xlabel('g(m/s^{2})','FontName', 'Cambria Math','FontAngle', 'italic')                                        %histograma de g
ylabel('cuentas','FontAngle', 'italic')
title('g','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');
