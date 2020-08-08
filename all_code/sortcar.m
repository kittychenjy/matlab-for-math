function [ income,total_time,now_num_tx ,tt_time] = sortcar( dis )

%% %导入爬取得数据
load data_time
load data_taxi


%% %初始化数据

[m,~]=size(data_time); %计算航班数
pl=randi([100,180],1,m); %随机生成一组数据，每个航班的乘客数
pl_flag=1;    
tx_flag=1;
pl_sum=zeros(24,60); %每个时间段的人数变化
plane=data_time;  %飞机的航班数据
num_pl=0;      %初始化站台上剩余人数
pl_num=zeros(1,m); %记录每分钟站台上剩余人数
num_take=0 ;%初始化离开的车辆数
num_tpl=10;
num_wait=0;
taxi=data_taxi;
decih=randi([10,18],1,500);
decim=randi([1,59],1,500);
all_data=zeros(500,5);
income_total=zeros(500,1);
de_flag=0;
now_num_tx=nan;
now_num_pl=0;
now_num_take=0;
%begin_time=0;
k=1;
for i=1:23
    for j=1:60
        %%模拟登机
        if ismember(i*100+j,plane)
            num_pl=num_pl+pl(1,pl_flag);
            pl_num(1,pl_flag)=floor(pl(pl_flag)*0.08);% 假定在地铁工作时间内，乘坐公交车的人数有1%
            num_tpl=num_tpl+ pl_num(1,pl_flag);
            pl_flag=pl_flag+1;
        end
        %%
        %模拟停车场剩余车辆
        if ismember(i*100+j,taxi(:,1))
            num_tx=taxi(tx_flag,2);
            tx_flag=tx_flag+1;            
        end
        %%
        %模拟接客
        if num_tpl>0
           pl_take=randi([2,3]);% 设定每分钟有1名或者5名乘客被劫走
           num_tpl=num_tpl-pl_take;
           if num_tpl<0
               num_tpl=0;
           end
           num_take=num_take+1;
        else
            num_wait=num_wait+1;
        end
         pl_sum(i,j)=num_tpl;
         tx_sum(i,j)=num_tx;
         %% %模拟司机决策
         
         if i==decih(1,k)&&decim(1,k)==j   %假定某一时刻司机到达
             now_num_tx=num_tx;
             now_num_pl=num_pl;
             now_num_take=num_take;
             begin_time=100*i+j;
             begin_timeg=[i,j];
             end_time=0;
             de_flag=1;
         end
         if num_take-now_num_take==now_num_tx&& de_flag==1   %计算排序可能花费的时间
             end_time=100*i+j;
             end_timeg=[i,j];
             cost_time=begin_time-end_time;
             cost_timeg=end_timeg- begin_timeg;
             de_flag=0;
         end
        
    end
end
%% 
pl_flag=1;    
tx_flag=1;
for i=1:23
    for j=1:60
        %%模拟登机
        if ismember(i*100+j,plane)
            num_pl=num_pl+pl(1,pl_flag);
            pl_num(1,pl_flag)=floor(pl(pl_flag)*0.08);% 假定在地铁工作时间内，乘坐公交车的人数有1%
            num_tpl=num_tpl+ pl_num(1,pl_flag);
            pl_flag=pl_flag+1;
        end
        %%
        %模拟停车场剩余车辆
        if ismember(i*100+j,taxi(:,1))
            num_tx=taxi(tx_flag,2);
            tx_flag=tx_flag+1;            
        end
        %%
        %模拟接客
        if num_tpl>0
           pl_take=randi([2,3]);% 设定每分钟有1名或者5名乘客被劫走
           num_tpl=num_tpl-pl_take;
           if num_tpl<0
               num_tpl=0;
           end
           num_take=num_take+1;
        else
            num_wait=num_wait+1;
        end
         pl_sum(i,j)=num_tpl;
         tx_sum(i,j)=num_tx;
         if num_take-now_num_take==now_num_tx&& de_flag==1   %计算排序可能花费的时间
             end_time=100*i+j;
             end_timeg=[i,j];
             cost_time=begin_time-end_time;
             cost_timeg=end_timeg- begin_timeg;
             de_flag=0;
         end
        
    end
end

 st_pri=6;
 pri=1.5;
 back_pri=0.5;
 oil_pri=0.5;
 dis_line=2;
 speed=53;     %根据百度地图导航生成的速度
 if dis<12
     income=(dis-dis_line)*pri+st_pri-oil_pri*dis;
 else 
     income=((dis-dis_line)*pri+st_pri)*(1+back_pri)-oil_pri*dis;
 end
 time=dis/speed;
 total_time=cost_timeg(1,1)+cost_timeg(1,2)/60+time;
 tt_time=cost_timeg(1,1)+cost_timeg(1,2)/60;
 per_income= income/ total_time;



end

