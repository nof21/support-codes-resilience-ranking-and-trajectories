%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elaborated by Natanael Bolson
% Prof. Tad Patzek and Maxim Yutkin
% EGG-ANPERC-KAUST 08/2020
% Description: Algorithm Indicators Trend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear 
close all
t0=cputime;
Print='F';% T Prints
%% Load data

load ../Data/Data_EIA_H.mat
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
% Labels
Labels=strtrim(Data_EIA_H.Labels);

%% Table with Indicators 

year1=1992; % Reference Year
year2=2015; % Year compared. Also the year for categorical classification
I1=year1-1989;
I2=year2-1989;

% Table difference between Indicators
TableDif=table(Labels,Ren_N(:,I2)-Ren_N(:,I1),Exp_N(:,I2)-Exp_N(:,I1),...
    CO2_N(:,I2)-CO2_N(:,I1),Land_N(:,I2)-Land_N(:,I1),Water_N(:,I2)-Water_N(:,I1),...
    Mat_N(:,I2)-Mat_N(:,I1),HDI_N(:,I2)-HDI_N(:,I1),GDP_N(:,I2)-GDP_N(:,I1));
TableDif.Properties.VariableNames = {'Country','Ren','Exp','CO2','Land',...
    'Water','Mat','HDI','GDP'};

%% Create Categorical Indicators

% CO2
CO2_cat=categorical([]);
for n=1:231
    if CO2_N(n,I2)>=1
        CO2_cat(n)='High';
    elseif CO2_N(n,I2)<1 && CO2_N(n,I2) >0.4
        CO2_cat(n)='Middle';
    elseif CO2_N(n,I2)<=0.4
        CO2_cat(n)='Low';
    elseif isnan(CO2_N(n,I2))==1
        CO2_cat(n)='NaN';
    end
end
CO2_cat=CO2_cat';

% Energy
Exp_cat=categorical([]);
for n=1:231
    if Exp_N(n,I2)>=0.9
        Exp_cat(n)='High';
    elseif Exp_N(n,I2)<0.9 && Exp_N(n,I2) >0.5
        Exp_cat(n)='Middle';
    elseif Exp_N(n,I2)<=0.5
        Exp_cat(n)='Low';
    elseif isnan(Exp_N(n,I2))==1
        Exp_cat(n)='NaN';
    end
end
Exp_cat=Exp_cat';

% GDP
GDP_cat=categorical([]);
for n=1:231
    if GDP_N(n,I2)>=1
        GDP_cat(n)='High';
    elseif GDP_N(n,I2)<1 && GDP_N(n,I2) >0.4
        GDP_cat(n)='Middle';
    elseif GDP_N(n,I2)<=0.4
        GDP_cat(n)='Low';
    elseif isnan(GDP_N(n,I2))==1
        GDP_cat(n)='NaN';
    end
end
GDP_cat=GDP_cat';

% HDI
HDI_cat=categorical([]);
for n=1:231
    if HDI_N(n,I2)>=0.8
        HDI_cat(n)='High';
    elseif HDI_N(n,I2)<0.8 && HDI_N(n,I2) >0.55
        HDI_cat(n)='Middle';
    elseif HDI_N(n,I2)<=0.55
        HDI_cat(n)='Low';
    elseif isnan(HDI_N(n,I2))==1
        HDI_cat(n)='NaN';
    end
end
HDI_cat=HDI_cat';

% Land
Land_cat=categorical([]);
for n=1:231
    if Land_N(n,I2)>=1
        Land_cat(n)='High';
    elseif Land_N(n,I2)<1 && Land_N(n,I2) >0.4
        Land_cat(n)='Middle';
    elseif Land_N(n,I2)<=0.4
        Land_cat(n)='Low';
    elseif isnan(Land_N(n,I2))==1
        Land_cat(n)='NaN';
    end
end
Land_cat=Land_cat';

% Material Footprint
Mat_cat=categorical([]);
for n=1:231
    if Mat_N(n,I2)>=1
        Mat_cat(n)='High';
    elseif Mat_N(n,I2)<1 && Mat_N(n,I2) >0.5
        Mat_cat(n)='Middle';
    elseif Mat_N(n,I2)<=0.5
        Mat_cat(n)='Low';
    elseif isnan(Mat_N(n,I2))==1
        Mat_cat(n)='NaN';
    end
end
Mat_cat=Mat_cat';

% Renewables
Ren_cat=categorical([]);
for n=1:231
    if Ren_N(n,I2)>=0.5
        Ren_cat(n)='High';
    elseif Ren_N(n,I2)<0.5 && Ren_N(n,I2) >0.25
        Ren_cat(n)='Middle';
    elseif Ren_N(n,I2)<=0.25
        Ren_cat(n)='Low';
    elseif isnan(Ren_N(n,I2))==1
        Ren_cat(n)='NaN';
    end
