% data = load('data.mat')
importData
[N,M]=size(data);
L=2; %number of measures
out=zeros(N,M,L);
measures=cell(L,1);

for ii=1:N
    for jj =1:M
        ll=1;
        left=data{ii,jj}.leftEnergy;
        right=data{ii,jj}.rightEnergy;
        phone=data{ii,jj}.phoneEnergy;
        
        %Balance
        measures{ll}='balance';
        out(ii,jj,ll)=mean(left./(left+right))*100;
        ll=ll+1;
        
        %Extremities Energy - Phone
        measures{ll}='energy-phone';
        out(ii,jj,ll)=mean((left-phone)+(right-phone));
        ll=ll+1;
        
        
    end
end


for ll=1:L
    figure
    plot(out(:,:,ll)','.')
    title(measures{ll})
    xlim([0,4]);
end


