clear all
%% PÉNDULO g

i = 1 
j = 1

M = 50;                                                      % medidas para evitar Student
N = 1000;                                                    % numeros generados para Montecarlo
nbins = 100;                                                 % barras histograma
mbins = 5;
kbins = 50;

T = [2.52 2.51 2.5 2.51 2.52 2.53 2.52 2.51 2.51];           % medidas de ejemplo
mu_T = mean(T);                                              % para T tomamos media y std
sigma_T = std(T);
                             
mu_l = 1.592;                                                % para l, distr centrada en valor
sigma_l = 0.005;                                             % std es error de la medida

now = tic()
T_teo = normrnd(mu_T, sigma_T, M, 1);
l_teo = normrnd(mu_l, sigma_l, M, 1) ;                       % nums aleatorios distr gauss (analitico) 

T_sim = normrnd(mu_T, sigma_T, N, 1);
l_sim = normrnd(mu_l, sigma_l, N, 1);                        % nums aleatorios distr gauss (Montecarlo) 


g = zeros(N,N);

Tgpu = gpuArray(T_sim);
lgpu = gpuArray(l_sim);
ggpu = gpuArray(g);


for i = 1:N
    for j = 1:N
        ggpu(i,j) = 4*(pi^2).*lgpu(i)./(Tgpu(j).^2);         %cálculo de g
    end
end
        


g = gather(ggpu);

mu_g = mean(g(:));
sigma_g = std(g(:))                                          % std de los valores de g (error)
mediana = median(g(:));
curt = kurtosis(g(:));
asim = skewness(g(:));

tiemp = toc(now)

%% plots

figure(1)
histogram(T_sim, kbins,'FaceColor','#FF7659')
xlabel('T(s)','FontName', 'Cambria Math','FontAngle', 'italic')                                              %histogramas de
ylabel('cuentas','FontAngle', 'italic')                                                                      %parametros de
title('T','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic')             %entrada


figure(2)
histogram(l_sim, kbins,'FaceColor','#FFFA59')
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

figure(5)
histogram(g, nbins,'FaceColor','#FFA938')
xlabel('g(m/s^{2})','FontName', 'Cambria Math','FontAngle', 'italic')                                        %histograma de g
ylabel('cuentas','FontAngle', 'italic')
title('g','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');

figure(6)
normplot(g(:))
