%����ǰ���ģ�Ϳ�֪�������⳵�����͵�ƽ������Ϊ36.6����Ҿ���Ϊ��̬�ֲ����赱���;���Ϊ[0,22.1]ʱ��Ϊ�������;���϶̣���ʱ
%���´��Ŷ�ʱ��Ҫ���ڸó��⳵һ��������Ȩ���Ҵ�ʱ��������̬�ֲ��ļ��裬��Ҫ��ӵĳ�������5%��������Ϊ��ӳ�����ԭ����û��Ӱ�졣
%��������10��-18��ʱ�ֲ���Ϊ���ȣ��Դ�ʱ��֣����������Ϊ����
%% %������� 0-22.1����ľ��� Ȼ���ղ��ģ�Ͳ��,���ݼ����˾��ƽ����λʱ������Ϊ14.8Ԫ��
for p=1:5
times=200;
for k=1:times
 %% %�����һ���Ŷӣ��ŵ��˱ȽϽ��ľ���
dis=rand(1,1)*22.1;
[income,cost_time,tx,tx_time]=sortcar(dis);%ģ��һ���Ŷӣ���װ�ĺ���
pincome=income/cost_time;
shld_time=income/14.8;
s_time=cost_time-shld_time;
s_tx=floor(tx*(s_time/tx_time));
% disp(pincome);         %�ó�����
% disp(cost_time);      %�ó�ʱ��
% disp(s_time);      %�ó�Ӧ���ŶӼ��ٵ�ʱ��
% disp(s_tx);      %�ó�Ӧ�����Ŷ�������
dis_total(k,1)=dis;
stime_total(k,1)=s_time;
%% %�ڶ����Ŷ�
dis=normrnd(36.6,9) ;   %���������̬�ֲ��ľ���
[agincome,agcost_time,agtx,agtx_time]=sortcar(dis);%ģ������Ŷӣ���װ�ĺ���
agcost_time=agcost_time-agtx_time*(s_tx/agtx);
agpincome=agincome/cost_time;
% disp(agpincome);           %��ʾ�ڶ��ε�����
total_tx(1,k)=agtx-s_tx;
total_agtx(k,1)=agtx;
income_end=(income+agincome)/(cost_time+agcost_time);
total_endincome(k,1)=income_end;
end
%% ת����� ����ֵת��Ϊ0
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



































