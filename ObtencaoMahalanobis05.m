% Define as variaveis simbolicas
syms rol pit gx gy

% Dados de entrada - Arduino ja envia roll, pitch e as variaveis no
% giroscopio em x e y.
entrada=[rol ; pit ;gx ;gy];

% Cada bloco trata os dados para montar a matriz que sera utilizada no
% programa em anexo ao Mahalanobis. Nos programas foi definida como matriz
% A. 

% Classe 1
cov1=cov(dados1');
mean1=mean(dados1');
d1 = sqrt((entrada-mean1')'*inv(cov1)*(entrada-mean1'))

% Classe 2
cov2=cov(dados2');
mean2=mean(dados2');
d2 = sqrt((entrada-mean2')'*inv(cov2)*(entrada-mean2'))

% Classe 3
cov3=cov(dados3');
mean3=mean(dados3');
d3 = sqrt((entrada-mean3')'*inv(cov3)*(entrada-mean3'))

% Classe 4
cov4=cov(dados4');
mean4=mean(dados4');
d4 = sqrt((entrada-mean4')'*inv(cov4)*(entrada-mean4'))

% Classe 5
cov5=cov(dados5');
mean5=mean(dados5');
d5 = sqrt((entrada-mean5')'*inv(cov5)*(entrada-mean5'))

%-------------------------
% Montagem da Matriz A
% A = [d1; d2; d3; d4; d5]
% ------------------------