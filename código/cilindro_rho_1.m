clear all


%% rho = 1 (h=f(r))

M = 50;                                                       % # medidas para evitar Student
N = 250;                                                      % numeros generados para Montecarlo
nbins = 100;                                                  % barras histograma
mbins = 5;

rt = normrnd(2, 0.5, M,1); 
r = normrnd(2, 0.5, N);                                       %radios aleatorios distr normal

ht = 2.*rt;
h = 2.*r;                                                     % h = f(r) -> rho = 1


figure(1)
histogram(rt, mbins,'FaceColor','#66ff8f')
xlabel('r (mm)','FontName', 'Cambria Math','FontAngle', 'italic')                                         %histogramas de
ylabel('cuentas','FontAngle', 'italic')                                                                   %parametros de
title('r','FontName', 'Cambria Math', 'FontSize',18, 'FontWeight', 'bold','FontAngle', 'italic')          %entrada 

                                                                                                            %(analitico)

figure(2)
histogram(ht, mbins,'FaceColor','#66ff8f')
xlabel('h(mm)','FontName', 'Cambria Math','FontAngle', 'italic')                                              
ylabel('cuentas','FontAngle', 'italic')
title('h','FontName', 'Cambria Math', 'FontSize',18, 'FontWeight', 'bold','FontAngle', 'italic');           %Montecarlo


figure(3)
histogram(r, nbins,'FaceColor','#38E3FF')
xlabel('r(mm)','FontName', 'Cambria Math','FontAngle', 'italic')
title('r','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');


figure(4)
histogram(h, nbins,'FaceColor','#FF6141')
xlabel('h(mm)','FontName', 'Cambria Math','FontAngle', 'italic')
title('h','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');


% Analitico

rtavg = mean(rt);
htavg = mean(ht);

srt = std(rt);
sht = std(ht);

St = 2*pi.*rtavg.^2 + 2*pi.*htavg.*rtavg;                 %Propagacion de errores en excel
Vt = pi.*htavg.*rtavg.^2;


% Montecarlo
S = 2*pi.*r.^2 + 2*pi.*h.*r;                            %Superficie
V = pi.*h.*r.^2;                                        %volumen

mu_S = mean(S(:))
sigma_S = std(S(:))

mu_V = mean(V(:))
sigma_V = std(V(:))

moda = mode(S(:))
mediana = median(S(:))
curt = kurtosis(S(:))
asim = skewness(S(:))
x=(S-mu_S)/sigma_S;                      %el test se hace para distr centrada en 1
Normalidad = kstest(x(:))

moda2 = mode(V(:))
mediana2 = median(V(:))
curt2 = kurtosis(V(:))
asim2 = skewness(V(:))
x2=(V-mu_V)/sigma_V;                      %el test se hace para distr centrada en 1
Normalidad2 = kstest(x2(:))


figure(5)
histogram(S, nbins,'FaceColor','#DE49FC')
xlabel('S(mm^{2})','FontName', 'Cambria Math','FontAngle', 'italic')
title('S','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');

figure(6)
histogram(V, nbins,'FaceColor','#DE49FC')
xlabel('V(mm^{3})','FontName', 'Cambria Math','FontAngle', 'italic')
title('V','FontName', 'Cambria Math', 'FontSize',15, 'FontWeight', 'bold','FontAngle', 'italic');



