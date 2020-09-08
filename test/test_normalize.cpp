#include <iostream>
#include <vector>
#include <algorithm>
#include <string.h>
#include <fstream>
#include <string> 
#include <cmath> 

using namespace std;


double* normalize(double *a)
{
  double mag=0.0;
  for(int k=0;k<3;k++)
    mag += a[k]*a[k];
  mag=sqrt(mag);
  for(int k=0;k<3;k++)
    a[k]/= mag;
  return a;
}

int main()
{
	double *m;
	double a[3][3]={{1,1,1},{-10,-10,-10},{-10,10,0}};
	// add a condition to check for magnitude=infinity ie NaN -isnan() 
	
	try
	{	
		for (int i=0;i<3;i++)
		{
			m=normalize(a[i]);
			if(m[0]>1 || m[1]>1 || m[2]>1)
				throw (0);
		}
	}
	
	catch(...)
	{
		return 0;
	}
	
	return 1;
}