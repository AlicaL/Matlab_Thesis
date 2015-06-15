% figure
% ax1 = subplot(1,1,1);
% %ax2 = subplot(2,1,2);
% 

x =  [ 1 1 1 2 2 2 3 3 3]
y = [3 4 5 6 5 7 7 8 10]

scatter(x,y, 100,'magenta','diamond','MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1.5);          
%lsline

title('Get Thresholds for Different Use Modes')
xlabel('Mode') % x-axis label
ylabel('Average Balance/Energy') % y-axis label


mu = mean(y);
%refline([0 mu])
axis([0 4 0 20])

p = polyfit(x,y,1) 
refline([p(1) p(2)])

legend({'Data points',sprintf('y = %.2fx + %.2f',p(1),p(2))},'FontSize',16,'FontWeight','bold')

ax = gca;
set(ax,'XTick',[1 2 3])
