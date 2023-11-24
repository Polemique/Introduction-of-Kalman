clear;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARTIE I

% Voir fonctions


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARTIE II

%%% Estimation d'une constante

load('reservoir1.mat');

% Pn et Qv sont de la même taille
G = zeros(1, 100);
P = zeros(1, 100);
Z = zeros(1, 100);

% Initialisations
A = 1;
C = 1;
Qv = 0;
Qb = 0.1;
P(1) = 10;
G(1) = (P(1) * C) / (C' * P(1) * C + Qb);
Z(1) = 0; %y(1);

% for i = 2:length(y) 
%     [G(i), P(i)] = update_filter(G(i-1), P(i-1), C, A, Qb, Qv);
%     Z(i) = predict(Z(i-1), y(i), A, C, G(i));
% end

% figure
% hold on
% for P = [0.1 1 5 10]
%     for i = 2:length(y)
%         [G(i), P(i)] = update_filter(G(i-1), P(i-1), C, A, Qb, Qv);
%         Z(i) = predict(Z(i-1), y(i), A, C, G(i));
%     end
%     plot(Z);
% end
% title('Prediction et floteur reel différents P')
% legend('P = 0.1', 'P = 1', 'P = 5', 'P = 10')
% hold off


% figure
% subplot(131)
% plot(y)
% hold on
% plot(Z)
% title("Prediction et floteur reel pour Qb = 1")
% hold off
% legend("Flotteur", "Prediction")
% 
% subplot(132)
% plot(P)
% title("P")
% 
% subplot(133)
% plot(G)
% title("G")


%%% Estimation d'une augmentation constante

load('reservoir2.mat');

A =  [1 0; 1 1];
C = [0; 1];

Qv = zeros(2); 
Qb = 0.1;

pn = ones(2);
P = [pn];

gn = (pn * C) / (C' * pn * C + Qb);
G = [gn];

Zn = [0; 0];
Z = [Zn];

for i=2:length(y)-1

    [gn, pn] = update_filter(gn, pn, C, A, Qb, Qv);
    Zn = predict(Zn, y(i), A, C, gn);
    P = [P pn];
    G = [G gn];
    Z = [Z Zn];

end

% figure
% plot(1:length(Z(1,:)), Z(1,:));
% hold on;
% plot(1:length(Z(2,:)), Z(2,:));
% hold on;
% plot(1:length(y), y);
% hold off
% title("Estimation d'une augmentation constante")
% legend(["Estimation de la vitesse", "Estimation de la position", "Observation de la position"]);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARTIE III


load('cible.mat')

dt = 0.2;

A = [1 dt; 0 1];
C = [1; 0];

Qb = sqrt(10);
Qv = 0.1 * [(dt^4) / 4, (dt^2) / 2; (dt^2) / 2, 1];

pn = ones(2);
P = [pn];

gn = (pn * C) / (C' * pn * C + Qb);
G = [gn];

Zn = [0; 0];
Z = [Zn];

for i = 2:length(y) 
    [gn, pn]  = update_filter(gn, pn, C, A, Qb, Qv);
    Zn = predict(Zn, y(i), A, C, gn);
    P = [P pn];
    G = [G gn];
    Z = [Z Zn];

end

% figure
% subplot(211)  
% plot(P(:, (1:2:length(P)))')
% title('P')
% xlabel('n')
% 
% subplot(212)  
% plot(G')
% title('G')
% xlabel('n')


% figure
% subplot(211)
% plot(1:length(x(1,:)), x(1,:));
% hold on;
% plot(1:length(Z(1,:)), Z(1,:));
% hold off;
% legend(["Observation de la position", "Prédiction de la position"]);
% 
% subplot(212)
% plot(1:length(x(2,:)), x(2,:));
% hold on;
% plot(1:length(Z(2,:)), Z(2,:));
% hold off;
% legend(["Observation de la vitesse", "Prédiction de la vitesse"]);

zn = [0; 0];
Z = [zn];

P = [pn]; %le dernier du run précédent
G = [gn]; %le dernier du run précédent

for i = 2:length(y) 
    [gn, pn]  = update_filter(gn, pn, C, A, Qb, Qv);
    Zn = predict(Zn, y(i), A, C, gn);
    P = [P pn];
    G = [G gn];
    Z = [Z Zn];

end


% figure
% subplot(211)  
% plot(P(:, (1:2:length(P)))')
% title('P')
% xlabel('n')
% 
% subplot(212)  
% plot(G')
% title('G')
% xlabel('n')
% 
% figure
% subplot(211)
% plot(1:length(x(1,:)), x(1,:));
% hold on;
% plot(1:length(Z(1,:)), Z(1,:));
% hold off;
% legend(["Observation de la position", "Prédiction de la position"]);
% 
% subplot(212)
% plot(1:length(x(2,:)), x(2,:));
% hold on;
% plot(1:length(Z(2,:)), Z(2,:));
% hold off;
% legend(["Observation de la vitesse", "Prédiction de la vitesse"]);