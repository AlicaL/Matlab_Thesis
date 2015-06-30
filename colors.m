% Starting with X of size N-by-P-by-2, where P is number of plots
mpdc10 = distinguishable_colors(10) % 10x3 color list
hold on
for ii=1:size(X,2),
    plot(X(:,ii,1),X(:,ii,2),'.','Color',mpdc10(ii,:));
end