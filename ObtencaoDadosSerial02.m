% ------------------------------------------------------------------
% -------------- Universidade Federal de Juiz de Fora --------------
% -------- Programa de Pos-Graduacao em Engenharia Eletrica --------
% ------ Diego Albuquerque Carvalho e Guilherme Marins Maciel ------
% ------------------ USO LIVRE COM DEVIDA CITACAO ------------------
% ------------------------------------------------------------------

% Utilizar se ocorrer algum problema na porta e for necessario encerra-la
% para iniciar o processo novamente
% fclose(s);

% Inicializacao e configuracao da porta. Trocar o valor da porta de acordo
% com a porta em que o Arduino estiver conectado.
clc;
clear all;
delete(instrfindall);
pause(2);
s=serial('COM6');
set(s,'BaudRate',9600);
pause(0.5);
fopen(s);

% Inicio do protocolo de envio de dados do Arduino para a Serial. Inclusao
% de um tempo de espera a fim de melhorar o funcionamento do programa e
% garantir que nao envie dados antes da abertura completa da porta serial.
%%%%%% rodar ate aqui esperar 2s %%%%%
pause(2);
fprintf(s,'a ');

% Pedir para que o programa peca 6 saidas do IMU. Podemos acontecer dos
% primeiros dados falharem, desta forma, garante-se que os dados que serao
% tratados estejam de acordo com o esperado do programa.
%%%%%% rodar ate aqui esperar 2 s %%%%%
for j = 1:6
    pause(0.1);
    fprintf(s,'T');
    out=fscanf(s);
    out2=str2num(out);
end

m = 0;

% No total realiza a aquisicao de 10000 dados
for k1 = 1:100;
    m = m + 1;
    if m == 6
        m = 1;
    end
    m
    classe = m*ones(100,1);
    ax=[];
    ay=[];
    az=[];
    gx=[];
    gy=[];
    gz=[];
    mx=[];
    my=[];
    mz=[];
    
    for k = 1:100;
        fprintf(s,'T');
        out = fscanf(s);
        out2 = str2num(out)
        ax = [ax out2(1)];
        ay = [ay out2(2)];
        az = [az out2(3)];
        gx = [gx out2(4)];
        gy = [gy out2(5)];
        gz = [gz out2(6)];
        mx = [mx out2(7)];
        my = [my out2(8)];
        mz = [mz out2(9)];
                 
        % Matriz de Correcao para os dados - caso gere outra e necessario
        % alterar
        xcorrecao = [0.00006147844, 0.0000606373, 0.00006056773;
                     0.0000004262922, -0.000000407563, -0.0000009520133;
                     -0.0000002167082, 0.0000005529877, -0.0000007607212;
                     -0.04212447, -0.002551615, 0.1074834];
        roll = [];
        pitch = [];
        z = [out2(1) out2(2) out2(3) ones(1,1)]*xcorrecao;
        roll = atan2(z(1,2),z(1,3));
        pitch = atan(-z(1,1)/(z(1,2) * sin(roll) + z(1,3) * cos(roll)));
        
        % -----------------------------------------------------------------
        % Plot ------------------------------------------------------------
        % -----------------------------------------------------------------
        hold on
        switch m
            case 1
                plot(roll,pitch,'b.');
                drawnow;
            case 2
                plot(roll,pitch,'r.');
                drawnow;
            case 3
                plot(roll,pitch,'g.');
                drawnow;
            case 4
                plot(roll,pitch,'m.');
                drawnow;
            case 5
                plot(roll,pitch,'k.');
                drawnow;
        end
        hold on
    end
    
    fprintf(s,'T');
    out=fscanf(s);
    out2=str2num(out);
    
    % Orientar o usuario para trocar de posicao
    display('troca');
        while(abs(out2(4))+abs(out2(5))<2000)
            fprintf(s,'T');
            out=fscanf(s);
            out2=str2num(out);
        end
    
    if k1 == 1
        matriz = [ax' ay' az' gx' gy' gz' mx' my' mz' classe];
    else
        matriz = [matriz;
                  ax' ay' az' gx' gy' gz' mx' my' mz' classe];
    end
end