% ------------------------------------------------------------------
% -------------- Universidade Federal de Juiz de Fora --------------
% -------- Programa de Pos-Graduacao em Engenharia Eletrica --------
% ------ Diego Albuquerque Carvalho e Guilherme Marins Maciel ------
% ------------------ USO LIVRE COM DEVIDA CITACAO ------------------
% ------------------------------------------------------------------

% -------------------------------------------------------------------------
% ------------- Tutorial antes de iniciar este programa -------------------
% 1) Abrir o terminal do Linux onde rodaremos o roscore
% 2) digite: roscore
% 3) Abra outro terminal
% 4) digite: rosrun rosserial_python serial_node.py /dev/ttyACM0
% ACM0 indica a porta em que o Arduino com IMU esta conectado. Confira se o
% arduino realmente esta conectado nesta porta para prosseguir

% Deve ser digitado no terminal do computador que sera usado para rodar o
% simulador;
% 7) Pronto, seu simulador ja deve responder aos seus comandos com
% movimentos de cabeca
% -------------------------------------------------------------------------

clear;
clc; 
close all;

% Inicializacao do ROS - utilizar quando inicializar o ROS - alterar de
% acordo com o IP da máquina e do host
% rosinit('192.168.0.146','Nodehost','192.168.0.103','NodeName','/matlab1');

% Define publicadores - velocidade e tipo de mensagem
pub = rospublisher('/RosAria/cmd_vel');
andar = rosmessage('geometry_msgs/Twist');

% Se inscreve nos nos do IMU e hodometria do robo
odomsub = rossubscriber('/RosAria/pose');
imusub = rossubscriber('/imu_head');

while(1)
    
    % recebe leituras do laser
    odomdata = receive(odomsub, 1);
    
    % recebe leituras do imu - roll, pitch, gx e gy
    imudata = receive(imusub, 1);
    
    % atribuir os valores recebidos do arduino
    roll = imudata.Data(1);
    pitch = imudata.Data(2);
    gx = imudata.Data(3);
    gy = imudata.Data(4);
    
    % chamar a funcao mahala para atribuir a classe correta para o posicionamento    
    % classe = matrizclassificacao(roll,pitch,gx,gy)
    classe = mahalanobis(roll,pitch,gx,gy)
    
    % atribuir as velocidades corretas de acordo com a classe. Neste caso as
    % as variaveis estao em v = [m/s] e w = [rad/s]
    if classe == 1
        v=0;
        w=0;
    end
    if classe == 2
        v=0;
        w=-0.37;
    end  
    if classe == 3
        v=0;
        w=0.37;
    end
    if classe == 4
        v=0.3;
        w=0;
    end
    if classe == 5
        v=-0.3;
        w=0; 
    end
    
    % Enviar o valor de velocidade linear e angular para o robo       
    andar.Linear.X = v;
    andar.Angular.Z = w;
    send(pub,andar);
end