%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elaborated by Natanael Bolson
% Prof. Tad Patzek and Maxim Yutkin
% EGG-ANPERC-KAUST 12/2020
% Description: Coefficient of variation analysis and histograms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
close all
clc
t0=cputime;

%% Load
load ../Data/Tab_A_CV.mat

%% Variables
Opt=Tab_A_CV.Opt;
Mean=Tab_A_CV.Mean;
CV=Tab_A_CV.CV;
Label=Tab_A_CV.Country;
Min=Tab_A_CV.Min(:,end);
Max=Tab_A_CV.Max(:,end);
Ratio=Min./Max;

Label={'';'';'';'';'';
    '';'';'Australia';'';'';'Bahrain';'';
    '';'';'';'';'';'';'';
    '';'';'Brazil';'';
    '';'';'';'';'';'';
    '';'';'';'';'';'China';
    '';'';'';'';'';
    'Cuba';'';'';'';'';'Djibouti';
    '';'';'Egypt';'';'Eritrea';'';
    '';'';'';'';'';'';'';
    '';'';'';'';'';'';'';'Haiti';
    '';'';'';'';'';'';'';'';
    'Israel';'';'';'';'';'';'';'';
    '';'';'';'';'';'';'';'';
    '';'';'';'';'Maldives';'';'';
    '';'';'';'';'';'';'';
    '';'';'';'';'';'Niger';'';
    '';'';'';'';'';'';
    '';'';'';'';'';'';'';'Russia';
    'Rwanda';'';'KSA';'';'';'';
    'Singapore';'';'';'';'';'';
    '';'';'';'';'';'';'';
    '';'';'';'';'';'';
    '';'';'';'';'UAE';
    'UK';'US';'Uruguay';'';'';
    '';'';'';'';''};
Label(44)=[];

%% Optimum

figure('Name','CV')
scatter(Opt./max(2.83),CV,'linewidth',1.25)
text(Opt./max(2.83)+0.01,CV,Label,'rotation',0,'fontsize',9,'interpreter','latex') %to insert the labels in the graph
text(Opt(118)/max(2.83)-0.03,CV(118)+0.025,'Paraguay','rotation',0,'fontsize',9,'interpreter','latex')
text(Opt(18)/max(2.83)-0.0,CV(18)-0.02,'Bhutan','rotation',0,'fontsize',9,'interpreter','latex') 

xlabel('Normalized Optimum Area','Interpreter','latex')
ylabel('Coefficient of Variation','Interpreter','latex')
xlim([0.05 0.6])
ylim([0 0.8])
box on
grid on
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'Fontsize',12,'TickDir','in','FontWeight','normal',...
    'GridAlpha',0.13,'LineWidth',0.2,'TickLength',[0.01 0.01],...
    'TickLabelInterpreter','latex')
% print('-depsc2','-r400','CV.eps');

%% Histogram CV
figure
histfit(CV,15,'lognormal')
xlabel('Coefficient of Variation',"Interpreter","latex")
ylabel('Counts',"Interpreter","latex")
annotation("textarrow",[0.83 0.83],[0.22 0.13],'String','Singapore','HorizontalAlignment',"left","Interpreter","latex")
annotation("textarrow",[0.64 0.64],[0.22 0.16],'String',{'Kuwait','UAE'},'HorizontalAlignment',"center","Interpreter","latex")
box on 
grid on
xlim([0 0.8])
set(gca,'Fontsize',12,'TickDir','in','FontWeight','normal','GridAlpha',0.13,...
    'LineWidth',0.2,'TickLength',[0.01 0.01],'TickLabelInterpreter','latex')
% print('-dpdf','-r400','Hist_CV.pdf')
% print('-depsc2','-r400','Hist_CV.eps');
