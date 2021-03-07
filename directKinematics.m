L1= 0.27;   % length of the first limb segment
L2= 0.36;   % length of the second limb segment
L3= 0.27;   % length of the third limb segments

alfa1(1)=0;  % the starting angle of the first segment respect to the horizpntal line
alfa2(1)=0;  %% the starting angle of the second segment respect to the first segment
alfa3(1)=0;  %% the starting angle of the third segment respect to the second segment
               

for i=1:100
    alfa1(i)=cos(pi*(-((i/100)-0.5)^2+0.25));    % this function gives the first joint as it is changing in time (in 100 time steps)
    alfa2(i)=sin(i*(pi/9)^4/100);    % this function gives the first joint as it is changing in time (in 100 time steps);
    alfa3(i)=sin(i*(pi/6)/100);    % this function gives the first joint as it is changing in time (in 100 time steps)
end

    
for k=1:100
    Ex(k)=L1*cos(alfa1(k)); % x coordinate of the second joint (elbow) in the kth time step.
    Ey(k)=L1*sin(alfa1(k)); % y coordinate of the second joint (elbow) in the kth time step.
    
    Wx(k)=Ex(k)+L2*(cos(alfa1(k)+alfa2(k))); % x coordinate of the third joint (wrist) in the kth time step.
    Wy(k)=Ey(k)+L2*(sin(alfa1(k)+alfa2(k))); % y coordinate of the second joint (elbow) in the kth time step.
    
    EPx(k)=Wx(k)+L3*(cos(alfa1(k)+alfa2(k)+alfa3(k))); % x coordinate of the endpoint of the limb.
    EPy(k)=Wy(k)+L3*(sin(alfa1(k)+alfa2(k)+alfa3(k))); % y coordinate of the endpoint of the limb.
end

for k=1:100
    plot([0 Ex(k) Wx(k) EPx(k)], [0 Ey(k) Wy(k) EPy(k)]) % plots the moving limb in the kth timestep.
    axis([-1 1 -1 1]); % range of the axis of the figure in which the =mkivement will be presented.
    %hold on % keeps the previous frame 
    %pause % it waits until a key is pressed in the keyboard
    drawnow
end