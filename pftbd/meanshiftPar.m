%����Ⱥ���࣬������Ŀ���������������Ⱥ����
function[clustercenter, clustern,newxp,TarParNum,newE,newI]=meanshiftPar(xp,E)


newxp=[];%����������Ⱥ
newE=[];

data1=xp'; 
data=[data1(:,1) data1(:,3)];
% plot(data(:,1),data(:,2),'.')  
  
  
%mean shift �㷨  
[m ,n]=size(data);  
index=1:m;  

radius=5;  %Ѱ�ҵİ뾶
stopthresh=1e-3*radius;  %ֹͣѰ�ҵ���ֵ

visitflag=zeros(m,1);%����Ƿ񱻷���  
count=[];  
clustern=0;  %����ĸ���
clustercenter=[];  %���������
  

while length(index)>0  
    cn=ceil((length(index)-1e-6)*rand);%���ѡ��һ��δ����ǵĵ㣬��ΪԲ�ģ����о�ֵƯ�Ƶ���  
    center=data(index(cn),:);  
    this_class=zeros(m,1);%ͳ��Ư�ƹ����У�ÿ����ķ���Ƶ��  
      
      
    %����2��3��4��5  
    while 1  
        %������뾶�ڵĵ㼯  
        dis=sum((repmat(center,m,1)-data).^2,2);  
        radius2=radius*radius;  
        innerS=find(dis<radius*radius);  
        visitflag(innerS)=1;%�ھ�ֵƯ�ƹ����У���¼�Ѿ������ʹ��õ�  
        this_class(innerS)=this_class(innerS)+1;  
        %����Ư�ƹ�ʽ�������µ�Բ��λ��  
        newcenter=zeros(1,2);  
       % newcenter= mean(data(innerS,:),1);   
        sumweight=0;  
        for i=1:length(innerS)  
            w=exp(dis(innerS(i))/(radius*radius));  
            sumweight=w+sumweight;  
            newcenter=newcenter+w*data(innerS(i),:);  
        end  
        newcenter=newcenter./sumweight;  
  
        if norm(newcenter-center) <stopthresh%����Ư�ƾ��룬���Ư�ƾ���С����ֵ����ôֹͣƯ��  
            break;  
        end  
        center=newcenter;  
%         plot(center(1),center(2),'*y');  
    end  
    %����6 �ж��Ƿ���Ҫ�ϲ����������Ҫ�����Ӿ������1��  
    mergewith=0;  
    for i=1:clustern  
        betw=norm(center-clustercenter(i,:));  
        if betw<radius/2  
            mergewith=i;   
            break;  
        end  
    end  
    if mergewith==0           %����Ҫ�ϲ�  
        clustern=clustern+1;  
        clustercenter(clustern,:)=center;  
        count(:,clustern)=this_class;  
    else                      %�ϲ�  
        clustercenter(mergewith,:)=0.5*(clustercenter(mergewith,:)+center);  
        count(:,mergewith)=count(:,mergewith)+this_class;    
    end  
    %����ͳ��δ�����ʹ��ĵ�  
    index=find(visitflag==0);  
end%�����������ݵ����  
  
%��¼������  
for i=1:m  
    [value, index]=max(count(i,:));  
    Idx(i)=index;  
end
%������Ⱥ����
[newI ,indexId]=sort(Idx);
TarParNum=zeros(1,clustern);%ÿһ���е����Ӹ���

for i=1:m
    newxp=[newxp ;data1(indexId(i),:)];
    newE=[newE E(indexId(i))];
    for j=1:clustern
        if newI(i)==j
            TarParNum(j)=TarParNum(j)+1;
        end
    end
    
end
    



