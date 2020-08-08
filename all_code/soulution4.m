%根据前面的模型可知，当出租车的拉客的平均距离为36.6公里。且距离为正态分布，设当拉客距离为[0,22.1]时认为车辆拉客距离较短，此时
%在下次排队时需要给于该出租车一定的优先权，且此时，根据正态分布的假设，需要插队的车辆仅有5%，可以认为插队车辆对原车流没有影响。
%当航班在10点-18点时分布较为均匀，以此时新郑机场得数据为例。
%% %随机生成 0-22.1公里的距离 然后按照插队模型插队,根据计算得司机平均单位时间收益为14.8元。
for p=1:5
times=200;
for k=1:times
 %% %假设第一次排队，排到了比较近的距离
dis=rand(1,1)*22.1;
[income,cost_time,tx,tx_time]=sortcar(dis);%模拟一次排队，封装的函数
pincome=income/cost_time;
shld_time=income/14.8;
s_time=cost_time-shld_time;
s_tx=floor(tx*(s_time/tx_time));
% disp(pincome);         %得出收益
% disp(cost_time);      %得出时间
% disp(s_time);      %得出应该排队减少得时间
% disp(s_tx);      %得出应该少排多少量车
dis_total(k,1)=dis;
stime_total(k,1)=s_time;
%% %第二次排队
dis=normrnd(36.6,9) ;   %随机生成正态分布的距离
[agincome,agcost_time,agtx,agtx_time]=sortcar(dis);%模拟二次排队，封装的函数
agcost_time=agcost_time-agtx_time*(s_tx/agtx);
agpincome=agincome/cost_time;
% disp(agpincome);           %显示第二次的收益
total_tx(1,k)=agtx-s_tx;
total_agtx(k,1)=agtx;
income_end=(income+agincome)/(cost_time+agcost_time);
total_endincome(k,1)=income_end;
end
%% 转换结果 将负值转化为0
fb=total_tx;
for i=1:times
    if fb(1,i)<0
        fb(1,i)=0;
    end
end
fb=fb';
total_data(1:times,1)=fb;
total_data(1:times,2)=dis_total;
total_data(1:times,3)=stime_total;
total_data(1:times,4)=total_agtx;
get1(p,1)=sum(total_endincome)/times;
end
%%



































