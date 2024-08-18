% Define end effector targets
% Copyright 2021-2024 The MathWorks, Inc.

% Each row of the matrix specifies the target position and orientation of
% the frame at the tip of the robot (end effector) relative to the base of
% the arm on the rover chassis.
%
% The target is expressed as a six element vector:
%    First three elements are translation [x y z]
%    Second three elements are xyz intrinsic rotation sequence 
%      (rotations applied to x, y, and z axes as they are oriented
%       after each elemental rotation).

matrix_wayp_tgts = [...
    0.1000    0.3800    0.4951        0         0      0;        % Home
    0.1000    0.3800    0.6500       10.0000    0      0;        % Undock
   -0.4284   -1.1828   -0.9289-0.1  175.0000    0     91.0000;   % Above Sample (1:3 to be overwritten)
   -0.4284   -1.1828   -0.9289      175.0000    0     91.0000;   % At Sample (1:3 to be overwritten)
   -0.4284         0    0.1259      270.0000    0     90.0000;   % Approach storage
   -0.4284    0.1500    0.1259      270.0000    0     90.0000;   % At storage
    0.1000    0.3800    0.8500       10.0000    0      0];       % Pre-Home

wayPNames = {
    'Home', 'Undock', 'Sample', 'Approach', ...
    'Prepare', 'Storage', 'Return'};
X = matrix_wayp_tgts(:,1);
Y = matrix_wayp_tgts(:,2);
Z = matrix_wayp_tgts(:,3);
alpha = matrix_wayp_tgts(:,4);
beta = matrix_wayp_tgts(:,5);
gamma = matrix_wayp_tgts(:,6);

eeConfig.Targets=table(X,Y,Z,alpha,beta,gamma);
eeConfig.Targets.Properties.RowNames = wayPNames';
%disp(eeConfig.Targets)


% Define initial guess for joint space for each waypoint
% of the frame at the tip of the robot (end effector)
% There are 6 angles in each guess, one for each joint in the arm 
init_guess_tgts      = [ ...
         0 -145.0000   40.0000 -180.0000  180.0000  180.0000;
         0 -145.0000   40.0000 -180.0000  180.0000  180.0000;
   90.0000 -200.0000   90.0000   40.0000  170.0000  -10.0000;
   90.0000 -200.0000   90.0000   40.0000  170.0000  -10.0000;
   66.5561 -185.9232   38.5939  -44.5170  156.5561   90.0000;
   66.5561 -185.9232   38.5939  -44.5170  156.5561   90.0000;
         0 -145.0000   40.0000 -180.0000  180.0000  180.0000];

q1 = init_guess_tgts(:,1);
q2 = init_guess_tgts(:,2);
q3 = init_guess_tgts(:,3);
q4 = init_guess_tgts(:,4);
q5 = init_guess_tgts(:,5);
q6 = init_guess_tgts(:,6);

eeConfig.Joint_IG = table(q1,q2,q3,q4,q5,q6);
eeConfig.Joint_IG.Properties.RowNames = wayPNames';
%disp(eeConfig.Joint_IG)
