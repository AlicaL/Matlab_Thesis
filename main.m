% clear workspace
clear all;
clc;

% load log data structures
%log1 = readLog('data/validation_kinect/logs_1_sensor_general_both.csv','data/validation_kinect/logs_1_kinect_general_both.txt',1);
%log2 = readLog('data/validation_kinect/logs_2_sensor_general_both.csv','data/validation_kinect/logs_2_kinect_general_both.txt',2);
log3 = readLog('data/validation_kinect/logs_3_sensor_general_both.csv','data/validation_kinect/logs_3_kinect_general_both.txt',2);
%log1 = clip_log(log1, 2, 66, 2, 9);
%log2 = clip_log(log2, 2, 66, 2, 9);

% calculate balances

%% plot
%plot(log1.sensor_time,log1.sensor_leftEnergy,log1.kinect_time,log1.kinect_energyLeftWrist)
plot(log3.sensor_time,log3.sensor_leftEnergy,log3.kinect_time,log3.kinect_energyLeftWrist)
title('Sensor Kinect Validation');
ylabel('Acceleration');
xlabel('Time');
legend('sensor acceleration','kinect acceleration')

%hold on;
%plot(log3.sensor_time,log3.sensor_rightEnergy,log3.kinect_time,log3.kinect_energyRightWrist)
%plot(log2.sensor_time,log2.sensor_leftEnergy,log2.kinect_time,log2.kinect_energyLeftWrist)