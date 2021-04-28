% This computer program is a sample for a control method applied in
% Human-Machine interface studies
% The method is based on Principal Component Analysis (PCA)

M = xlsread('MaLi19_kinematic_rsh2');   % read data from a file which contains time series of sensory data

MM = [M(2:3000,2:25)];                  % MM is our data matrix  what we will use and we will computes the covariance matrix of MM

CovMM=cov(MM);                          % CovMM is the covaraince matrix of MM, this is a symmetric matrix and 
                                        % the number of coloumns (rows)  is equal to the numeber of columns of MM
                                        
[V,D]=eigs(CovMM,2)                     % compute the 2 largest eignevalue of CovMM and the 2 eigenvectors which belong to the 2 largest eigenvectors.

PM=V(:,1:2)                             % PM is a transformation matrix, this will be used 
                                        % for transformation from the
                                        % (24-dimensional) "sensory space"to the 2-dimensional workspace.
[VV,DD]=eigs(CovMM,24);                  % VV contains all the eigenvectors, DD contains in its diagonal  all the 24 eigenvectors.                                      % 
Sumtwo=trace(D);
Sumall=trace(DD);
 ratio= Sumtwo/Sumall
 
S = xlsread('MaLi19_kinematic_rsh1');   % read the input file that simulates the online measurement
Sensory = [S(2:3000,2:25)];      

for t=1:3000                            % read the 24 -dimensional vectors which are coming from the sensors
                                        % at each time step (t). 
                                        % (Now the these vectors are not coming online from the sensors but they 
                                        % can be read from the given file
                                        % reading the rows of that file
                                        % after  each other
    C(t,:)=Sensory(t,:)*PM;                 % Transforms the input signal into command signal at time t. 
    plot(C(t,1),C(t,2),'.','Markersize',5);    % plots the moving point on the screen at time t
    axis([-1000 1000 -1500 -500]);
    hold on
    drawnow 
end