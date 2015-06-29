% June VS training Day

clear all

d1= 5;
d2= 1;

directory = 'data/Pilot-data/';
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

result = cell(numTasks,3);

for ii=1:numTasks
    clear movement
    clear mov
    d=dataAll{ii};
    name = d.name;
    tokens = strsplit(name,'.');
    name = tokens(1);
    result{ii,1} = name;
    for jj=1:(numSensors-1) 
        energy = d.energy(:,jj);
        energy = energy-d.energy(:,3);
        energy(energy<0)= NaN;
        %cut off remainder if less than 1/3 of interval
        remainder=mod(length(energy),3600);
        if remainder ~= 0
            tail = energy(remainder:end);
            energy = energy(1:end-remainder);
        end
        %calculte average movement
        for i = 1:3600:length(energy)
           group = energy(i:i+3599);
           index = ceil((i+1)/3600);
           mov(index) = nanmean(group); 
        end
        if remainder ~= 0 && jj == 1
            mov = [mov nanmean(tail)];
        end
        movement(:,jj) = mov';
        result{ii,jj+1} = movement; 
    end      
end

% preparar la legend
days(1,1) =  result{d1,1}; 
days(1,2) = result{d2,1};

% hold on plots
figure;
width1 = 0.8;
% depende del plot que quieres: cambiar result{?????,2}
% mirar en la estructura result{} el fichero que quiero
% hacer plot a que fila corresponde
% en este caso, fila 3 corresponde al 9June_Base, y por eso result{3,2}
% la fila 1 corresponde al fichero modes, por eso result{1,2}
bar(result{d1,2},width1,'FaceColor',[0.2,0.2,0.5]);
hold on
width2 = width1/2;
bar(result{d2,2},width2,'FaceColor',[0,0.7,0.7],'EdgeColor',[0,0.7,0.7])
hold off
legend(days(:,:)) % add legend
xlabel('Time in Hours');
ylabel('Energy - Phone');
title('Left-Hand');
hline = refline([0 0.0038]);
hline.Color = 'r';
%refline([0 0.01])

% Innactive percentatge
figure;
modes = result{d2,2};
threshold = 0.0038;
innactive = modes(modes < threshold);
innactive_perc = (length(innactive)*100)/length(modes);
% perc1 vector containing active percentage & innactive percentage
perc1 = [100-innactive_perc innactive_perc];
pie(perc1);
legend('Active','Innactive');

% Difference percentage
modes = result{d2,2};
June = result{d1,2};
diff = June - modes;
perc2 = (modes./June)*100;
perc2 = 100-perc2;



% plot difference
figure;
holdon = [June'; modes']';
bar(holdon)
title('Hour comparison')
xlabel('Time in hours')
ylabel('Energy-phone')
legend('Baseline Day', 'Modes')
