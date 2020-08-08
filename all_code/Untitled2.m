clear

dis_d=zeros(1,50);

for i=1:50
dis=normrnd(36.6,9) ;   %随机生成正态分布的距离
dis_d(1,i)=dis;
end
plot(1:50,dis_d)
