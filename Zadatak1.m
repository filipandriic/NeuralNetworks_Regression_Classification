clc, clear, close all;

%% Podesavanje parametara
A = 3;
B = 3;
f1 = 5;
f2 = 3;

N = 3000;
x = linspace(0, 1, N);
h = A * sin(2 * pi * f1 * x) + B * sin(2 * pi * f2* x);
std = 0.2 * min(A, B);
s = randn(size(x)) * std;
y = h + s;

%% Iscrtavanje mreze
figure, hold all;

plot(x, y);
plot(x, h, "r", 'LineWidth', 3);

ulaz = x;
izlaz = y;

%% Podela podataka na trening i test skup
ind = randperm(N);
ind_trening = ind(1 : 0.9 * N);
ind_test = ind(0.9 * N+1 : N);

ulaz_trening = ulaz(ind_trening);
izlaz_trening = izlaz(ind_trening);

ulaz_test = ulaz(ind_test);
izlaz_test = izlaz(ind_test);

%% Kreiranje neuralne mreze
net = fitnet([4 7 7]);

net.divideFcn = '';
net.trainFcn = 'trainlm';

net.trainParam.epochs = 3000;
% Iskljucivanje zastite od preobucavanja
net.trainParam.goal = 1e-3;
net.trainParam.min_grad = 1e-4;

%% Treniranje neuralne mreze
net = train(net, ulaz_trening, izlaz_trening);

%% Performanse neuralne mreze
pred = sim(net, ulaz_test); 

figure, hold all;
plot(ulaz_test, izlaz_test, 'o');
plot(ulaz_test, pred, '*');

figure, hold all;
plot(ulaz, izlaz)
plot(ulaz, net(ulaz), 'LineWidth', 3)