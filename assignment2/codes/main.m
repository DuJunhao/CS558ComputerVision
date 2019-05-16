close all; 
clear all;
clc
prompt1='Please input the threshold for the hessian filter\n';
threshold=input(prompt1);
prompt2='Please input the sigma for the gaussian filter\n';
sigma=input(prompt2);
[ims,DetectedPoints,points]=PreProcessing(threshold,sigma);
DistanceThresholding=sqrt(3.84*sigma*sigma);
inliersRatio=0.95;


[samp1,samp2]=ransacTest(ims,DetectedPoints ,DistanceThresholding,inliersRatio);

[m,n]=houghDetect(ims,DetectedPoints);