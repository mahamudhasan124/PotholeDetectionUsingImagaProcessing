
clc;
x = imread('cameraman.tif');

x1=(x<81);
x1=(x1*80);

x2=(x>80)&(x<161);
x2=x2*160;

x3=(x>160);
x3=x3*255;
sum=x2+x3+x1;



sum



