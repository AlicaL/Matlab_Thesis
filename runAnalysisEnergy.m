%% importData and calculate Energy for single sensor
directory = 'data/';
d=dir([directory,'*.csv']);
numFiles=length(d);
numSensors=3;
numTasks = numFiles;
%numTasks=ceil(numFiles/numSensors);

dataAll=cell(numTasks);

for ii=1:numTasks
    data=importData1([directory,d(ii).name]);
    data.name=d(ii).name;
    %calc energy
    %data.energy=sqrt(sum(data.accel.^2,2)); 
    dataAll{ii}=data;
 end

%% average movement over time window of certain interval 
% interval=50000000; %ms
result=cell(numTasks,3);
name=cell(3,1);
sensor=cell(3,1);

for ii=1:numTasks
    clear movement
    for jj=1:numSensors
        
        d=dataAll{ii};  
        energy = d.energy(:,jj);
        
        %cut off remainder if less than 1/3 of interval
        remainder=mod(length(energy),60);
        if remainder ~= 0
             energy = energy(1:end-remainder);
        end
        
        %calculte average movement
        for i = 1:60:length(energy)
           group = energy(i:i+59);
           index = ceil((i+1)/60);
           mov(index) = mean(group); 
        end
        movement(jj,:)=mov;      
    end
    movement = movement';
    
    %% Organize results
    
    %Taks name 
    tokens = strrep(d.name,'.csv','');
    result{ii,1} = tokens;
    
    %Sensors 
    sensor{1}={'left'};
    sensor{2}={'right'};
    sensor{3}={'phone'};
    result{ii,2}=[sensor{:}];
    
    %mean Energy
    result{ii,3}=movement;
    
    %Caluculate Balance
    
    %Balance #1 Just Left Right
    m=mean(movement);
    result{ii,4}=round(m(1)/(m(1)+m(end))*100);
    
    %Balance #2 Substracting Phone movement
    m=movement-repmat(movement(:,2),1,3);
    m=m(:,[1,3]);
    m=mean(m);
    result{ii,5}=round(m(1)/(m(1)+m(end))*100);
    
    %plotting energy
    figure;plot(result{ii,3}.*100);hold on;legend(result{ii,2})
    
    %plotting balance
    result{ii,6}=round(result{ii,3}(:,1)./(result{ii,3}(:,1)+result{ii,3}(:,end))*100);

    result{ii,7}=round(result{ii,3}(:,end)./(result{ii,3}(:,1)+result{ii,3}(:,end))*100);

    
    % Writting to result varibale: 
    % Col 1 - File Name
    % Col 2 - Contains the names of the sensor columns (left, phone, right)
    % Col 3 - Actual data for (left, phone, right)
    % Col 4 - Overall balance comparing left to right (with respect to left)
    % Col 5 - Overall balance but taking into account (i.e. subtracting) the phone movement. (with respect to left)
    % Col 6 - Per second balance (with respect to left)
    % Col 7 - Per second balance (with respect to right)
    
    % MAKE SURE TO CHANGE THIS WHEN SWITCHING ARMS - USE 6 for LEFT STIFF
    % and USE 7 for RIGHT STIFF
    %figure;
    hold on;
    title('Movement over time')
    xlabel('time in min') % x-axis label
    ylabel('Percentage of Energy') % y-axis label
    plot(result{ii,6},'--');
    
    
    
end



