function [ log_output ] = clip_log( log_to_clip, clip_sensor_start, clip_sensor_end, clip_kinect_start, clip_kinect_end)
%CLIP_LOG Summary of this function goes here
%   Detailed explanation goes here
log_output.sensor_leftEnergy = log_to_clip.sensor_leftEnergy(clip_sensor_start:clip_sensor_end);
log_output.sensor_rightEnergy = log_to_clip.sensor_rightEnergy(clip_sensor_start:clip_sensor_end);
log_output.sensor_phoneEnergy = log_to_clip.sensor_phoneEnergy(clip_sensor_start:clip_sensor_end);
log_output.readable_sensor_time = log_to_clip.readable_sensor_time(clip_sensor_start:clip_sensor_end);
log_output.sensor_time = log_to_clip.sensor_time(clip_sensor_start:clip_sensor_end);

log_output.kinect_energyLeftWrist = log_to_clip.kinect_energyLeftWrist(clip_kinect_start:clip_kinect_end);
log_output.kinect_energyRightWrist = log_to_clip.kinect_energyRightWrist(clip_kinect_start:clip_kinect_end); 
log_output.kinect_energyMidSpine = log_to_clip.kinect_energyMidSpine(clip_kinect_start:clip_kinect_end);
log_output.readable_kinect_time = log_to_clip.readable_kinect_time(clip_kinect_start:clip_kinect_end);
log_output.kinect_time = log_to_clip.kinect_time(clip_kinect_start:clip_kinect_end);

end

