function CalcMyself

%% load data 

% to working directory
cd '/Users/shumpei/Google Drive/CSFI/glc2017';

% checking the excel file
% [status,sheets] = xlsfinfo('30-10-6forMatlab.xlsx');

% read raw data
T30= readtable('30-10-6forMatlab.xlsx','sheet','30-2');

Raw30 = xlsread('30-10-6forMatlab.xlsx','30-2');
TP30 = xlsread('TestPoint','30-2');
%% eccentricity e
for  n =1:length(TP30)
 Ecc(1,n)= sqrt(TP30(1,n)^2+TP30(2,n)^2);

 dgb = (Raw30(:,n)-1-(-1.5*1.34*Ecc(n))-14.8)/(0.054*1.34*Ecc(n)+0.9);
 Gb(:,n) = 6^2*(1/3.5)^2*10.^(0.1*dgb);

%  RGC(:,n) = 2.95*10.^(0.1*(Raw(:,n)-1-(-1.5*1.34*Ecc(n)-14.8))/(0.054*1.34*Ecc(n)+0.9));
end
RGC_HFA30= sum(Gb*1000,2);

%% harwerth, Medeiros

% SAPrgc
m = 0.054*1.34*Ecc+0.9;
b = (-1.5*(Ecc*1.32))-14.8;
for n =1:length(Ecc)
 gc(:,n) = (Raw30(:,n)-1-b(n))/m(n)+4.7;
end
SAPrgc = 10.^(gc*0.1);

SAPrgc30 = sum(SAPrgc,2);

%%
figure;
plot(RGC_HFA30,SAPrgc30,'o')
lsline
axis equal

figure;hold on;


%% OCTrgc
d=(-0.007*age)+1.4;
c=(-0.26*MD)+0.12;
OCTrgc = 10^((log((averageRNFLT*10870*d))*10-c)*0.1);

%% 10-2
Raw10 = xlsread('30-10-6forMatlab.xlsx','10-2wNA');
TP10 = xlsread('TestPoint','10-2');

T10  = readtable('30-10-6forMatlab.xlsx','sheet','dataForR');
%%
for  n =1:length(TP30)
    Ecc(1,n)= sqrt(TP30(1,n)^2+TP30(2,n)^2);
end
Ecc(1,1)=nan;
% SAPrgc
m = 0.054*1.34*Ecc+0.9;
b = (-1.5*(Ecc*1.32))-14.8;
for n =1:length(Ecc)
 gc(:,n) = (Raw30(:,n)-1-b(n))/m(n)+4.7;
end
SAPrgc = 10.^(gc*0.1);
SAPrgc2 = sum(SAPrgc,2,'omitnan');

%%



%%
% G = xlsread('30-2,10-2_20170606.xlsx');
G = readtable('30-2,10-2_20170606.xlsx','sheet','raw');
S = xlsread('30-2,10-2_20170606.xlsx','S');


TP10 = xlsread('TestPoint','10-2');
TP30 = xlsread('TestPoint','30-2');


