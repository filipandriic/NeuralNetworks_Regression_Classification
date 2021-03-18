clc, clear, close all

%% Ucitavanje podataka
table = csvread("CO2_dataset.csv",1,0);
izlaz = table(:, 10)';
ulaz = table(:, 1 : 9)';

%% Podela na klase

K1ulaz = ulaz(:, izlaz > 0 & izlaz < 7.5);
K1izlaz = izlaz(izlaz > 0 & izlaz < 7.5);

K2ulaz = ulaz(:, izlaz >= 7.5 & izlaz < 15);
K2izlaz = izlaz(izlaz >= 7.5 & izlaz < 15);

K3ulaz = ulaz(:, izlaz >= 15 & izlaz < 22.5);
K3izlaz = izlaz(izlaz >= 15 & izlaz < 22.5);

K4ulaz = ulaz(:,izlaz>=22.5 & izlaz<30);
K4izlaz = izlaz(izlaz>=22.5 & izlaz<30);

K5ulaz = ulaz(:,izlaz>=30 & izlaz<37.5);
K5izlaz = izlaz(izlaz>=30 & izlaz<37.5);

K6ulaz = ulaz(:,izlaz>=37.5 & izlaz<45);
K6izlaz = izlaz(izlaz>=37.5 & izlaz<45);

brojKlasa = 6;
h = histogram(izlaz, brojKlasa);

N1=length(K1izlaz);
N2=length(K2izlaz);
N3=length(K3izlaz);
N4=length(K4izlaz);
N5=length(K5izlaz);
N6=length(K6izlaz);

%% Deljenje podataka na trening i test skup
%K1
K1trening_ulaz = K1ulaz(:, 1:ceil(0.8*N1));
K1validacija_ulaz = K1ulaz(:,ceil(0.8*N1)+1:ceil(0.9*N1));
K1test_ulaz = K1ulaz(:,ceil(0.9*N1)+1:N1);

K1trening_izlaz = K1izlaz(1:ceil(0.8*N1));
K1validacija_izlaz=K1izlaz(ceil(0.8*N1)+1:ceil(0.9*N1));
K1test_izlaz=K1izlaz(ceil(0.9*N1)+1:N1);

%K2
K2trening_ulaz = K2ulaz(:, 1:ceil(0.8*N2));
K2validacija_ulaz=K2ulaz(:,ceil(0.8*N2)+1:ceil(0.9*N2));
K2test_ulaz=K2ulaz(:,ceil(0.9*N2)+1:N2);

K2trening_izlaz = K2izlaz(1:ceil(0.8*N2));
K2validacija_izlaz=K2izlaz(ceil(0.8*N2)+1:ceil(0.9*N2));
K2test_izlaz=K2izlaz(ceil(0.9*N2)+1:N2);

%K3
K3trening_ulaz = K3ulaz(:, 1:ceil(0.8*N3));
K3validacija_ulaz=K3ulaz(:,ceil(0.8*N3)+1:ceil(0.9*N3));
K3test_ulaz=K3ulaz(:,ceil(0.9*N3)+1:N3);

K3trening_izlaz = K3izlaz(1:ceil(0.8*N3));
K3validacija_izlaz=K3izlaz(ceil(0.8*N3)+1:ceil(0.9*N3));
K3test_izlaz=K3izlaz(ceil(0.9*N3)+1:N3);

%K4
K4trening_ulaz = K4ulaz(:, 1:ceil(0.8*N4));
K4validacija_ulaz=K4ulaz(:,ceil(0.8*N4)+1:ceil(0.9*N4));
K4test_ulaz=K4ulaz(:,ceil(0.9*N4)+1:N4);

K4trening_izlaz = K4izlaz(1:ceil(0.8*N4));
K4validacija_izlaz=K4izlaz(ceil(0.8*N4)+1:ceil(0.9*N4));
K4test_izlaz=K4izlaz(ceil(0.9*N4)+1:N4);

%K5
K5trening_ulaz = K5ulaz(:, 1:ceil(0.8*N5));
K5validacija_ulaz=K5ulaz(:,ceil(0.8*N5)+1:ceil(0.9*N5));
K5test_ulaz=K5ulaz(:,ceil(0.9*N5)+1:N5);

K5trening_izlaz = K5izlaz(1:ceil(0.8*N5));
K5validacija_izlaz=K5izlaz(ceil(0.8*N5)+1:ceil(0.9*N5));
K5test_izlaz=K5izlaz(ceil(0.9*N5)+1:N5);

%K6
K6trening_ulaz = K6ulaz(:, 1:ceil(0.8*N6));
K6validacija_ulaz=K6ulaz(:,ceil(0.8*N6)+1:ceil(0.9*N6));
K6test_ulaz=K6ulaz(:,ceil(0.9*N6)+1:N6);

