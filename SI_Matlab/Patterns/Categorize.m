%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elaborated by Natanael Bolson
% Prof. Tad Patzek and Maxim Yutkin
% EGG-ANPERC-KAUST 05/2021
% Description: Make the categorical classifcation of the indicators
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Year
yo=Year_T -1989;

%% Load Data
load ../Data/Data_Area_N.mat
load ../Data/Data_EIA_H.mat
load ../Data/Data_Indicators.mat

%% Variables
CO2_N=Indicators.GHG_N;
Exp_N=Indicators.Exp_N;
GDP_N=Indicators.GDP_N;
HDI_N=Indicators.HDI_N;
Land_N=Indicators.Land_N;
Mat_N=Indicators.Mat_N;
Ren_N=Indicators.Ren_N;
Water_N=Indicators.Water_N;
Labels=Data_EIA_H.Labels;
Labels([53 45 46 161])={'Cote dIvoire';'Congo';'D.R.Congo';'P. N. Guinea'};
Score=Areas.Area_Opt;
year=1990:2015;


Ind_S=[];
for j=yo
    m=j;
    for n= 1:231
   
        Y=[GDP_N(n,m),CO2_N(n,m),...
          Exp_N(n,m),Ren_N(n,m),Water_N(n,m),Land_N(n,m),...
          Mat_N(n,m),HDI_N(n,m),GDP_N(n,m)]; % Optimized
    Ind_S=[Ind_S;Y];
        
    end
end

[rows, columns] = find(isnan(Ind_S));
Clean=unique(rows);
Score_Y=Score(:,yo);

%% Clean and make Table
Score_Y(Clean)=[];
Labels(Clean)=[];
Ind_S(Clean,:)=[];
Num=1:size(Score_Y);
Num=Num';

Tab=table(Labels,Num,Score_Y);
CO2_N(Clean,:)=[];
Exp_N(Clean,:)=[];
GDP_N(Clean,:)=[];
HDI_N(Clean,:)=[];
Land_N(Clean,:)=[];
Mat_N(Clean,:)=[];
Ren_N(Clean,:)=[];
Water_N(Clean,:)=[];

%% Make Categorical Classification

% CO2
CO2_cat=categorical([]);
H=find(CO2_N>=1);
M=find(CO2_N<1 & CO2_N>0.4);
L=find(CO2_N<=0.4);
N=isnan(CO2_N);
CO2_cat(L)='L';
CO2_cat(M)='M';
CO2_cat(H)='H';
CO2_cat(N)='NaN';
CO2_cat=reshape(CO2_cat,[length(Score_Y) 26]);

% Energy
Exp_cat=categorical([]);
H=find(Exp_N>=0.9);
M=find(Exp_N<0.9 & Exp_N>0.5);
L=find(Exp_N<=0.5);
N=isnan(Exp_N);
Exp_cat(L)='L';
Exp_cat(M)='M';
Exp_cat(H)='H';
Exp_cat(N)='NaN';
Exp_cat=reshape(Exp_cat,[size(Score_Y) 26]);

% GDP
GDP_cat=categorical([]);
H=find(GDP_N>=1);
M=find(GDP_N<1 & GDP_N>0.4);
L=find(GDP_N<=0.4);
N=isnan(GDP_N);
GDP_cat(L)='L';
GDP_cat(M)='M';
GDP_cat(H)='H';
GDP_cat(N)='NaN';
GDP_cat=reshape(GDP_cat,[size(Score_Y) 26]);

% HDI
HDI_cat=categorical([]);
H=find(HDI_N>=0.8);
M=find(HDI_N<0.8 & HDI_N>0.55);
L=find(HDI_N<=0.55);
N=isnan(HDI_N);
HDI_cat(L)='L';
HDI_cat(M)='M';
HDI_cat(H)='H';
HDI_cat(N)='NaN';
HDI_cat=reshape(HDI_cat,[size(Score_Y) 26]);

% Arable Land
Land_cat=categorical([]);
H=find(Land_N>=1);
M=find(Land_N<1 & Land_N>0.4);
L=find(Land_N<=0.4);
N=isnan(Land_N);
Land_cat(L)='L';
Land_cat(M)='M';
Land_cat(H)='H';
Land_cat(N)='NaN';
Land_cat=reshape(Land_cat,[size(Score_Y) 26]);

% Material
Mat_cat=categorical([]);
H=find(Mat_N>=1);
M=find(Mat_N<1 & Mat_N>0.5);
L=find(Mat_N<=0.5);
N=isnan(Mat_N);
Mat_cat(L)='L';
Mat_cat(M)='M';
Mat_cat(H)='H';
Mat_cat(N)='NaN';
Mat_cat=reshape(Mat_cat,[size(Score_Y) 26]);

% Renewable
Ren_cat=categorical([]);
H=find(Ren_N>=0.5);
M=find(Ren_N<0.5 & Ren_N>0.25);
L=find(Ren_N<=0.25);
N=isnan(Ren_N);
Ren_cat(L)='L';
Ren_cat(M)='M';
Ren_cat(H)='H';
Ren_cat(N)='NaN';
Ren_cat=reshape(Ren_cat,[size(Score_Y) 26]);

% Water
Water_cat=categorical([]);
H=find(Water_N>=1);
M=find(Water_N<1 & Water_N>0.5);
L=find(Water_N<=0.5);
N=isnan(Water_N);
Water_cat(L)='L';
Water_cat(M)='M';
Water_cat(H)='H';
Water_cat(N)='NaN';
Water_cat=reshape(Water_cat,[size(Score_Y) 26]);

%% Here creates the filters

% GDP
GDP_H=find(GDP_cat(:,yo)=='H');
GDP_M=find(GDP_cat(:,yo)=='M');
GDP_L=find(GDP_cat(:,yo)=='L');
% HDI
HDI_H=find(HDI_cat(:,yo)=='H');
HDI_M=find(HDI_cat(:,yo)=='M');
HDI_L=find(HDI_cat(:,yo)=='L');
% Water
Wat_H=find(Water_cat(:,yo)=='H');
Wat_M=find(Water_cat(:,yo)=='M');
Wat_L=find(Water_cat(:,yo)=='L');
% Land
Land_L=find(Land_cat(:,yo)=='L');
Land_M=find(Land_cat(:,yo)=='M');
Land_H=find(Land_cat(:,yo)=='H');
% Energy
En_H=find(Exp_cat(:,yo)=='H');
En_M=find(Exp_cat(:,yo)=='M');
En_L=find(Exp_cat(:,yo)=='L');
%CO2
CO2_H=find(CO2_cat(:,yo)=='H');
CO2_M=find(CO2_cat(:,yo)=='M');
CO2_L=find(CO2_cat(:,yo)=='L');
% Material Footprint
Mat_H=find(Mat_cat(:,yo)=='H');
Mat_M=find(Mat_cat(:,yo)=='M');
Mat_L=find(Mat_cat(:,yo)=='L');
% Renewables
Ren_H=find(Ren_cat(:,yo)=='H');
Ren_M=find(Ren_cat(:,yo)=='M');
Ren_L=find(Ren_cat(:,yo)=='L');
