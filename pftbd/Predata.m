function [RT1 ,intervalN1, lengthRR1, detT1 ,x1, ST]=Predata(steps,Oinix,t_appear,t_disappear,T,DRbegin1,LR1,F_cv,G,delta_v)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
inix1=Oinix;
inix1(1)=Oinix(1)-LR1(1);%Ŀ��λ������״�λ�õ�У��
inix1(3)=Oinix(3)-LR1(2);
intervalN1=[];
for k=1:steps
    RT1(k)=DRbegin1+(k-1)*T;%R1-���ս��[0. 1 ...29]
    if RT1(k)>=t_appear&&RT1(k)<=t_disappear
        intervalN1=[intervalN1 k];%R1-���ս��[  3 4... 21]
    end
    
    
    
    ST(k)= (k-1)*T;%R1-���ս��[0 1 2... 29]
end
lengthRR1=size(intervalN1);%R1-�������[1 15]
% for k=t_appear:t_disappear % nearly constant velocity
%     x(:,k+1)=F_cv*x(:,k)+G*delta_v*randn(2,1);
% end
detT1=RT1(intervalN1(1))-t_appear;%R1-�������0.2

x1(:,intervalN1(1))=inix1;
x1(1,intervalN1(1))=inix1(1)+inix1(2)*detT1;
x1(3,intervalN1(1))=inix1(3)+inix1(4)*detT1;




for k=intervalN1(1):intervalN1(lengthRR1(2)) % nearly constant velocity
    x1(:,k+1)=F_cv*x1(:,k)+G*delta_v*randn(2,1);%x=[0 0 0 0 0 x6 ...x21]
end




