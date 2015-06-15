log_location = 'DAL/inactive_20150614.csv';
log = importdata(log_location);

index = log.data(:,1);
left_energy = log.data(:,3);
right_energy = log.data(:,4);
phone_energy = log.data(:,5);

left_energy(left_energy<0) = 0;
right_energy(right_energy<0) = 0;
phone_energy(phone_energy<0) = 0;

means = [nanmean(left_energy(1:3710))];
means_indexes = [1];

x = means_indexes;
y = means;

scatter(x,y, 100,'magenta','diamond','MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1.5);          
%lsline

title('Get Thresholds for Different Use Modes')
xlabel('Mode') % x-axis label
ylabel('Average Left Energy') % y-axis label

mu = mean(y);
%refline([0 mu])
axis([0 4 0 0.01])

p = polyfit(x,y,1) 
refline([p(1) p(2)])

legend({'Data points',sprintf('y = %.2fx + %.2f',p(1),p(2))},'FontSize',16,'FontWeight','bold', 'Location','northwest')

ax = gca;
set(ax,'XTick',[1 2 3])