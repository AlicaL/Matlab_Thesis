%Some data
%x = 1:5 ;
y = rand(size(x)) ;
% The plot
bar(y) ;
% add the values
for i=1:length(x),
  TH(i) = text(x(i),y(i),num2str(y(i))) ;
end
% Use the handles TH to modify some properties
set(TH,'Horizontalalignment','center',...
'verticalalignment','bottom') ;