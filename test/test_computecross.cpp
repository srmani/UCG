#include <iostream>
#include <vector>
#include <algorithm>
#include <string.h>
#include <fstream>
#include <string> 
#include <cmath> 

using namespace std;

void computecross(double *a, double *b1, double *b2)
{
  a[0] = b1[1]*b2[2] - b1[2]*b2[1];
  a[1] = b1[2]*b2[0] - b1[0]*b2[2];
  a[2] = b1[0]*b2[1] - b1[1]*b2[0];
}

int main()
{
	double b1[8][3]={{0,0,0},{1,0,0},{0,1,0},{0,0,1},{1,0,0},{0,1,0},{0,0,1},{1,1,1}};
	double b2[8][3]={{0,0,0},{1,0,0},{0,1,0},{0,0,1},{0,1,0},{0,0,1},{1,0,0},{1,1,1}};
	double  c[8][3]={{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,1},{1,0,0},{0,1,0},{0,0,0}};
	double a[3];

	try
	{	
		for (int i=0;i<8;i++)
		{
			computecross(&a[0],b1[i],b2[i]);
			if(a[0]!=c[i][0] || a[1]!=c[i][1] || a[2]!=c[i][2])
				throw (0);
		}
	}
	
	catch(...)
	{
		return 1;
	}
	
	return 0;
}