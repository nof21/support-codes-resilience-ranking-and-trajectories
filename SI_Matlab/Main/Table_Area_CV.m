%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elaborated by Natanael Bolson
% Prof. Tad Patzek and Maxim Yutkin
% EGG-ANPERC-KAUST 05/2021
% Description: Make table for areas and coefficient of variation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
close all

%% Load
load ../Data/Data_Area.mat
load ../Data/Data_EIA_H.mat

%% Variables
Area_CV=Areas.Area_CV;
Area_Max=Areas.Area_Max;
Area_Mean=Areas.Area_Mean;
Area_Min=Areas.Area_Min;
Area_STD=Areas.Area_STD;
Area_Opt=Areas.Area_Opt;
Labels=Data_EIA_H.Labels;

%% Make Table

year=2015;
year=year-1989;
A=[Area_CV(:,year),Area_Mean(:,year),Area_Opt(:,year),Area_Min(:,year),Area_Max(:,year)];
Tab_A_CV=[Labels,array2table(A)];
Tab_A_CV.Properties.VariableNames={'Country','CV','Mean','Opt','Min','Max'};
 
Clean=find(all(isnan(Tab_A_CV.Mean),2));
Tab_A_CV([1;Clean],:)=[];% 1 Eliminate World

% save Tab_A_CV.mat Tab_A_CV
