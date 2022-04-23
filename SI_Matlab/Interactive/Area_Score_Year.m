%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elaborated by Natanael Bolson
% Prof. Tad Patzek and Maxim Yutkin
% EGG-ANPERC-KAUST 12/2020
% Description: Calculate the Sustainaibility score via the optmized method
% for a specific year and generate polar plots 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear 
close all
t0=cputime;
Print='F';%T Prints

%% Load data
load ../Data/Data_EIA_H.mat
load ../Data/Data_Indicators.mat

%% Variables

% Select a specific year
year=2015;
index=year-1989;

% Labels
Labels=strtrim(Data_EIA_H.Labels);

CO2_N=Indicators.GHG_N(:,index);
Exp_N=Indicators.Exp_N(:,index);
GDP_N=Indicators.GDP_N(:,index);
HDI_N=Indicators.HDI_N(:,index);
Land_N=Indicators.Land_N(:,index);
Mat_N=Indicators.Mat_N(:,index);
Ren_N=Indicators.Ren_N(:,index);
Water_N=Indicators.Water_N(:,index);


%% Get area
X=[0,45,90,135,180,225,270,315,360]*pi/180;

for n=1:231
     Y=[GDP_N(n),CO2_N(n),...
      Exp_N(n),Ren_N(n),Water_N(n),Land_N(n),...
      Mat_N(n),HDI_N(n),GDP_N(n)]; % Optimized
    [x,y] = pol2cart(X,Y);
    Area(n)=polyarea(x,y);
end

%% Maximum score 
Y=[1 1 1 1 1 1 1 1 1 ];
[x,y] = pol2cart(X,Y);
A_max=polyarea(x,y);% Maximum area

%% Make Table
 Score_Area=Area/A_max;
 Table=table(Labels,Score_Area');
 Clean=find(all(isnan(Score_Area),1));
 Table(Clean,:)=[];
 Table.Properties.VariableNames={'Country','Score'};

%% Top and Bottom 10
 
Table =sortrows(Table,'Score','descend');

Top10=Table.Country(1:10);

Table =sortrows(Table,'Score','ascend');

Bottom10=Table.Country(1:10);

%% Polar Plots
% Colormaps

ColorT=[
166,206,227
31,120,180
178,223,138
51,160,44
251,154,153
227,26,28
253,191,111
255,127,0
202,178,214
106,61,154]/255;

ColorB=[103,0,31;
178,24,43;
214,96,77;
244,165,130;
253,219,199;
224,224,224;
186,186,186;
135,135,135;
77,77,77;
26,26,26;]/255;

%% Polar Bottom
Table =sortrows(Table,'Score','ascend');
I_10=find(contains(Labels,Bottom10));
Polar=[];
for n=1:10
    Polar=[Polar;GDP_N(I_10(n)),CO2_N(I_10(n)),Exp_N(I_10(n)),...
        Ren_N(I_10(n)),Water_N(I_10(n)),Land_N(I_10(n)),Mat_N(I_10(n)),...
        HDI_N(I_10(n)),GDP_N(I_10(n))];
end

figure('Name','Bottom10')
for n=1:10
    Values=Polar(n,:);
    X=[0,45,90,135,180,225,270,315,360]*pi/180;
    Labeltheta={'GDP','$$\mathrm{CO_2}$$','Energy','Renewables','Water','Land',...
        'Material Footprint','HDI'};
    polarplot(X,Values,'color',ColorB(n,:),'linewidth',1.5)
    hold on
    thetaticks(0:45:315)
    thetaticklabels(Labeltheta)
    set(gca,'Fontsize',14,'TickDir','in','FontWeight','normal','GridAlpha',0.25,...
     'LineWidth',0.2,'TickLength',[0.01 0.01],'TickLabelInterpreter','latex')
   LegT(n)=Labels(I_10(n));
 

end
ax = gca;
axPos = ax.Position;
ax.Position = axPos + [0 0.05 0 0];
ax='tight';
legend(LegT,'Position',[0.45 0.0 0.1 0.1],'FontSize', 13,'NumColumns',5,...
    'box','off','interpreter','latex')
set(gcf,'Position',[100 100 700 700])
if Print=='T'
    print('-depsc2','-r400','Polar_Bottom_A.eps');
end

%% Polar Top

Table =sortrows(Table,'Score','descend');
I_10=find(contains(Labels,Top10));
Polar=[];

for n=1:10
    Polar=[Polar;GDP_N(I_10(n)),CO2_N(I_10(n)),Exp_N(I_10(n)),...
        Ren_N(I_10(n)),Water_N(I_10(n)),Land_N(I_10(n)),Mat_N(I_10(n)),...
        HDI_N(I_10(n)),GDP_N(I_10(n))];
end

figure('Name','Top10')
for n=1:10
    Values=Polar(n,:);
    X=[0,45,90,135,180,225,270,315,360]*pi/180;
    Labeltheta={'GDP','$$\mathrm{CO_2}$$','Energy','Renewables','Water','Land',...
        'Material Footprint','HDI'};
    polarplot(X,Values,'color',ColorT(n,:),'linewidth',1.5)
    hold on
    thetaticks(0:45:315)
    thetaticklabels(Labeltheta)
    set(gca,'Fontsize',14,'TickDir','in','FontWeight','normal','GridAlpha',0.25,...
     'LineWidth',0.2,'TickLength',[0.01 0.01],'TickLabelInterpreter','latex')
   LegT(n)=Labels(I_10(n));

end
ax = gca;
axPos = ax.Position;
ax.Position = axPos+ [0 0.05 0 0];
legend(LegT,'Position',[0.45 0.0 0.1 0.1],'FontSize', 13,'NumColumns',5,...
    'box','off','interpreter','latex')
set(gcf,'Position',[100 100 700 700])

if Print=='T'
    print('-depsc2','-r400','Polar_Top_A.eps');
end

