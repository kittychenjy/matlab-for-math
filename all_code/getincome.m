%司机回去拉客的收益计算函数
function [income] = getincome(a,a1,t)
now_hour=a;
now_min=a1;
total=t;
now_time=a+a1/60;
if now_hour>=4&&now_hour<=9
    flag=9-now_time;
    if flag>=t
        f1=(now_time-4)*3.2+1;
        f2=(now_time+t-4)*3.2+1;
        income=t*(f1+f2)/2;
    else
        f1=(now_time-4)*3.2+1;
        f2=(now_time+t-4)*3.2+1;
        f3=(t-flag)*17;
        income=t*(f1+f2)/2;
    end
end
 if now_hour>=9&&now_hour<=22
    flag=22-now_time;
    if flag>=t
        income=17*t;
    else
        f1=17*flag;
        f2=((t-flag-4)*3.2+1+17)*(t-flag)/2;
        income=f1+f2;
    end
end
   if now_hour>=22
       
       flag=24-now_time;
       xl=16/6;
       if flag>t
       f1=17-xl*(now_time-22);
       f2=17-xl*2;
       income=t*(f1+f2)/2;
       else
          f1=17-xl*(now_time-22);
          f2=17-xl*2; 
          f3=f2-xl*(t-flag);
          income=t*(f1+f3)/2;
       end
   end
   if now_hour<=4
       flag=4-now_time;
       xl=16/6;
       if flag>=t
           f1=17-xl*2;
           f2=f1-now_time*xl;
           f3=f1-(now_time+t)*xl;
           income=(f3+f2)*t;
       else
           f1=17-xl*2;
           f2=f1-now_time*xl;
           f3=f1-(now_time+t)*xl;
           f4=3.2*(t-flag)+1;
           income=(f3+f2)*flag+(1+f4)*(t-flag);
       end
    
   end

