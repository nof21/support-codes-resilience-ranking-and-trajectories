%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elaborated by Natanael Bolson
% Prof. Tad Patzek and Maxim Yutkin
% EGG-ANPERC-KAUST 12/2020
% Description: Calculate the Sustainaibility score via the optmized method
% for all the years and generate a histogram
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear 
close all
Print='F';%T Prints

%% Load Data

load ../Data/Data_Indicators
load ../Data/Data_EIA_H.mat

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

%% Get area
X=[0,45,90,135,180,225,270,315,360]*pi/180;
Area=[];
for m=1:26
    for n=1:231
        
        Y=[GDP_N(n,m),CO2_N(n,m),...
            Exp_N(n,m),Ren_N(n,m),Water_N(n,m),Land_N(n,m),...
            Mat_N(n,m),HDI_N(n,m),GDP_N(n,m)]; % Optimized   
        [x,y] = pol2cart(X,Y);
        Area(n,m)=polyarea(x,y);
    end
end

%% Maximum score 
Y=[1 1 1 1 1 1 1 1 1 ];
[x,y] = pol2cart(X,Y);
A_max=polyarea(x,y);% Maximum area

%% Calculate Sustainiability Score
 Score_Area=Area/A_max;
 Table=[Labels,array2table(Score_Area)];
 Clean=find(all(isnan(Score_Area),2));
 Table(Clean,:)=[];
 Table.Properties.VariableNames={'Country','Y1990','Y1991','Y1992','Y1993',...
    'Y1994','Y1995','Y1996','Y1997','Y1998','Y1999','Y2000','Y2001','Y2002',...
    'Y2003','Y2004','Y2005','Y2006','Y2007','Y2008','Y2009','Y2010','Y2011',...
    'Y2012','Y2013','Y2014','Y2015'};
%% Top and Bottom Countries

Top10=[];
Bottom10=[];

for n=2:27
      
Table = sortrows(Table,n,'descend');
II=find(Table{:,n}>=0,1);
T10=Table.Country(II:II+19);
Top10=[Top10,T10];

Table = sortrows(Table,n,'ascend');
II=find(Table{:,n}>=0,1);
B10=Table.Country(II:II+19);
Bottom10=[Bottom10,B10];

end

%% Counts for Histogram
[uniqueB,~,idx] = unique(Bottom10,'stable');
countB = hist(idx,unique(idx));
Count_B_table=table(uniqueB,countB');

[uniqueT,~,idx] = unique(Top10,'stable');
countT = hist(idx,unique(idx));
Count_T_table=table(uniqueT,countT');

%% Plot Histogram Bottom 20

Count_B_table = sortrows(Count_B_table,'Var2','descend');
XB=table2array(Count_B_table(:,1));
XB([1 6 ])={'Sao Tome a.P' 'UAE'};
YB=table2array(Count_B_table(1:23,2));

figure(1)
b=bar(YB,'barwidth',0.75);
xticks(linspace(1,23,23))
xticklabels(categorical(XB))
b(1).FaceColor = [178,24,43]/255;
a = (1:size(YB,1)).';
x = [a];
for k=1:size(YB,1)
        text(x(k),YB(k),num2str(YB(k),'%0.0f'),...
            'HorizontalAlignment','center',...
            'VerticalAlignment','bottom','interpreter','latex')
end
text(-0.5,3,'$$\mathrm{Bottom~20~(Counts)}$$','rotation',90,...
    'Fontsize',13,'interpreter','latex')
xlabel('$$\mathrm{Country}$$','interpreter','latex')
xlim([0.5 23.5])
xtickangle(90)
set(gca,'box','off','XMinorTick','off','YMinorTick','on')
set(gca,'Fontsize',13,'TickDir','in','FontWeight','normal','GridAlpha',0.13,...
    'LineWidth',0.2,'TickLength',[0.01 0.01],'TickLabelInterpreter','latex')
ax=gca;
ax.YAxis.Visible = 'off'; % remove y-axis
if Print=='T'
    print('-depsc2','-r400','Hist_Bottom_A.eps')
end
%% Plot Histogram Top 20

Count_T_table = sortrows(Count_T_table,'Var2','descend');
XT=table2array(Count_T_table(:,1));
XT(8)={'D.R. Congo'};
YT=table2array(Count_T_table(1:23,2));

figure(2)
b=bar(YT,'barwidth',0.75);
xticks(linspace(1,23,23))
xticklabels(categorical(XT))
b(1).FaceColor = [27,120,55]/255;
a = (1:size(YT,1)).';
x = [a];
for k=1:size(YT,1)
        text(x(k),YT(k),num2str(YT(k),'%0.0f'),...
            'HorizontalAlignment','center',...
            'VerticalAlignment','bottom','interpreter','latex')
end
text(-0.5,6,'$$\mathrm{Top~20~(Counts)}$$','rotation',90,'Fontsize',13,...
    'interpreter','latex')
xlim([0.5 23.5])
xtickangle(90)
xlabel('$$\mathrm{Country}$$','interpreter','latex')
set(gca,'box','off','XMinorTick','off','YMinorTick','on')
set(gca,'Fontsize',13,'TickDir','in','FontWeight','normal','GridAlpha',0.13,...
    'LineWidth',0.2,'TickLength',[0.01 0.01],'TickLabelInterpreter','latex')
ax=gca;
ax.YAxis.Visible = 'off'; % remove y-axis
if Print=='T'
    print('-depsc2','-r400','Hist_Top_A.eps')
end