K6trening_izlaz = K6izlaz(1:ceil(0.8*N6));
K6validacija_izlaz=K6izlaz(ceil(0.8*N6)+1:ceil(0.9*N6));
K6test_izlaz=K6izlaz(ceil(0.9*N6)+1:N6);

%grupisanje u skupove podataka za treniranje, validaciju i test
ulaz_trening=[K1trening_ulaz,K2trening_ulaz,K3trening_ulaz,K4trening_ulaz,K5trening_ulaz,K6trening_ulaz];
izlaz_trening=[K1trening_izlaz,K2trening_izlaz,K3trening_izlaz,K4trening_izlaz,K5trening_izlaz,K6trening_izlaz];

ulaz_val=[K1validacija_ulaz,K2validacija_ulaz,K3validacija_ulaz,K4validacija_ulaz,K5validacija_ulaz,K6validacija_ulaz];
izlaz_val=[K1validacija_izlaz,K2validacija_izlaz,K3validacija_izlaz,K4validacija_izlaz,K5validacija_izlaz,K6validacija_izlaz];

ulaz_test=[K1test_ulaz,K2test_ulaz,K3test_ulaz,K4test_ulaz,K5test_ulaz,K6test_ulaz];
izlaz_test=[K1test_izlaz,K2test_izlaz,K3test_izlaz,K4test_izlaz,K5test_izlaz,K6test_izlaz];

%promesamo podatke
ind_trening=randperm(length(izlaz_trening));
ulaz_trening=ulaz_trening(:,ind_trening);
izlaz_trening=izlaz_trening(ind_trening);

ind_val=randperm(length(izlaz_val));
ulaz_val=ulaz_val(:,ind_val);
izlaz_val=izlaz_val(ind_val);

ind_test=randperm(length(izlaz_test));
ulaz_test=ulaz_test(:,ind_test);
izlaz_test=izlaz_test(ind_test);

ulaz_sve=[ulaz_trening,ulaz_val];
izlaz_sve=[izlaz_trening,izlaz_val];
N=length(izlaz_sve);
Ntrening=length(izlaz_trening);
Nval=length(izlaz_val);

%% Krosvalidacija
bestMSE = inf;
for arhitektura = {[10 20 10], [4 5 10 15], [20 20 20 15 10], [30 15 20 20 20 25 30]}
    for weight = [1.1, 1.6, 2.7, 3.4]
        for tranfcn = {'tansig','logsig', 'poslin'}
            for reg = [0.1, 0.3, 0.5,0.8,0.67]
                net = fitnet(arhitektura{1});
                layers = length(arhitektura{1});
                net.trainFcn = 'trainscg';
                for i = (1 : layers)
                    net.layers{i}.transferFcn = tranfcn{1};
                end
                net.divideFcn = 'divideind';
                net.divideParam.trainInd = 1:Ntrening;
                net.divideParam.testInd = [];
                net.divideParam.valInd = Ntrening+1:Ntrening+Nval;
                net.trainParam.epochs = 1000;
                net.trainParam.goal = 1e-3;
                net.trainParam.min_grad = 1e-4;

                net.performParam.regularization = reg;

                net.trainParam.showWindow = false;
                net.trainParam.showCommandLine = true;

                w = 1.0 * ones(1, length(izlaz_sve));
                w(izlaz_sve > 7.5) = weight;
                [net, tr] = train(net, ulaz_sve, izlaz_sve, [], [], w);

                pred_val = net(ulaz_val);
                MSE=mse(net,izlaz_val,pred_val);
                disp(MSE);
                if MSE<bestMSE
                    bestMSE = MSE;
                    bestreg = reg;
                    bestarh = arhitektura{1};
                    besttranfcn = tranfcn{1};
                    bestweight = weight;
                    bestepoch=tr.best_epoch;
                end
            end
        end
    end
end

%% Ponovno obucavanje NM
disp(['Najbolja vrednost regularizacije ', num2str(bestreg)])
disp(['Najbolja aktivaciona funkcija ', num2str(besttranfcn)])
disp(['Najbolja struktura ', num2str(bestarh)])
net = fitnet(bestarh);
net.trainFcn = 'trainscg';
for i = (1 : length(bestarh))
    net.layers{i}.transferFcn = besttranfcn;
end
net.divideFcn = '';
net.performParam.regularization = bestreg;

net.trainParam.showWindow = true;
net.trainParam.showCommandLine = false;

net.trainParam.epochs = bestepoch;
net.trainParam.goal = 1e-3;
net.trainParam.min_grad = 1e-4;

w = 1.0 * ones(1, length(izlaz_test));
w(izlaz_test > 7.5) = weight;
[net,tr] = train(net,ulaz_test, izlaz_test, [], [], w);

pred_test = net(ulaz_test);
figure
plotregression(izlaz_test, pred_test)

MSE = mse(net, izlaz_test, pred_test);
disp(['Najbolji MSE ', num2str(MSE)])