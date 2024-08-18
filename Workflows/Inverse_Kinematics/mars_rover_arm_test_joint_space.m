% Script to obtain arm joint angles for 
% desired end effector positions and orientations.

% Copyright 2021-2024 The MathWorks, Inc.

% Load model of arm and obtain inverse kinematics object
[ks_mars_rover] = mars_rover_arm_ik_object_create('open');

% Open model 
open_system('mars_rover_arm')

% Visualize IK solution for each end effector waypoint
for i = 1:size(eeConfig.Targets,1)
    if i ==4
        [ik_soln(i,:),status,~,~] = ks_mars_rover.solve(eeConfig.Targets{i,:},ik_soln(i-1,:));
    else
        [ik_soln(i,:),status,~,~] = ks_mars_rover.solve(eeConfig.Targets{i,:},eeConfig.Joint_IG{i,:});
    end
    if status~=1
        error(['Inverse kinematic solution not found'])
    end
    viewSolution(ks_mars_rover);
    
    CreateStruct.Interpreter = 'tex';
    CreateStruct.WindowStyle = 'replace';
    msgfig = msgbox({['\fontsize{14}IK solution found for waypoint ' num2str(i) ' of ' num2str(size(eeConfig.Targets,1)) '.'], 'Press OK to continue, or wait 3 seconds.'},'Solution Obtained',CreateStruct);
    uiwait(msgfig,3)
end

if(isvalid(msgfig))
    close(msgfig);
end

% Map IK solution to sequential waypoints in the trajectory
arm_joint_traj(1,:)  = ik_soln(1,:); % Home
arm_joint_traj(2,:)  = ik_soln(2,:); % Undock
arm_joint_traj(3,:)  = ik_soln(4,:); % Approach
arm_joint_traj(4,:)  = ik_soln(3,:); % Drill
arm_joint_traj(5,:)  = ik_soln(4,:); % Approach
arm_joint_traj(6,:)  = ik_soln(5,:); % Prepare
arm_joint_traj(7,:)  = ik_soln(6,:); % Storage
arm_joint_traj(8,:)  = ik_soln(5,:); % Prepare
arm_joint_traj(9,:)  = ik_soln(7,:); % Return
arm_joint_traj(10,:) = ik_soln(1,:); % Home

% Initial arm angle - uncomment to update workspace variable 
% new initial position based on IK analysis
% arm_q0 = ik_soln(1,:);

