folder = '5min_modes/';
dd=dir([folder,'*.csv']);
delimiter = ',';

M=3;

formatSpec = '%f%f%f%f%f%f%[^\n\r]';

data = cell(length(dd)/M,M);
for ii=1:length(dd)
    filename = dd(ii).name;
    index=strsplit(filename,'_')
    kk=str2double(index{1});
    ll=str2double(index{2});
    
    fileID = fopen([folder,filename],'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines', 1, 'ReturnOnError', false);
    
    
    data{kk,ll}.index = dataArray{:, 1};
    data{kk,ll}.session = dataArray{:, 2};
    data{kk,ll}.leftEnergy = dataArray{:, 3};
    data{kk,ll}.rightEnergy = dataArray{:, 4};
    data{kk,ll}.phoneEnergy = dataArray{:, 5};
    data{kk,ll}.time = dataArray{:, 6};
    
    fclose(fileID);
    save data.mat data
end

