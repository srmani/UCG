if [ "$#" -ne 3 ] ; then echo "Usage $0 FOLDERSTART FOLDEREND FILENAME"; exit 1; fi
Start=$1
End=$2
File=$3

#----------------------

cd ../ #Exiting the analysis folder

Loc=`pwd`
module load matlab

for i in `seq $Start 1 $End`
do
    cd $i
    rm $File.dat
    grep -E 'U m' cg.out$i | awk '{if($8=="s") {print $3" "$5" "$7" "$10" "$12" "$14}}' >> $File.dat
    matlab -nodisplay -nosplash -nodesktop -r "addpath('/project2/gavoth/sriramvigneshm/NSF-SSE/Dichloroethane-UCG2Paper/DCE_UCG_Share/NewUCGFix/Analysis/');IndividualStatesTimeProfile('initialstate.in','$File');exit;"
    cd ../
done
