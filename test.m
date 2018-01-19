clc;
clear;
filename='WeChat Red Envelope Statistics.csv';
Data=csvread(filename,1,0);
% 1:quantity 2:sum 3:maxPosition
% 第一次数据偏差和其他的有些大
% tmp pdf tmp1 cdf tmp2 tot_pdf tmp3 avg_cdf 
tmp2=zeros(35,20);
tmp3=zeros(1,20);
varEachExample=zeros(31,1);
varEachPosition=zeros(1,20);
for i=2:32
    quantity=Data(i,1);
    sum1=Data(i,2);
    tmp=zeros(1,quantity);
    tmp1=zeros(1,quantity);
    tmp=Data(i,[4:(quantity+3)])/sum1;
    varEachExample(i-1,1)=var(tmp);
    tmp1(1)=tmp(1);
    for j=2:quantity
        tmp1(j)=tmp(j)+tmp1(j-1);
    end;
    tmp2(i-1,:)=tmp;
    tmp3=tmp3+tmp1;
%     hold on;
%     plot(abs(tmp-0.05));
end
for i=1:20
    A=Data(:,3+i);
    tmp=A'/sum1;
    varEachPosition(i)=var(tmp);
end;
plot(varEachPosition);
% tmp3=tmp3/31.0;
% plot(tmp3);
