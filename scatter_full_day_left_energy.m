log_location = 'DAL/Modes/morning_20150613.csv';
log = importdata(log_location);

index = log.data(:,1);
left_energy = log.data(:,3);
right_energy = log.data(:,4);
phone_energy = log.data(:,5);

left_energy=left_energy- phone_energy;
right_energy= right_energy- phone_energy;

left_energy(left_energy<0) = 0;
right_energy(right_energy<0) = 0;
phone_energy(phone_energy<0) = 0;

means = [mean(left_energy(1:3569)) mean(left_energy(3570:7163)) mean(left_energy(7164:10748))];
means_indexes = [1 2 3];

x = means_indexes;
y = means;

log_location = 'DAL/Modes/afternoon_20150613.csv';
log = importdata(log_location);

index = log.data(:,1);
left_energy = log.data(:,3);
right_energy = log.data(:,4);
phone_energy = log.data(:,5);


left_energy=left_energy- phone_energy;
right_energy= right_energy- phone_energy;

left_energy(left_energy<0) = 0;
right_energy(right_energy<0) = 0;
phone_energy(phone_energy<0) = 0;

means = [mean(left_energy(1:3566)) mean(left_energy(3567:7150)) mean(left_energy(7151:10734))];
means_indexes = [1 2 3];

x = [x means_indexes];
y = [y means];

log_location = 'DAL/Modes/night_20150613.csv';
log = importdata(log_location);

index = log.data(:,1);
left_energy = log.data(:,3);
right_energy = log.data(:,4);
phone_energy = log.data(:,5);


left_energy=left_energy- phone_energy;
right_energy= right_energy- phone_energy;

left_energy(left_energy<0) = 0;
right_energy(right_energy<0) = 0;
phone_energy(phone_energy<0) = 0;

means = [mean(left_energy(1:3556)) mean(left_energy(3557:7142)) mean(left_energy(7143:10791))];
means_indexes = [1 2 3];

x = [x means_indexes];
y = [y means];

scatter(x,y, 100,'magenta','diamond','MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1.5);          
%lsline

title('Get Thresholds for Different Use Modes')
xlabel('Mode') % x-axis label
ylabel('Average Left Energy') % y-axis label

mu = mean(y);
%refline([0 mu])
axis([0 4 0 0.02])

p = polyfit(x,y,1) 
refline([p(1) p(2)])

legend({'Data points',sprintf('y = %.5fx + %.5f',p(1),p(2))},'FontSize',16,'FontWeight','bold', 'Location','northwest')

ax = gca;
set(ax,'XTick',[1 2 3])

%Thresholds
refline([0 0.0038])
refline([0 0.01])
refline([0 0.018])