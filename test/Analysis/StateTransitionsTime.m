function [FromState,ToState,TotalMols,InputFile] = StateTransitionsTime(FromState,ToState,TotalMols,InputFile)

% note: the UCG transitions file for this script should include all the
% transitions in the system and only not the FromState -> ToState ones.This
% is to identify the correct the reference time for FS -> TS UCG event
% The delt calculated for reverse reaction will be wrong in some cases as the time reference is not updated properly for them

  format long g;

molref=zeros(TotalMols,1);  % molecule time reference-stores the last timestep when a given molecule underwent UCG event
%--------------------------------

InputFileName=strcat(InputFile,num2str(FromState),num2str(ToState),'.','dat');
Data=importdata(InputFileName);
DataSize=size(Data);
nucgevents=DataSize(1);
ncols=DataSize(2);

% Format of UCGTransitions.dat file
%====================================
%molID, FromState, ToState, TimeStep, delU, Beta
% 1       2          3          4       5   6
%====================================

ForwardRxn=0;
BackwardRxn=0;

for nucg=1:nucgevents
   
    %-----------
    
    % tracks the correct reference time for each molecule for hydrolysis

    if  Data(nucg,3)==FromState
        molref(Data(nucg,1))=Data(nucg,4);
    end
    
    if  Data(nucg,2)==FromState && Data(nucg,3)==ToState
        delt=Data(nucg,4)-molref(Data(nucg,1));
        molref(Data(nucg,1))=Data(nucg,4);
        ForwardRxn=[ForwardRxn delt];
    end
    
    if  Data(nucg,2)==ToState && Data(nucg,3)==FromState
        delt=Data(nucg,4)-molref(Data(nucg,1));
        molref(Data(nucg,1))=Data(nucg,4);
        BackwardRxn=[BackwardRxn delt];
    end    
end

ForwardRxn=ForwardRxn(2:end)';
BackwardRxn=BackwardRxn(2:end)';

ForwardOutputFile=strcat('delTime','.',InputFile,num2str(FromState),num2str(ToState),'.','dat');
%BackwardOutputFile=strcat('delTime','.',InputFile,num2str(ToState),num2str(FromState),'.','dat');
dlmwrite(ForwardOutputFile,ForwardRxn,'delimiter',' ','precision','%10.0f');
%dlmwrite(BackwardOutputFile,BackwardRxn,'delimiter',' ','precision','%10.0f');

end
