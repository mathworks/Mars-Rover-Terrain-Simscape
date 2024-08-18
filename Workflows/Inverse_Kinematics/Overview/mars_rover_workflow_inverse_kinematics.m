%% Planning Trajectory for Rover Arm: Inverse Kinematics
% 
% This example shows how to obtain the joint angles that will enable the
% end effector of the rover manipulator to pass through specific x-y-z
% coordinates with a specific orientation.  The inverse kinematics object
% used for the analysis is obtained from a test harness model,
% <matlab:open_system('mars_rover_arm') mars_rover_arm>, which can be used
% to test the resulting trajectory.
% 
% Return to main example <matlab:web('mars_rover_terrain.html');
% mars_rover_terrain>
%
% Copyright 2021-2024 The MathWorks, Inc


%% Open the Test Harness Model
%
% Open <matlab:open_system('mars_rover_arm') mars_rover_arm.slx>.

open_system('mars_rover_arm');

%% 
% This subsystem shows the parts and the joints that connect them.  These
% joints will be referenced in the inverse kinematics object.

open_system('mars_rover_arm/Arm','force');

%% Define Waypoints for the Robot Arm
%
% The tip of the drill at the of the robot arm must pass through predefined
% waypoints in order to collect the sample and place it in the storage
% container on the rover. The waypoints are defined by the position and
% orientation of the rigid body frame at the tip of the drill. Six
% numerical values are used to define the waypoint: 
% 
% * x, y, and z position relative to the rigid body frame at the arm base
% * alpha, beta, and gamma angles that define an intrinsic X-Y-Z rotation
% relative to the rigid body frame at the arm base
%
% A <matlab:web(fullfile(docroot,'matlab/matlab_prog/create-a-table.html')) MATLAB table> is used to
% define the waypoints so that it is clear what the numerical values
% represent.  To see the code that defines the MATLAB table, open the
% script <matlab:edit('mars_rover_arm_task_space.m')
% mars_rover_arm_task_space.m>

disp(eeConfig.Targets)


%% Generate Inverse Kinematics Object
%
% The inverse kinematic analysis is performed using
% <matlab:web(fullfile(docroot,'physmod/sm/ref/simscape.multibody.kinematicssolver.html'))
% kinematicsSolver object>. The kinematicsSolver object is created using a
% Simscape Multibody model, in this case mars_rover_arm. You add the
% known and unknown kinematic variables in the object and use the
% <matlab:web(fullfile(docroot,'physmod/sm/ref/simscape.multibody.kinematicssolver.solve.html'))
% solve> object function to obtain the values of the unknown kinematic
% variables.  
%
% Open <matlab:edit('mars_rover_arm_ik_object_create.m')
% mars_rover_arm_ik_object_create> to see the code that defines the
% kinematicsSolver object ks_mars_rover.
%
% In the case of our robot arm, we know the waypoints the drill tip must
% reach, and need to determine the joint angles.  We create the
% kinematicsSolver object by defining frameVariables for the waypoint
% locations. 
% 

ks_mars_rover.frameVariables.ID

%%
% The joint angles are added as output variables, and will be
% the result of the kinematics analysis.  

ks_mars_rover.jointPositionVariables.BlockPath

%%
% To guide the solver to a desirable solution (especially important if
% there are multiple solutions), we add initial guess values where we can
% specify the starting point for finding the solution. The initial guess is
% stored in MATLAB table eeConfig.Joint_IG

disp(eeConfig.Joint_IG)


%% Perform IK Analysis to Obtain Joint Angles
%
% An inverse kinematics analysis is performed using the
% <matlab:web(fullfile(docroot,'physmod/sm/ref/simscape.multibody.kinematicssolver.solve.html'))
% solve> object function to obtain the joint angles that enable the drill
% tip to pass through the waypoints at the desired orientation.  See
% <matlab:edit('mars_rover_arm_test_joint_space.m')
% mars_rover_arm_test_joint_space.m> to look at the code that performs this
% analysis.
%
% The screenshots below show the arm in the position defined by the
% solution that comes from the IK analysis at each waypoint.  It is
% displayed using the command
% <matlab:web(fullfile(docroot,'physmod/sm/ref/viewsolution.html'))
% viewSolution>.

mars_rover_arm_test_joint_space
arm_joint_traj_final = arm_joint_traj;
bdclose('mars_rover_arm')

%%
% *Arm at "Home" Waypoint*
%
% <<mars_rover_arm_IK_viewSolution_1.png>>

%%
% *Arm at "Undock" Waypoint*
%
% <<mars_rover_arm_IK_viewSolution_2.png>>

%%
% *Arm at "Sample" Waypoint*
%
% <<mars_rover_arm_IK_viewSolution_3.png>>

%%
% *Arm at "Approach" Waypoint*
%
% <<mars_rover_arm_IK_viewSolution_4.png>>

%%
% *Arm at "Prepare" Waypoint*
%
% <<mars_rover_arm_IK_viewSolution_5.png>>

%%
% *Arm at "Storage" Waypoint*
%
% <<mars_rover_arm_IK_viewSolution_6.png>>

%%
% *Arm at "Return" Waypoint*
%
% <<mars_rover_arm_IK_viewSolution_7.png>>

%% Test Model with Joint Angles Obtained from Inverse Kinematic Analysis
% 
% We can test the result of our inverse kinematic analysis by using the
% joint angles as the command to our control system.  A PID controller
% attempts to track those joint angles and maneuver the arm to each
% waypoint.
%
% *Plot of the drill tip trajectory*

load_system('mars_rover_arm')
arm_joint_traj = arm_joint_traj_final;
sim('mars_rover_arm')
mars_rover_terrain_plot2_arm_path(logsout_mars_rover_arm)

%%
%
% *Plot of joint angles versus time*
mars_rover_terrain_plot5_armangles(logsout_mars_rover_arm)

%%
close all
bdclose('mars_rover_arm')