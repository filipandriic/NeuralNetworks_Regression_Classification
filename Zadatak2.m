clc, clear, close all

%% Ucitavanje podataka
load dataset1.mat

ob = pod(:, 1:2)';
klasa = pod(:, 3)';

K1 = ob(:, klasa == 1);
K2 = ob(:, klasa == 2);
K3 = ob(:, klasa == 3);

%% Podela skupova
izlaz = zeros(3, length(klasa));

izlaz(1, klasa == 1) = 1;
izlaz(2, klasa == 2) = 1;
izlaz(3, klasa == 3) = 1;

ulaz=ob;

%% Pregled klasa
figure, hold all
plot(K1(1, :), K1(2, :), 'o')
plot(K2(1, :), K2(2, :), '*')
plot(K3(1, :), K3(2, :), '+')

%% Podela podataka na trening i test skup
N = length(klasa);
ind = randperm(N);
ind_trening = ind(1 : 0.9 * N);
ind_test = ind(0.9 * N+1 : N);

ulaz_trening = ulaz(:, ind_trening);
izlaz_trening = izlaz(:,ind_trening);

ulaz_test = ulaz(:, ind_test);
izlaz_test = izlaz(:,ind_test);

%% Kreiranje neuralnih mreza
% Optimalna
net1 = patternnet([4 7 7]);

net1.divideFcn = '';
net1.trainFcn = 'trainscg';

net1.trainParam.epochs = 1000;
net1.trainParam.goal = 1e-3;
net1.trainParam.min_grad = 1e-4;

% Overfitting
net2 = patternnet([15 16 20 25 45]);

net2.divideFcn = '';
net2.trainFcn = 'trainscg';

net2.trainParam.epochs = 1000;
net2.trainParam.goal = 1e-3;
net2.trainParam.min_grad = 1e-4;

net2.layers{1}.transferFcn = 'poslin';
net2.layers{2}.transferFcn = 'poslin';
net2.layers{3}.transferFcn = 'poslin';
net2.layers{4}.transferFcn = 'poslin';
net2.layers{5}.transferFcn = 'poslin';

% Unfitting
net3 = patternnet([1]);

net3.divideFcn = '';
net3.trainFcn = 'trainscg';

net3.trainParam.epochs = 1000;
net3.trainParam.goal = 1e-3;
net3.trainParam.min_grad = 1e-4;

net3.layers{1}.transferFcn = 'poslin';

%% Treniranje neuralnih mreza
net1 = train(net1, ulaz_trening, izlaz_trening);
net2 = train(net2, ulaz_trening, izlaz_trening);
net3 = train(net3, ulaz_trening, izlaz_trening);

%% Konfuzione matrice
pred1 = net1(ulaz_test);
figure, plotconfusion(izlaz_test, pred1);

pred2 = net2(ulaz_test);
figure, plotconfusion(izlaz_test, pred2);

pred3 = net3(ulaz_test);
figure, plotconfusion(izlaz_test, pred3);

%% Performanse neuralne mreze net1
pred_test = net1(ulaz_test);
figure, plotconfusion(izlaz_test, pred_test)

[c, cm] = confusion(izlaz_test, pred_test);
cm = cm';

P1_test = cm(1, 1)/sum(cm(1, :));
R1_test = cm(1, 1)/sum(cm(:, 1));

pred_trening = net1(ulaz_trening);
figure, plotconfusion(izlaz_trening, pred_trening)

[c, cm] = confusion(izlaz_trening, pred_trening);
cm = cm';

P1_trening = cm(1, 1)/sum(cm(1, :));
R1_trening = cm(1, 1)/sum(cm(:, 1));

%% Performanse neuralne mreze net2
pred_test = net2(ulaz_test);
figure, plotconfusion(izlaz_test, pred_test)

[c, cm] = confusion(izlaz_test, pred_test);
cm = cm';

P2_test = cm(1, 1)/sum(cm(1, :));
R2_test = cm(1, 1)/sum(cm(:, 1));

pred_trening = net2(ulaz_trening);
figure, plotconfusion(izlaz_trening, pred_trening)

[c, cm] = confusion(izlaz_trening, pred_trening);
cm = cm';

P2_trening = cm(1, 1)/sum(cm(1, :));
R2_trening = cm(1, 1)/sum(cm(:, 1));

%% Performanse neuralne mreze net3
pred_test = net3(ulaz_test);
figure, plotconfusion(izlaz_test, pred_test)

[c, cm] = confusion(izlaz_test, pred_test);
cm = cm';

P3_test = cm(1, 1)/sum(cm(1, :));
R3_test = cm(1, 1)/sum(cm(:, 1));

pred_trening = net3(ulaz_trening);
figure, plotconfusion(izlaz_trening, pred_trening)

[c, cm] = confusion(izlaz_trening, pred_trening);
cm = cm';

P3_trening = cm(1, 1)/sum(cm(1, :));
R3_trening = cm(1, 1)/sum(cm(:, 1));

%% Granica odlucivanja
Ntest = 500;
x1 = repmat(linspace(-5, 5, Ntest), 1, Ntest);
x2 = repelem(linspace(-5, 5, Ntest), Ntest);
ulazGO = [x1; x2];

predGO = net1(ulazGO);
[vr, klasaGO] = max(predGO);

K1go = ulazGO(:, predGO(1, :) >= 0.5);
K2go = ulazGO(:, predGO(2, :) >= 0.5);
K3go = ulazGO(:, predGO(3, :) >= 0.5);

figure, hold all
plot(K1go(1, :), K1go(2, :), '.')
plot(K2go(1, :), K2go(2, :), '.')
plot(K3go(1, :), K3go(2, :), '.')
plot(K1(1, :), K1(2, :), 'bo')
plot(K2(1, :), K2(2, :), 'r*')
plot(K3(1, :), K3(2, :), 'yd')