if [ "$#" -ne 5 ] ; then echo "Usage $0 FOLDERSTART FOLDEREND FROMSTATE TOSTATE FILENAME"; exit 1; fi
Start=$1
End=$2
FromState=$3
ToState=$4
File=$5
#----------------------

cd ../ #Exiting the analysis folder

Loc=`pwd`
module load matlab

for i in `seq $Start 1 $End`
do
    cd $i
    rm $File$FromState$ToState.dat    
    grep -E 'U m' cg.out$i | awk '{if($8=="s") {print $3" "$5" "$7" "$10" "$12" "$14}}' >> $File$FromState$ToState.dat
    NMol=`wc -l initialstate.in | cut -d' ' -f1`
    matlab -nodisplay -nosplash -nodesktop -r "addpath('/project2/gavoth/sriramvigneshm/NSF-SSE/Dichloroethane-UCG2Paper/DCE_UCG_Share/NewUCGFix/Analysis');StateTransitionsTime($FromState,$ToState,$NMol,'$File');exit;"
    cd ../
done

matlab -nodisplay -nosplash -nodesktop -r "addpath('/project2/gavoth/sriramvigneshm/NSF-SSE/Dichloroethane-UCG2Paper/DCE_UCG_Share/NewUCGFix/Analysis');StateTransitionsTimeHistogram($FromState,$ToState,$Start,$End,'$File');exit;"
