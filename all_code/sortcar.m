function [ income,total_time,now_num_tx ,tt_time] = sortcar( dis )

%% %������ȡ������
load data_time
load data_taxi


%% %��ʼ������

[m,~]=size(data_time); %���㺽����
pl=randi([100,180],1,m); %�������һ�����ݣ�ÿ������ĳ˿���
pl_flag=1;    
tx_flag=1;
pl_sum=zeros(24,60); %ÿ��ʱ��ε������仯
plane=data_time;  %�ɻ��ĺ�������
num_pl=0;      %��ʼ��վ̨��ʣ������
pl_num=zeros(1,m); %��¼ÿ����վ̨��ʣ������
num_take=0 ;%��ʼ���뿪�ĳ�����
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
        %%ģ��ǻ�
        if ismember(i*100+j,plane)
            num_pl=num_pl+pl(1,pl_flag);
            pl_num(1,pl_flag)=floor(pl(pl_flag)*0.08);% �ٶ��ڵ�������ʱ���ڣ�������������������1%
            num_tpl=num_tpl+ pl_num(1,pl_flag);
            pl_flag=pl_flag+1;
        end
        %%
        %ģ��ͣ����ʣ�೵��
        if ismember(i*100+j,taxi(:,1))
            num_tx=taxi(tx_flag,2);
            tx_flag=tx_flag+1;            
        end
        %%
        %ģ��ӿ�
        if num_tpl>0
           pl_take=randi([2,3]);% �趨ÿ������1������5���˿ͱ�����
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
         %% %ģ��˾������
         
         if i==decih(1,k)&&decim(1,k)==j   %�ٶ�ĳһʱ��˾������
             now_num_tx=num_tx;
             now_num_pl=num_pl;
             now_num_take=num_take;
             begin_time=100*i+j;
             begin_timeg=[i,j];
             end_time=0;
             de_flag=1;
         end
         if num_take-now_num_take==now_num_tx&& de_flag==1   %����������ܻ��ѵ�ʱ��
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
        %%ģ��ǻ�
        if ismember(i*100+j,plane)
            num_pl=num_pl+pl(1,pl_flag);
            pl_num(1,pl_flag)=floor(pl(pl_flag)*0.08);% �ٶ��ڵ�������ʱ���ڣ�������������������1%
            num_tpl=num_tpl+ pl_num(1,pl_flag);
            pl_flag=pl_flag+1;
        end
        %%
        %ģ��ͣ����ʣ�೵��
        if ismember(i*100+j,taxi(:,1))
            num_tx=taxi(tx_flag,2);
            tx_flag=tx_flag+1;            
        end
        %%
        %ģ��ӿ�
        if num_tpl>0
           pl_take=randi([2,3]);% �趨ÿ������1������5���˿ͱ�����
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
         if num_take-now_num_take==now_num_tx&& de_flag==1   %����������ܻ��ѵ�ʱ��
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
 speed=53;     %���ݰٶȵ�ͼ�������ɵ��ٶ�
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

