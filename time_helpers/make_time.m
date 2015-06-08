function [formated_time,utime] = make_time(date_time)
    % make unix time and formated time
    utime = 86400 * (datenum(date_time) - datenum('01-Jan-1970'));
    formated_time = datestr(utime/86400 + datenum(1970,1,1));