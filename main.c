
#include <stdio.h>
#include "convolve.h"
#define DATALEN 40000
int main(int argc, char *argv[])
{
FILE *fptr;
fptr=fopen("input_x.txt","r");
// float a[8146416];
float *a;
a = (float*)malloc(sizeof(float)*DATALEN);

int idx=0;

if(fptr==NULL){
  printf("File does not exist \n");
}
else{
  for(idx=0; idx<DATALEN; idx++){
    fscanf(fptr, "%f",&a[idx]);
    printf("%f\n",a[idx]);
    }
}

fclose(fptr);




  float h[] = { -0.00492806603715584,-0.00224701821255891,0.00802276324072392,0.00332640867173020,-0.00760734526502086,-0.0111432086954421,0.00835232813465145,0.0189650631297413,-0.00276073605870313,-0.0301140493056137,-0.00900112815614151,0.0409324257925685,0.0336578388045546,-0.0509460715967910,-0.0861131441474549,0.0576092723507041,0.311366535584623,0.439889741720889,0.311366535584623,0.0576092723507041,-0.0861131441474549,-0.0509460715967910,0.0336578388045546,0.0409324257925685,-0.00900112815614151,-0.0301140493056137,-0.00276073605870313,0.0189650631297413,0.00835232813465145,-0.0111432086954421,-0.00760734526502086,0.00332640867173020,0.00802276324072392,-0.00224701821255891,-0.00492806603715584};
  float x[] = { 2, 4, -1, 1 };
  int lenY;

  float *y = convolve(h,a,35,DATALEN,&lenY);


  for(int i=0;i<lenY;i++) {
    printf("%f ",y[i]);
  }
/////////////////////////////////////////
FILE *fptr_out;
fptr_out=fopen("output.txt","w");

if(fptr_out==NULL){
  printf("File does not exist \n");
}
else{
  for(idx=0; idx<DATALEN; idx++){
    fprintf(fptr_out, "%f\n", y[idx]);
    }
}

fclose(fptr_out);

/////////////////////////////////////////////

  puts("");
  free(y);
  return 0;
}