end
Ren_cat=Ren_cat';

% Water
Water_cat=categorical([]);
for n=1:231
    if Water_N(n,I2)>=1
        Water_cat(n)='High';
    elseif Water_N(n,I2)<1 && Water_N(n,I2) >0.5
        Water_cat(n)='Middle';
    elseif Water_N(n,I2)<=0.5
        Water_cat(n)='Low';
    elseif isnan(Water_N(n,I2))==1
        Water_cat(n)='NaN';
    end
end
Water_cat=Water_cat';

%% Make Table Categorical

TabCat=table(Labels,Ren_cat,Exp_cat,CO2_cat,Land_cat,Water_cat,Mat_cat,...
    HDI_cat,GDP_cat);
TabCat.Properties.VariableNames = {'Country','Ren',...
    'Exp','CO2','Land','Water','Mat','HDI','GDP'};

%% Indicator improved or worsened

% CO2
% Improved
F_CO2_P=find(TableDif.CO2>0);
Countries_F_CO2_P=Labels(F_CO2_P);
Tab_CO2_P=TabCat(F_CO2_P,:);
% Worsened
F_CO2_N=find(TableDif.CO2<0);
Countries_F_CO2_N=Labels(F_CO2_N);
Tab_CO2_N=TabCat(F_CO2_N,:);

% Energy
% Improved
F_Exp_P=find(TableDif.Exp>0);
Countries_F_Exp_P=Labels(F_Exp_P);
Tab_Exp_P=TabCat(F_Exp_P,:);
% Worsened
F_Exp_N=find(TableDif.Exp<0);
Countries_F_Exp_N=Labels(F_Exp_N);
Tab_Exp_N=TabCat(F_Exp_N,:);

% GDP
% Improved
F_GDP_P=find(TableDif.GDP>0);
Countries_F_GDP_P=Labels(F_GDP_P);
Tab_GDP_P=TabCat(F_GDP_P,:);
% Worsened
F_GDP_N=find(TableDif.GDP<0);
Countries_F_GDP_N=Labels(F_GDP_N);
Tab_GDP_N=TabCat(F_GDP_N,:);

% HDI
% Improved
F_HDI_P=find(TableDif.HDI>0);
Countries_F_HDI_P=Labels(F_HDI_P);
Tab_HDI_P=TabCat(F_HDI_P,:);
% Worsened
F_HDI_N=find(TableDif.HDI<0);
Countries_F_HDI_N=Labels(F_HDI_N);
Tab_HDI_N=TabCat(F_HDI_N,:);

% Land
% Improved
F_Land_P=find(TableDif.Land>0);
Countries_F_Land_P=Labels(F_Land_P);
Tab_Land_P=TabCat(F_Land_P,:);
% Worsened
F_Land_N=find(TableDif.Land<0);
Countries_F_Land_N=Labels(F_Land_N);
Tab_Land_N=TabCat(F_Land_N,:);

% Material Footprint
% Improved
F_Mat_P=find(TableDif.Mat>0);
Countries_F_Mat_P=Labels(F_Mat_P);
Tab_Mat_P=TabCat(F_Mat_P,:);
% Worsened
F_Mat_N=find(TableDif.Mat<0);
Countries_F_Mat_N=Labels(F_Mat_N);
Tab_Mat_N=TabCat(F_Mat_N,:);

% Renewables
% Improved
F_Ren_P=find(TableDif.Ren>0);
Countries_F_Ren_P=Labels(F_Ren_P);
Tab_Ren_P=TabCat(F_Ren_P,:);
% Worsened
F_Ren_N=find(TableDif.Ren<0);
Countries_F_Ren_N=Labels(F_Ren_N);
Tab_Ren_N=TabCat(F_Ren_N,:);

% Water
% Improved
F_Water_P=find(TableDif.Water>0);
Countries_F_Water_P=Labels(F_Water_P);
Tab_Water_P=TabCat(F_Water_P,:);
% Worsened
F_Water_N=find(TableDif.Water<0);
Countries_F_Water_N=Labels(F_Water_N);
Tab_Water_N=TabCat(F_Water_N,:);

%% Plot Index Trend

X={'$$\mathrm{CO_2}$$','$$\mathrm{Energy}$$','$$\mathrm{GDP}$$',...
    '$$\mathrm{HDI}$$','$$\mathrm{Land}$$','$$\mathrm{Mat.~Foot.}$$',...
    '$$\mathrm{Renewables}$$','$$\mathrm{Water}$$', };

