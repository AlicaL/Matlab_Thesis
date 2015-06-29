% load fisheriris
% s1 = meas(51:100,3);
% s2 = meas(101:150,3);
% figure;
% boxplot([s1 s2],'notch','on', 'labels',{'versicolor','virginica'})

rng default;  % For reproducibility
x1 = normrnd(5,1,100,1);
x2 = normrnd(6,1,100,1);
figure;
boxplot([x1,x2],'notch','on','labels',{'mu = 5','mu = 6'})