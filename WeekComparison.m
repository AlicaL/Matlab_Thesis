% Comparar cada dia
clear all

directory = 'Subject_1/Data/';
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
        energy(energy==-1)=NaN;
        mov = nanmean(energy);
        movement(:,jj) = mov';
        result{ii,jj+1} = movement; 
    end      
end

%% Only left hand
for i = 1:numTasks
    meanday(i) = (result{i,2});
end

% Difference percentage
for i = 2:length(meanday)
    perc2(i-1) = result{1,2}./result{i,2}*100;
end
perc2 = 100-perc2;
perc2 = round(perc2);
p1 = strcat(num2str(perc2(1)),'%');
p2 = strcat(num2str(perc2(2)),'%');
p3 = strcat(num2str(perc2(3)),'%');
p4 = strcat(num2str(perc2(4)),'%');

% plot
bar(meanday);
title('Subject 1 - Experimental Week');
ylabel('activity paretic limb');
xlabel('Days');
hline = refline([0 meanday(1)]);
hline.Color = 'r';

x = 1:5;
% for i=1:length(x),
%   TH(i) = text(x(i)-0.25,meanday(i)+ 0.15,num2str(meanday(i))) ;
% end

TH(2) = text(x(2)-0.25,meanday(2)+ 0.15,p1) ;
TH(3) = text(x(3)-0.25,meanday(3)+ 0.15,p2) ;
TH(4) = text(x(4)-0.25,meanday(4)+ 0.15,p3) ;
TH(5) = text(x(5)-0.25,meanday(5)+ 0.15,p4) ;


% % % % % % % Alica trial to change x axis
set(gca,'XTickLabel',{'Baseline','Int1','Int2','Int3','Post-test'} );
% gtext place the text with mouse in the figure
% comentar si no percentage en el plot
% gtext(p1,'Fontsize',16)
% gtext(p2,'Fontsize',16)
% gtext(p3,'Fontsize',16)
% % descomentar la siguiente linia cuando tengas los 5 dias
% gtext(p4,'Fontsize',16)

%% Left and right hand
for i = 1:numTasks
    meanday1(i,:) = (result{i,3});
end

%Balance #1 Just Left Right - Phone movement substracted
% Left 
for i = 1:length(meanday1)
    balance{i}=round(meanday1(i,1)/(meanday1(i,1)+meanday1(i,end))*100);
end
b1 = strcat(num2str(balance{1}),'%');
b2 = strcat(num2str(balance{2}),'%');
b3 = strcat(num2str(balance{3}),'%');
b4 = strcat(num2str(balance{4}),'%');
b5 = strcat(num2str(balance{5}),'%');

% Right
b12 = strcat(num2str(100-balance{1}),'%');
b22 = strcat(num2str(100-balance{2}),'%');
b32 = strcat(num2str(100-balance{3}),'%');
b42 = strcat(num2str(100-balance{4}),'%');
b52 = strcat(num2str(100-balance{5}),'%');

for i = 1:numTasks
    plot_balance(i,:) = [balance{i} 100-balance{i}];
end

% plot
figure;
bar(plot_balance,1);
ylim([0 100])
title('Subject 1 - Experimental Week');
ylabel('Percent of Arm usage');
xlabel('Days');
legend('paretic left','healthy right')
set(gca,'XTickLabel',{'Baseline','Int1','Int2','Int3','Post-test'} );


TH(1) = text(x(1)-0.25,20,b1) ;
TH(2) = text(x(2)-0.25,20,b2) ;
TH(3) = text(x(3)-0.25,20,b3) ;
TH(4) = text(x(4)-0.25,20,b4) ;
TH(5) = text(x(5)-0.25,20,b5) ;

TH(6) = text(x(1)+0.05,20,b12) ;
TH(7) = text(x(2)+0.05,20,b22) ;
TH(8) = text(x(3)+0.05,20,b32) ;
TH(9) = text(x(4)+0.05,20,b42) ;
TH(10) = text(x(5)+0.05,20,b52) ;

set(TH,'Color','g') ;

hline = refline([0 50]);
hline.Color = 'r';

% gtext place the text with mouse in the figure
% gtext(b1,'Fontsize',11)
% gtext(b12,'Fontsize',11)
% gtext(b2,'Fontsize',11)
% gtext(b22,'Fontsize',11)
% gtext(b3,'Fontsize',11)
% gtext(b32,'Fontsize',11)
% gtext(b4,'Fontsize',11)
% gtext(b42,'Fontsize',11)
% gtext(b5,'Fontsize',11)
% gtext(b52,'Fontsize',11)