Y=[size(F_CO2_P,1) size(F_CO2_N,1);
    size(F_Exp_P,1) size(F_Exp_N,1);
    size(F_GDP_P,1) size(F_GDP_N,1);
    size(F_HDI_P,1) size(F_HDI_N,1); 
    size(F_Land_P,1) size(F_Land_N,1);
    size(F_Mat_P,1) size(F_Mat_N,1)
    size(F_Ren_P,1) size(F_Ren_N,1); 
    size(F_Water_P,1) size(F_Water_N,1);];

figure('Name','Index Trend')
b=bar(categorical(X),Y,'barwidth',0.75);
b(1).FaceColor = [27,120,55]/255;
b(2).FaceColor = [178,24,43]/255;
a = (1:size(Y,1)).';
x = [a-0.15 a+0.15];
for k=1:size(Y,1)
    for m = 1:size(Y,2)
        text(x(k,m),Y(k,m),num2str(Y(k,m),'%0.0f'),...
            'HorizontalAlignment','center',...
            'VerticalAlignment','bottom','interpreter','latex')
    end
end
text(0,20,'$$\mathrm{Number~ of~ Countries}$$','rotation',90,...
    'Fontsize',15,'interpreter','latex')
leg={'$$\mathrm{Improved}$$','$$\mathrm{Worsened}$$'};
legend(leg,'interpreter','latex','position',[0.185 0.8 0.1 0.1],'box',...
    'off','Fontsize',12)
xlabel('$$\mathrm{Indicator}$$','interpreter','latex')
ylabel('$$\mathrm{Number~ of~ Countries}$$','interpreter','latex')
set(gca,'box','off','XMinorTick','on','YMinorTick','on')
set(gca,'Fontsize',14,'TickDir','in','FontWeight','normal','GridAlpha',0.13,...
    'LineWidth',0.2,'TickLength',[0.01 0.01],'TickLabelInterpreter','latex')
ax=gca;
ax.YAxis.Visible = 'off';
if Print=='T'
    print('-depsc2','-r400','Index_trend.eps')
end
%% Plot Categorical Distribution
CO2=[sum(TabCat.CO2 =='High'),sum(TabCat.CO2 =='Middle'),sum(TabCat.CO2 =='Low')];
Exp=[sum(TabCat.Exp =='High'),sum(TabCat.Exp =='Middle'),sum(TabCat.Exp =='Low')];
GDP=[sum(TabCat.GDP =='High'),sum(TabCat.GDP =='Middle'),sum(TabCat.GDP =='Low')];
HDI=[sum(TabCat.HDI =='High'),sum(TabCat.HDI =='Middle'),sum(TabCat.HDI =='Low')];
Land=[sum(TabCat.Land =='High'),sum(TabCat.Land =='Middle'),sum(TabCat.Land =='Low')];
Mat=[sum(TabCat.Mat =='High'),sum(TabCat.Mat =='Middle'),sum(TabCat.Mat =='Low')];
Ren=[sum(TabCat.Ren =='High'),sum(TabCat.Ren =='Middle'),sum(TabCat.Ren =='Low')];
Water=[sum(TabCat.Water=='High'),sum(TabCat.Water=='Middle'),sum(TabCat.Water=='Low')];

Y=[CO2;Exp;GDP;HDI;Land;Mat;Ren;Water];

figure('Name','Categorical')
b=bar(categorical(X),Y,'barwidth',0.75);
b(1).FaceColor = [27,120,55]/255;
b(2).FaceColor = [241,163,64]/255;
b(3).FaceColor = [178,24,43]/255;
a = (1:size(Y,1)).';
x = [a-0.25 a a+0.25];
for k=1:size(Y,1)
    for m = 1:size(Y,2)
        text(x(k,m),Y(k,m),num2str(Y(k,m),'%0.0f'),...
            'HorizontalAlignment','center',...
            'VerticalAlignment','bottom','interpreter','latex')
    end
end
text(0,30,'$$\mathrm{Number~ of~ Countries}$$','rotation',90,...
    'Fontsize',15,'interpreter','latex')
leg={'$$\mathrm{High}$$','$$\mathrm{Middle}$$','$$\mathrm{Low}$$'};
legend(leg,'interpreter','latex','position',[0.185 0.8 0.1 0.1],'box',...
    'off','Fontsize',12)
xlabel('$$\mathrm{Indicator}$$','interpreter','latex')
ylabel('$$\mathrm{Number~ of~ Countries}$$','interpreter','latex')
set(gca,'box','off','XMinorTick','on','YMinorTick','on')
set(gca,'Fontsize',14,'TickDir','in','FontWeight','normal','GridAlpha',0.13,...
    'LineWidth',0.2,'TickLength',[0.01 0.01],'TickLabelInterpreter','latex')
ax=gca;
ax.YAxis.Visible = 'off';
if Print=='T'
    print('-depsc2','-r400','Index_distribution.eps')
end
%%
t=cputime-t0;

