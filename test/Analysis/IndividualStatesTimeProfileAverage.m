function [StartFolder,EndFolder] = IndividualStatesTimeProfileAverage(StartFolder,EndFolder)

format long g;

count=1;
MaxTime=-100;
CurrentMaxTime=0;

for fol=StartFolder:EndFolder
    cd(num2str(fol));
    Data=importdata('IndividualStatesTimeProfile.dat');
    if count == 1
        GroupData={Data};
        CurrentMaxTime=max(GroupData{count,1}(:,1));
        if CurrentMaxTime > MaxTime
            MaxTime=CurrentMaxTime;
        end
    else
        GroupData=[GroupData;Data];
        CurrentMaxTime=max(GroupData{count,1}(:,1));
        if CurrentMaxTime > MaxTime
            MaxTime=CurrentMaxTime;
        end       
    end
    count=count+1;
    clear Data
    cd ../
end

FracMaxTime=ceil(MaxTime/1000);
MaxTime=FracMaxTime*1000;

TimeEdges=0:1000:MaxTime;
TimeEdges=TimeEdges';
lenTime=length(TimeEdges);
Avgs=zeros(lenTime,2);
struccount=zeros(lenTime,1);

for i=1:length(GroupData)
    for j=1:length(GroupData{i,1}(:,1))
        
        cstep=GroupData{i,1}(j,1);
        cstepbin=floor(cstep/1000)+1;
        
        if j==length(GroupData{i,1}(:,1))
            nstep=MaxTime;
        else
            nstep=GroupData{i,1}(j+1,1);
        end
        
        nstepbin=floor(nstep/1000)+1;
        
        if nstepbin==cstepbin
            nstepbin=nstepbin+1;
        end
        
        for k=cstepbin:nstepbin-1   
            Avgs(k,:)=Avgs(k,:)+GroupData{i,1}(j,2:3);
            struccount(k,1)=struccount(k,1)+1;
        end
    end
end

Avgs=Avgs./struccount;
%TotalFilamentLength=sum(Avgs,2)-Avgs(:,1);
Avgs=Avgs(1:end-1,:);
%TotalFilamentLength=TotalFilamentLength(1:end-1,:);
TimeEdges=TimeEdges(1:end-1,:);

Fig1=figure(1);
plot(TimeEdges,Avgs(:,1),'or');
hold on
plot(TimeEdges,Avgs(:,2),'*b');
hold on
legend('State 0','State 1');
print(Fig1,'IndividualStatesTimeProfile','-dpng')

disp('Finished generating the filament state matrix')

dlmwrite('IndividualStatesTimeProfile.dat',[TimeEdges Avgs],'delimiter',' ','precision','%10.10f');

