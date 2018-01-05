% ------------------------------------------------------------------
% -------------- Universidade Federal de Juiz de Fora --------------
% -------- Programa de Pos-Graduacao em Engenharia Eletrica --------
% ---------------- Diego Albuquerque Carvalho ----------------
% ------------------ USO LIVRE COM DEVIDA CITACAO ------------------
% ------------------------------------------------------------------

% Primeiro eh necessario carregar os dados Ax, Ay e Az crus para obtencao da
% matriz de correcao
% Recomenda-se salvar os dados por linha com o nome matriz

% ------------ Padrao de referencia ---------------------------------------
% ----------- Z_b baixo  [ 0  0  1g] --------------------------------------
% ----------- Z_b cima   [ 0  0 -1g] --------------------------------------
% ----------- Y_b baixo  [ 0 +1g 0 ] --------------------------------------
% ----------- Y_b cima   [ 0 -1g 0 ] --------------------------------------
% ----------- X_b baixo  [+1g 0  0 ] --------------------------------------
% ----------- X_b cima   [-1g 0  0 ] --------------------------------------
% -------------------------------------------------------------------------

% Carregar arquivo
load arquivo(mat)

% Matriz y foi usada utilizando a coleta de 100 dados para cada posicao
% considerando a ordem do padrao de referencia. Caso troque a ordem da
% movimentacao eh necessario ajustar a matriz y. Alem disso, a matriz esta
% ajustada para 10200 dados, ou seja 1700 dados de cada classe (passa-se
% por cada classe 17 vezes)

y = [zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
    zeros(100,1) zeros(100,1) ones(100,1);
    zeros(100,1) zeros(100,1) -ones(100,1);
    zeros(100,1) ones(100,1) zeros(100,1);
    zeros(100,1) -ones(100,1) zeros(100,1);
    ones(100,1) zeros(100,1) zeros(100,1);
    -ones(100,1) zeros(100,1) zeros(100,1);
];

% O padrao para obter a matriz de correcao exige uma matriz com os dados
% cru no formato [Ax Ay Az 1]
w = [matriz(:,1:3) ones(10200,1)];

% matriz de calibracao - Obtencao da matriz de correcao
xcorrecao = inv(w'*w)*w'*y;
