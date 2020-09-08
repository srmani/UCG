#include <iostream>
#include <vector>
#include <algorithm>
#include <string.h>
#include <fstream>
#include <string> 
#include <cmath> 

using namespace std;

int main()
{
	int nspecies=2;
	int nstates[2]={3,2};
	int atomtype_offset[2]={2,1};
	int bondtype_offset[2]={1,2};
	
	try
	{	
		int ntypes_expected=0,nbondtypes_expected=0;
		for(int i=0;i<nspecies;i++)
		{
			ntypes_expected=ntypes_expected+nstates[i]*atomtype_offset[i];
			nbondtypes_expected=nbondtypes_expected+nstates[i]*bondtype_offset[i];
		}
		if(ntypes_expected!=8 || nbondtypes_expected!=7)
			throw (0);
	}
	
	catch(...)
	{
		return 1;
	}
	
	return 0;
}