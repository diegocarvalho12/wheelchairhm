% ------------------------------------------------------------------
% -------------- Universidade Federal de Juiz de Fora --------------
% -------- Programa de Pos-Graduacao em Engenharia Eletrica --------
% ------ Diego Albuquerque Carvalho e Guilherme Marins Maciel ------
% ------------------ USO LIVRE COM DEVIDA CITACAO ------------------
% ------------------------------------------------------------------                  

% Inicializacao
clc;
clear all;

% Inicializacao do ROS - Utilizar apenas caso ainda nao esteja iniciado. O
% ROS necessita ser iniciado apenas na primeira vez, em seguida pode-se
% subescrever no noh diretamente
% rosinit('192.168.0.150','Nodehost','192.168.0.153','NodeName','/matlab1');

% Inscrever-se no noh do IMU
sub = rossubscriber('/imu_head');

% Declaracao de variaveis
roll = []; pitch = [];
somar = 0;
somap = 0;

% Definicao do Mapa e posicionamento do Robo
% Necessario ter o arquivo VirtualRangefinder na mesma pasta para simular a
% Cadeira de Rodas
Mapa=7;
Robo.x=2000;
Robo.y=2000;
Robo.th=-90;
poses=[];
v=50; %v=150;
w=0;
x0=[Robo.x; Robo.y; Robo.th];
poses = [];
dados = [];

tic
while(1)
    dt = toc;
    tic
    % Entrada de dados
    data=receive(sub,1);
    out2=data.Data(1:4);
    var = out2';
    dados = [dados, [var(1) ; var(2) ; var(3) ; var(4)]];
    
    rollatual = var(1);
    pitchatual = var(2);
    
    % Funcao que classifica a qual classe pertence o dado
    classe = mahalanobis(rollatual, pitchatual, var(3), var(4))
    
    % Chamar a funcao do ambiente de simulacao
    poses = [poses, [Robo.x ; Robo.y]];
    SensorR = VirtualRangefinder3(Robo, Mapa);
    if classe == 1
        v=0;
        w=0;
    end
    if classe == 2
        v=0;
        w=-10;
    end
    if classe == 3
        v=0;
        w=10;
    end
    if classe == 4
        v=100;
        w=0;
    end
    if classe == 5
        v=-100;
        w=0; 
    end
    % Acionamento do Robo simulado
    Robo.x = Robo.x + v*dt*cosd(Robo.th+w*dt/2);
    Robo.y = Robo.y + v*dt*sind(Robo.th+w*dt/2);
    Robo.th = Robo.th + w*dt;
end