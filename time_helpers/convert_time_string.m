function [formated_time,utime] = convert_time_string(date_string)
    % problem here is converitng the date from kinect which is a string
    % to separete number values
    % string_to_convert = '24-4-2015_12.34.47.420';
    string_to_convert = date_string;

    %first we split the string by _ then we split the first part by - and the
    %second part by .
    string_split = strsplit(string_to_convert,'_');
    class(string_to_convert); % this is just to check which type the string cell is
    date = strsplit(char(string_split(1)),'-');
    time = strsplit(char(string_split(2)),'.');

    % we actually do the conversion of clean "number" char(strings)
    % to actual numbers
    day = str2num(char(date(1)));
    month = str2num(char(date(2)));
    year = str2num(char(date(3)));

    hour = str2num(char(time(1)));
    minute = str2num(char(time(2)));
    seconds = str2num(char(time(3)));
    millisecond = str2num(char(time(4)));

    % make a date vector
    DateVector = [year,month,day,hour,minute,seconds];
    date_time = datestr(DateVector);

    % make unix time and formated time
    utime = 86400 * (datenum(date_time) - datenum('01-Jan-1970'));
    formated_time = datestr(utime/86400 + datenum(1970,1,1));