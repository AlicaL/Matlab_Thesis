% Comparar cada dia
clear all

directory = 'Subject_2/Corrected_Data/';
d=dir([directory,'*.csv']);
numFiles=length(d);

numTasks = numFiles;
dataAll=cell(numTasks);
numSensors = 3;
for ii=1:numTasks
    data=importData1([directory,d(ii).name]);
    data.name=d(ii).name;
    dataAll{ii}=data;
end

result = cell(numTasks,1);

for ii=1:numTasks
    clear movement
    d=dataAll{ii};
    name = d.name;
    tokens = strsplit(name,'.');
    name = tokens(1);
    result{ii,1} = name;
    for jj=1:(numSensors-1)
        clear mov
        energy = d.energy(:,jj);
        energy = energy-d.energy(:,3);
        energy(energy<0)= 0;
        mov = nanmean(energy);
        movement(:,jj) = mov';
        result{ii,jj+1} = movement; 
    end      
end

%% Only left hand
for i = 1:numTasks
    meanday(i) = (result{i,2});
end
% plot
bar(meanday);
title('Subject 2- Experimental Week');
ylabel('activity paretic limb');
xlabel('Days');
hline = refline([0 1.88]);
hline.Color = 'r';
% % % % % % % Alica trial to change x axis
indexes = ['Base Int1 Int2 Int3'];
x = [indexes];
%% Left and right hand
for i = 1:numTasks
    meanday1(i,:) = (result{i,3});
end
% plot
figure;
bar(meanday1);
title('Subject 2 - Experimental Week');
ylabel('Activity values');
xlabel('Days');
legend('paretic left','right')

