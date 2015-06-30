% load fisheriris
% s1 = meas(51:100,3);
% s2 = meas(101:150,3);
% figure;
% boxplot([s1 s2],'notch','on', 'labels',{'versicolor','virginica'})

rng default;  % For reproducibility
x1 = log3.sensor_leftEnergy;
x1 = x1(1:901)
x2 = log3.kinect_energyLeftWrist;
%x2 = x2(1:300)

x3 = log3.sensor_rightEnergy;
x3 = x3(301:600)
x4 = log3.kinect_energyRightWrist;
x4 = x4(301:600)

figure;

%boxplot([x1,x2,x3,x4],'labels',{'sensor left','kinect left','sensor right','kinect right'})

plot(1:901,x1,1:901,x2)