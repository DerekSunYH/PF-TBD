function z=computT(x,intervalN)
%���ݹ켣������ά
%   �˴���ʾ��ϸ˵��
z(1,intervalN)=sqrt(x(1,intervalN).^2+x(3,intervalN).^2); % z1=range between target and sensor, sensor is located in the origin
z(2,intervalN)=(x(1,intervalN).*x(2,intervalN)+x(3,intervalN).*x(4,intervalN))./z(1,intervalN); % z2=doppler,  note!!!: there is a jump in doppler measure
z(3,intervalN)=atan(x(1,intervalN)./x(3,intervalN)); % z3=bearing, from North (positive Y axis) to the trajectory 
cc=1;

end

