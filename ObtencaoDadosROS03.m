% ------------------------------------------------------------------
% -------------- Universidade Federal de Juiz de Fora --------------
% -------- Programa de Pos-Graduacao em Engenharia Eletrica --------
% ------ Diego Albuquerque Carvalho e Guilherme Marins Maciel ------
% ------------------ USO LIVRE COM DEVIDA CITACAO ------------------
% ------------------------------------------------------------------

clc;

% Utilizado apenas a primeira vez, quando realizar a inicializacao do
% Sistema. Comentar esta linha para as proximas iteracoes
rosinit('192.168.0.150','Nodehost','192.168.0.150','NodeName','/matlab1');

% Inscrevendo no no do IMU
sub = rossubscriber('/imu_head');

% Classes para os 5 grupos de dados
c1=[];
c2=[]; 
c3=[];
c4=[];
c5=[];

% Cada classe sera atribuida a um dos grupos de dados
dados1=[0;0;0;0];
dados2=[0;0;0;0];
dados3=[0;0;0;0];
dados4=[0;0;0;0];
dados5=[0;0;0;0];

% Cria as matrizes com as classes de cada tipo. Vale salientar que sempre
% sera do neutro para outra classe, ou de uma classe para o neutro.
C = [2*ones(1,5),3*ones(1,5),4*ones(1,5),5*ones(1,5)];
B = [1*ones(1,length(C))];
C = C(randperm(length(C)));
A = [];

for k =1:1:length(C)
    A=[A [B(k) C(k)]]; 
end

% 5 Classes definidas
a=['NEUTRO  ';
   'DIREITA ';
   'ESQUERDA';
   'FRENTE  ';
   'ATRAS   '];

% O grupo neutro eh menor pq eh repetido mais vezes que os outros, na
% proporcao de 1x4, por isso eh usado 50 aquisicoes para o neutro e 200 para
% as demais classes
for k1 = 1:length(A);
    nt=200;
    if A(k1)==1
        nt=50;
    end
    for k2=1:nt
        % Receber os dados publicados pelo IMU
        data=receive(sub,1);
        out2=data.Data(1:4);
        
        for k3=1:10
            var=out2'+[0.03*randn(1,2) 0.003*randn(1,2)];
            % Atribui as classes para seus respectivos grupos
            switch A(k1)
                case 1
                    dados1=[dados1 , [var(1) ; var(2) ; var(3) ; var(4)]];
                case 2
                    dados2=[dados2 , [var(1) ; var(2) ; var(3) ; var(4)]];
                case 3
                    dados3=[dados3 , [var(1) ; var(2) ; var(3) ; var(4)]];
                case 4
                    dados4=[dados4 , [var(1) ; var(2) ; var(3) ; var(4)]];
                case 5
                    dados5=[dados5 , [var(1) ; var(2) ; var(3) ; var(4)]];
            end
        end
    end
    
    % ---------------------------------------------------------------------
    % Plot ----------------------------------------------------------------
    % ---------------------------------------------------------------------
    plot(dados1(1,:),dados1(2,:),'*k','markersize',1)
    hold on;
    plot(dados2(1,:),dados2(2,:),'*r','markersize',1)
    plot(dados3(1,:),dados3(2,:),'*b','markersize',1)
    plot(dados4(1,:),dados4(2,:),'*m','markersize',1)
    plot(dados5(1,:),dados5(2,:),'*g','markersize',1)
    disp('troca');
    title([num2str(k1),' ',num2str(k2),'; atual:', a(A(k1),:),'; next:',a(A(k1+1),:)])
    hold off
    grid on
    grid minor
    axis equal
    drawnow
    
    % Realizar o novo ciclo apenas quando houver movimentacao da cabeca
    while(abs(out2(3))+abs(out2(4))<0.5)
        data=receive(sub,1);
        out2=data.Data(1:4);
    end
end