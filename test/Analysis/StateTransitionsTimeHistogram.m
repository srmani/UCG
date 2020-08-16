function [FromState,ToState,StartFolder,EndFolder,Name] = StateTransitionsTimeHistogram(FromState,ToState,StartFolder,EndFolder,Name)

ForwardData=0;
BackwardData=0;

for fol=StartFolder:EndFolder
    
    cd(num2str(fol));
    pwd;
    ForwardFile=strcat('delTime','.',Name,num2str(FromState),num2str(ToState),'.','dat');
    Data=importdata(ForwardFile);
    Data=Data';
    ForwardData=[ForwardData Data];
    clear Data
    
    %BackwardFile=strcat('delTime','.',Name,num2str(ToState),num2str(FromState),'.','dat');
    %Data=importdata(BackwardFile);
    %Data=Data';
    %BackwardData=[BackwardData Data];
    %clear Data;
    
    cd ../
end

ForwardData=ForwardData(2:end)';
%BackwardData=BackwardData(2:end)';

ForwardOutput=strcat('Hist','_',Name,num2str(FromState),num2str(ToState),'.','dat');
%BackwardOutput=strcat('Hist','_',Name,num2str(ToState),num2str(FromState),'.','dat');
ForwardFig=strcat('Hist','_',Name,num2str(FromState),num2str(ToState));
%BackwardFig=strcat('Hist','_',Name,num2str(ToState),num2str(FromState));

Fig1=figure;
ForwardHist=histogram(ForwardData,'normalization','probability');
print(Fig1,ForwardFig,'-dpng')

%Fig2=figure;
%BackwardHist=histogram(BackwardData,'normalization','probability');
%print(Fig2,BackwardFig,'-dpng')

ForwardBin=ForwardHist.BinEdges(1:end-1)';
ForwardVal=ForwardHist.Values';

%BackwardBin=BackwardHist.BinEdges(1:end-1)';
%BackwardVal=BackwardHist.Values';

dlmwrite(ForwardOutput,[ForwardBin ForwardVal],'delimiter',' ','precision','%10.10f');
%dlmwrite(BackwardOutput,[BackwardBin BackwardVal],'delimiter',' ','precision','%10.10f');


end
