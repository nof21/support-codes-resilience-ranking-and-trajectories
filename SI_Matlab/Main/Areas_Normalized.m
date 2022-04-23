%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elaborated by Natanael Bolson
% Prof. Tad Patzek and Maxim Yutkin
% EGG-ANPERC-KAUST 12/2020
% Description: Algorithm calculates the Area via Mean, Optmized, getting
% minimum, maximum and standard deviation
% Value of areas are NORMALIZED
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear 
close all
t0=cputime;

%% Load Data

load ../Data/Data_Indicators
load ../Data/Clean_Mirrors

%% Variables

CO2_N=Indicators.GHG_N;
Exp_N=Indicators.Exp_N;
GDP_N=Indicators.GDP_N;
HDI_N=Indicators.HDI_N;
Land_N=Indicators.Land_N;
Mat_N=Indicators.Mat_N;
Ren_N=Indicators.Ren_N;
Water_N=Indicators.Water_N;

%%
 X=[0,45,90,135,180,225,270,315,360]*pi/180;
 Y=[1 1 1 1 1 1 1 1 1 ];
[x,y] = pol2cart(X,Y);
A_max_N=polyarea(x,y);% Maximum area to normalize

for m=1:26
    for n=1:231
         Y=[GDP_N(n,m),CO2_N(n,m),...
      Exp_N(n,m),Ren_N(n,m),Water_N(n,m),Land_N(n,m),...
      Mat_N(n,m),HDI_N(n,m),GDP_N(n,m)]; % Optimized
        
    % Area Optimized
        [x,y]=pol2cart(X,Y);
        Area_Opt(n,m)=polyarea(x,y)/A_max_N;
        
    % Area 2520 permutations 
        P=perms(Y(2:8));
        P(find(isnan(L)),:)=[];
        
        for j=1:size(P,1)
            [x,y]=pol2cart(X,[Y(1) P(j,:) Y(1)]);
            Area(j)=polyarea(x,y); 
        end
        Area_N=Area/A_max_N;
        Min=nanmin(Area_N);
        Max=nanmax(Area_N);
        Mean=nanmean(Area_N);
        STD=nanstd(Area_N);
        CV=STD/Mean;
        
        Area_Min(n,m)=Min;
        Area_Max(n,m)=Max;
        Area_Mean(n,m)=Mean;
        Area_STD(n,m)=STD;
        Area_CV(n,m)=CV;
        
    end
end

%% Save Data

Areas.Area_Min=Area_Min;
Areas.Area_Max=Area_Max;
Areas.Area_Mean=Area_Mean;
Areas.Area_STD=Area_STD;
Areas.Area_CV=Area_CV;
Areas.Area_Opt=Area_Opt;

% save Data_Area_N.mat Areas

t=cputime-t0;