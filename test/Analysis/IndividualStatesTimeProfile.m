function [InitialStateFile,UCGFile] = IndividualStatesTimeProfileTest(InitialStateFile,UCGFile)

% wont work for systems with multiple filaments
%-----------------------------------------------

istate=importdata(InitialStateFile);
istatesize=size(istate);
nmols=istatesize(1);

%Format for UCG Transitions file
%====================================
%molID, FromState, ToState, TimeStep, delU, Beta
% 1         2           3       4       5     6     
%====================================

UCGFileName=strcat(UCGFile,'.','dat');
ucgdata=importdata(UCGFileName);
ucgsize=size(ucgdata);
nucgevents=ucgsize(1);

% state IDs:: only two states 0 and 1
%-----------------------------------------

icount=zeros(1,2);
icount(1,1)=length(find(istate==0));
icount(1,2)=length(find(istate==1));

consolidatedcount=zeros(ucgsize(1)+1,2);
time=zeros(ucgsize(1)+1,1);
consolidatedcount(1,:)=icount;
time(1)=0;
time(2:end)=ucgdata(:,4);

% Preparing the filament state time matrix
%-------------------------------------------

for nucg=1:nucgevents
    
    FromState=ucgdata(nucg,2)+1;
    ToState=ucgdata(nucg,3)+1;
    consolidatedcount(nucg+1,FromState)=consolidatedcount(nucg,FromState)-1;
    consolidatedcount(nucg+1,ToState)=consolidatedcount(nucg,ToState)+1;
    
%     icount(1,FromState)=icount(1,FromState)-1;
%     icount(1,ToState)=icount(1,ToState)+1;
%     consolidatedcount=[consolidatedcount;icount];
%     time=[time;TimeStep];
end

%disp('Finished generating the filament state matrix')

dlmwrite('IndividualStatesTimeProfile.dat',[time consolidatedcount],'delimiter',' ');

