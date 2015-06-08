function log_structure = readLog(sensor_log_location,kinect_log_location,add_hours_to_sensor)
    
    %% load structure
%     sensor_log_location = 'data/validation_kinect/logs_1_sensor_general_both.csv';
%     kinect_log_location = 'data/validation_kinect/logs_1_kinect_general_both.txt';
%     add_hours_to_sensor = 1;

    addpath('time_helpers');
    %import sensor data
    log_structure = {};

    log = importdata(sensor_log_location);
    log_structure.sensor_leftEnergy = log.data(:,3);
    log_structure.sensor_rightEnergy = log.data(:,4);
    log_structure.sensor_phoneEnergy = log.data(:,5);

    parse_sensor_time = log.data(:,6);
    readable_sensor_time = arrayfun(@convert_utime,parse_sensor_time, 'UniformOutput', false);
    readable_sensor_time_update = {};
    for i = 1:size(readable_sensor_time,1)
        readable_sensor_time_update{i,1} = datestr(addtodate(datenum(readable_sensor_time(i)), add_hours_to_sensor, 'hour'));
    end
    [log_structure.readable_sensor_time,parse_sensor_time] = cellfun(@make_time,readable_sensor_time_update, 'UniformOutput', false);
    log_structure.sensor_time = cell2mat(parse_sensor_time);
    
    %import kinect data
    kinect_log = importdata(kinect_log_location);

    % parse kinect time
    kinect_time = kinect_log.textdata(:,2);
    kinect_time = kinect_time(2:end);
    [readable_kinect_time,parsed_kinect_time] = cellfun(@convert_time_string,kinect_time, 'UniformOutput', false);
    kinect_time = cell2mat(parsed_kinect_time);
    
    %kinect_midSpine = kinect_log.data(:,1:3);
    %kinect_leftWrist = kinect_log.data(:,4:6);
    %kinect_rightWrist = kinect_log.data(:,7:9);

    kinect_midSpine(:,1) = diff(kinect_log.data(:,1),2);
    kinect_midSpine(:,2) = diff(kinect_log.data(:,2),2);
    kinect_midSpine(:,3) = diff(kinect_log.data(:,3),2);
    kinect_leftWrist(:,1) = diff(kinect_log.data(:,4),2);
    kinect_leftWrist(:,2) = diff(kinect_log.data(:,5),2);
    kinect_leftWrist(:,3) = diff(kinect_log.data(:,6),2);
    kinect_rightWrist(:,1) = diff(kinect_log.data(:,7),2);
    kinect_rightWrist(:,2) = diff(kinect_log.data(:,8),2);
    kinect_rightWrist(:,3) = diff(kinect_log.data(:,9),2);    
    
    %calculate kinect energy
    kinect_energyLeftWrist = sqrt(kinect_leftWrist(:,1).^2+kinect_leftWrist(:,2).^2+kinect_leftWrist(:,3).^2);
    kinect_energyRightWrist = sqrt(kinect_rightWrist(:,1).^2+kinect_rightWrist(:,2).^2+kinect_rightWrist(:,3).^2);
    kinect_energyMidSpine = sqrt(kinect_midSpine(:,1).^2+kinect_midSpine(:,2).^2+kinect_midSpine(:,3).^2);

    % average the columns
    duplicate_array =  kinect_time;
    [kinect_time,position_of_unique,unique_indexes] = unique(duplicate_array,'stable');
    
    number_of_seconds = size(unique_indexes,1);
    number_of_seconds = number_of_seconds - 2;
    
    log_structure.kinect_energyLeftWrist = accumarray(unique_indexes(1:number_of_seconds),kinect_energyLeftWrist,[],@mean);
    log_structure.kinect_energyRightWrist = accumarray(unique_indexes(1:number_of_seconds),kinect_energyRightWrist,[],@mean);
    log_structure.kinect_energyMidSpine = accumarray(unique_indexes(1:number_of_seconds),kinect_energyMidSpine,[],@mean);
 
    log_structure.readable_kinect_time = readable_kinect_time(position_of_unique);
    
    % assigment
    log_structure.kinect_time = kinect_time;