 %% %价格
 st_pri=6;
 pri=1.5;
 back_pri=0.5;
 oil_pri=0.5;
 dis_line=2;
data=zeros(0,0);
%%
for i=1:10000

dis=normrnd(36.6,9) ;   %随机生成正态分布的距离

if dis<12
     income=(dis-dis_line)*pri+st_pri-oil_pri*dis;
 else 
     income=((dis-dis_line)*pri+st_pri)*(1+back_pri)-oil_pri*dis;
end
%  disp(income);
 data(end+1,1)=income;
end
sum(data)/10000