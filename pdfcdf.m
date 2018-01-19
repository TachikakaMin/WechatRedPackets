clear;
clc;
filename='WeChat Red Envelope Statistics.csv';
Data=csvread(filename,1,0);
% 1:quantity 2:sum 3:maxPosition
% 第一次数据偏差和其他的有些大
% tmp pdf tmp1 cdf tmp2 tot_pdf tmp3 avg_cdf 
X=0:0.01:0.30;
max=31;
pdfAvg=zeros(1,max);
cdf=zeros(1,max);
cdfAvg=zeros(1,max);
for i=2:32
    quantity=20;
    sum1=Data(i,2);
    tmp=zeros(1,20);
    tmp=Data(i,[4:(quantity+3)])/sum1;
    pdf=zeros(1,max);
    for j=1:20
        t=int8(tmp(j)*100);
        t=t+1;
        pdf(t)=pdf(t)+1;
    end;
    for j=1:max
        if (j==1) 
            cdf(j)=pdf(1);
        end;
        if (j>1)
            cdf(j)=cdf(j-1)+pdf(j);
        end;
    end;
    cdf=cdf/20;
    pdfAvg=pdfAvg+pdf;
    cdfAvg=cdfAvg+cdf;
    
%     p=polyfit(X,pdf,7);
%     x2 = 0:.0001:0.30;
%     y2 = polyval(p,x2);
%     plot(x2,y2);
%     grid on;
%     hold on;
%     plot(X,cdf,'o');
%     plot(X,cdf);

%     p=polyfit(X,cdf,7);
%     x2 = 0:.0001:0.30;
%     y2 = polyval(p,x2);
%     plot(x2,y2);
%     grid on;
%     hold on;
end;
% pdfAvg=pdfAvg/31;
% p=polyfit(X,pdfAvg,7);
% x2 = 0:.0001:0.30;
% y2 = polyval(p,x2);
% bar(X,pdfAvg);
% hold on;
% plot(X,pdfAvg,'o',x2,y2);

cdfAvg=cdfAvg/31;
p=polyfit(X,cdfAvg,7);
x2 = 0:.0001:0.30;
y2 = polyval(p,x2);
bar(X,cdfAvg);
hold on;
plot(X,cdfAvg,'o',x2,y2);
