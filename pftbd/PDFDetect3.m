function [Pb,Detectxp,DetectE,Detectaxe,TarNum]=PDFDetect3(xp,E1,yuzhi,xmin,xmax,vxmin,vxmax,ymin,ymax,vymin,vymax,N,z_rdb11,LR1,ST,RT,Dr,Db,Dd,Nr,Nd,Amp,Lr,Lb,delta_n,r,d,b,Nb,Ld,F_cv,G,delta_v_p1)


%qqq=test(xp);
delL=2;
delV=0.1;
%���³���Ϊ��Ŀ��̽�����
TarNum=0;

    Pb=[];%Ŀ����ڸ���
    Detectxp=[];%��������Ⱥ
    DetectE=[];%����״̬
    Detectaxe=[];%Ŀ��λ��
[pb,newxp1,fE1,xe1]=PDFM2SingT(yuzhi,xmin,xmax,vxmin,vxmax,ymin,ymax,vymin,vymax,N,xp,E1,z_rdb11,LR1,ST,RT,Dr,Db,Dd,Nr,Nd,Amp,Lr,Lb,delta_n,r,d,b,Nb,Ld,F_cv,G,delta_v_p1);
% if pb>yuzhi%����Ŀ��
%     TarNum=1;
% end
if pb>yuzhi%����Ŀ��
   [clustercenter, clustern,newxp,TarParNum,newE,newI]=meanshiftPar(newxp1,fE1);%���ز����������Ⱥ��������Ŀ��
    newxp=newxp';
    TarNum=clustern;

    %��д��Ŀ������Ⱥ��Ŀ��λ��
  
    for i=1:clustern
        %ÿ������Ⱥ��ȫ���Ӹ�������Ŀ��״̬���й���
        sumNum=TarParNum(i);
        if i==1
            subxp=newxp(:,1:TarParNum(i));
            subE=newE(1:TarParNum(i));
        else
            subxp=newxp(:,sum(TarParNum(1,1:i-1))+1:sum(TarParNum(1,1:i)));
            subE=newE(sum(TarParNum(1,1:i-1))+1:sum(TarParNum(1,1:i)));
        end
        while sumNum<N%���Ӹ������ڹ涨��С
            %��ԭ����Ⱥ�������������
           a=randperm(TarParNum(i));
           newPar=subxp(:,a(1));
           newParE=subE(a(1));
           newPar(1)=newPar(1)+delL*rand;
           newPar(2)=newPar(2)+delV*rand;
           newPar(3)=newPar(3)+delL*rand;
           newPar(4)=newPar(4)+delV*rand;
           subxp=[subxp newPar];
           subE=[subE newParE];
           sumNum=sumNum+1;
        end
         subpb=0; 
         subaxe1=zeros(4,1);
        for j=1:N
         subpb=subpb+subE(j);
         subaxe1=subaxe1+subE(j)*subxp(:,j);
        end
        if subpb~=0;
           subaxe1=subaxe1/subpb;
        end
        subpb=subpb/N;
        %ÿ��Ŀ��������
        Pb=[Pb subpb];
        Detectxp=[Detectxp;subxp];
        DetectE=[DetectE subE];
        Detectaxe=[Detectaxe subaxe1];
    end
    
   %
else
    Detectxp=newxp1;
    DetectE=fE1;
    TarParNum=[];
    Pb=pb;
    
    
end

    xxxxx=1;
  