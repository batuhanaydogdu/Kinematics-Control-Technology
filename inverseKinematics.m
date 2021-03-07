L1= 0.27;   %the length of the first segment of the limb
L2= 0.36;   %the length of the second segment of the limb
L3= 0.27;   %the length of the third segment of the limb

Target = [0.4 ; 0.4]    %the coordinate of the target what has to be reach by the endpoint
J=zeros(2:3);           % the Jacobian Matrix will be stored in the array

plot(Target(1), Target(2),'r*')
drawnow 
hold on



    alfa1(1)=0;    %       The starting joint angle in the first joint
    alfa2(1)=(pi/4);    %  The starting joint angle in the second joint
    alfa3(1)=(pi/4);    %  The starting joint angle in the third joint
 
     
 
    
% the following part should be in for cycle for instance

    % Give the coordinates of the joints and the endpoint position (EP).
     Ex(1)=L1*cos(alfa1(1)); % x coordinate of the second joint (elbow) in the kth time step.
    Ey(1)=L1*sin(alfa1(1)); % y coordinate of the second joint (elbow) in the kth time step.
    
    Wx(1)=Ex(1)+L2*(cos(alfa1(1)+alfa2(1))); % x coordinate of the third joint (wrist) in the kth time step.
    Wy(1)=Ey(1)+L2*(sin(alfa1(1)+alfa2(1))); % y coordinate of the second joint (elbow) in the kth time step.
    
    EPx(1)=Wx(1)+L3*(cos(alfa1(1)+alfa2(1)+alfa3(1))); % x coordinate of the endpoint of the limb in the kth time step.
    EPy(1)=Wy(1)+L3*(sin(alfa1(1)+alfa2(1)+alfa3(1))); % y coordinate of the endpoint of the limb in the kth time step.
    
     EP=[EPx(1); EPx(1)]
    DeltaP=(Target-EP)/100  ; 
    
 for k=1:99
    Ex(k)=L1*cos(alfa1(k)); % x coordinate of the second joint (elbow) in the kth time step.
    Ey(k)=L1*sin(alfa1(k)); % y coordinate of the second joint (elbow) in the kth time step.
    
    Wx(k)=Ex(k)+L2*(cos(alfa1(k)+alfa2(k))); % x coordinate of the third joint (wrist) in the kth time step.
    Wy(k)=Ey(k)+L2*(sin(alfa1(k)+alfa2(k))); % y coordinate of the second joint (elbow) in the kth time step.
    
    EPx(k)=Wx(k)+L3*(cos(alfa1(k)+alfa2(k)+alfa3(k))); % x coordinate of the endpoint of the limb in the kth time step.
    EPy(k)=Wy(k)+L3*(sin(alfa1(k)+alfa2(k)+alfa3(k))); % y coordinate of the endpoint of the limb in the kth time step.
   
 
    % The next lines gives the starting Jacobian matrix
    
    J(1,1)=-L1*sin(alfa1(k))-L2*sin(alfa1(k)+alfa2(k))-L3*sin(alfa1(k)+alfa2(k)+alfa3(k));
        J(1,2)=-L2*sin(alfa1(k)+alfa2(k))-L3*sin(alfa1(k)+alfa2(1)+alfa3(k));
        J(1,3)=-L3*sin(alfa1(k)+alfa2(k)+alfa3(k));
        J(2,1)=L1*cos(alfa1(k))+L2*cos(alfa1(k)+alfa2(k))+L3*cos(alfa1(k)+alfa2(k)+alfa3(k));
        J(2,2)=L2*cos(alfa1(k)+alfa2(k))+L3*cos(alfa1(k)+alfa2(1)+alfa3(k));
        J(2,3)=L3*cos(alfa1(k)+alfa2(k)+alfa3(k));
        
    % The next lines give the change of the position of the endpoint of the limb in one unit of
    % time into the direction of the target

     
    
    % compute the required angular changes in the joints inborder to move
    % the endpoint of the limb into the direction of the target.
    
    DeltaAlfa=pinv(J)*DeltaP ;   %The planned discplacement of the endpoint of the limb (DeltaP) is multiplied by the pseudoinverse of the Jacobian
    disp("selam")
    disp(DeltaAlfa)
    
    % modify the actual joint angles by DeltaAlfa

        alfa1(k+1)=alfa1(k)+DeltaAlfa(1);    % updating the value of the joint angle alfa1
        alfa2(k+1)=alfa2(k)+DeltaAlfa(2);    % updating the value of the joint angle alfa2
        alfa3(k+1)=alfa3(k)+DeltaAlfa(3);    % updating the value of the joint angle alfa3

    % compute the modified coordinates of the joints.
   
    % compute the Jacobian with the modified joint angles
    
    
    

       
    plot([0 Ex(k) Wx(k) EPx(k)], [0 Ey(k) Wy(k) EPy(k)]) % plots the moving limb in the kth timestep.
    axis([-1 1 -1 1]); % range of the axis of the figure in which the =mkivement will be presented.
    % hold on % keeps the previous frame 
    %pause % it waits until a key is pressed in the keyboard
    drawnow 
end
% end of the cycle




 







