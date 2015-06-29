folder = '../';
dd=dir([folder,'*.csv']);
delimiter = ',';

M=1;

formatSpec = '%f%f%f%f%f%f%[^\n\r]';

data = cell(length(dd)/M,M);
for ii=1:length(dd)
    filename = dd(ii).name;
    index=strsplit(filename,'_');
    kk=str2double(index{1});
    
    fileID = fopen([folder,filename],'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines', 1, 'ReturnOnError', false);
    
    
    data{kk}.index = dataArray{:, 1};
    data{kk}.session = dataArray{:, 2};
    data{kk}.leftEnergy = dataArray{:, 3};
    data{kk}.rightEnergy = dataArray{:, 4};
    data{kk}.phoneEnergy = dataArray{:, 5};
    data{kk}.time = dataArray{:, 6};
    
    fclose(fileID);
    save data.mat data
end

ii=1;
left=data{ii}.leftEnergy;
right=data{ii}.rightEnergy;
phone=data{ii}.phoneEnergy;
time=data{ii}.time;

timeIndex=(time>=1434707900) & (time <1434711499);

left=left(timeIndex);
phone=phone(timeIndex);

n=10;
m=floor(length(left)/n);

left=mean(reshape(left(1:m*n),m,n));
phone=mean(reshape(phone(1:m*n),m,n));

indexPos= (left>0)&(phone>0);
left=left(indexPos);
phone=phone(indexPos);

energy=left-phone;
energy(energy<0)=0;
mean(energy)

