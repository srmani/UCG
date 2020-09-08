/* passing this test depends on the tolerance set below*/

#include <iostream>
#include <vector>
#include <algorithm>
#include <string.h>
#include <fstream>
#include <string> 
#include <cmath> 

using namespace std;

void normalize(double *a)
{
  double mag=0.0;
  for(int k=0;k<3;k++)
    mag += a[k]*a[k];
  mag=sqrt(mag);
  for(int k=0;k<3;k++)
    a[k] /= mag;
}

void computecross(double *a, double *b1, double *b2)
{
  a[0] = b1[1]*b2[2] - b1[2]*b2[1];
  a[1] = b1[2]*b2[0] - b1[0]*b2[2];
  a[2] = b1[0]*b2[1] - b1[1]*b2[0];
}

double computedihedral(double *x1, double *x2, double *x3, double *x4)
{
  double b1[3],b2[3],b3[3];
  double b1sq,b2sq,b3sq;
  b1sq = b2sq = b3sq = 0.0;
  for(int k=0;k<3;k++)
    {
      b1[k] = x1[k]-x2[k];
      b2[k] = x2[k]-x3[k];
      b3[k] = x3[k]-x4[k];
      //domain->minimum_image(b1[0],b1[1],b1[2]);
      //domain->minimum_image(b2[0],b2[1],b2[2]);
      //domain->minimum_image(b3[0],b3[1],b3[2]);
    }
  normalize(&b1[0]);
  normalize(&b2[0]);
  normalize(&b3[0]);

  double a[3],b[3];
  
  computecross(&a[0],b1,b2);
  computecross(&b[0],b2,b3);

  normalize(&a[0]);
  normalize(&b[0]);
  
  double cosphi;
  cosphi = 0.0;
  for(int k=0;k<3;k++)
    {
      cosphi -= a[k]*b[k];
    }
  return(cosphi);
}

int main()
{
	double x1[2][3]={{0,1,0},{0,1,0}};
	double x2[2][3]={{0,0,0},{0,0,0}};
	double x3[2][3]={{1,0,0},{1,0,0}};
	double x4[2][3]={{1,1,0},{1,0,1}};
	double d[2]={0,-90};
	double ans;
	try
	{	
		for (int i=0;i<2;i++)
		{
			ans=acos(computedihedral(x1[i],x2[i],x3[i],x4[i]))*(180/3.14159)-180;
			if(abs(ans)-abs(d[i])>0.001)
				throw(0);
		}
	}
	
	catch(...)
	{
		return 1;
	}
	
	return 0;
}