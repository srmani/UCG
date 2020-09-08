#include <iostream>
#include <vector>
#include <algorithm>
#include <string.h>
#include <fstream>
#include <string> 
#include <cmath> 

using namespace std;

double computedot(double *b1, double *b2)
{
  return(b1[0]*b2[0]+b1[1]*b2[1]+b1[2]*b2[2]);
}

int main()
{
	double a[8][3]={{0,0,0},{1,0,0},{0,1,0},{0,0,1},{1,0,0},{0,1,0},{0,0,1},{1,1,1}};
	double b[8][3]={{0,0,0},{1,0,0},{0,1,0},{0,0,1},{0,1,0},{0,0,1},{1,0,0},{1,1,1}};
	double d[8]={0,1,1,1,0,0,0,3};
	double m;

	try
	{	
		for (int i=0;i<8;i++)
		{
			m=computedot(a[i],b[i]);
			if(m!=d[i])
				throw (0);
		}
	}
	
	catch(...)
	{
		return 1;
	}
	
	return 0;
}