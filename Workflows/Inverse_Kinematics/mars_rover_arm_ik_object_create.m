function [ks_mars_rover] = mars_rover_arm_ik_object_create(openClose)
% Create the inverse kinematics object for the rover arm.  
% Inverse kinematics object is used to determine required joint angles so
% that the drill can be used to drill samples on the terrain, gather
% samples into a storage container, and return the drill to the docked
% position.

% Copyright 2021-2024 The MathWorks, Inc

mdlname = 'mars_rover_arm';

% Create KinematicsSolver object for inverse kinematics.
load_system(mdlname);
ks_mars_rover = simscape.multibody.KinematicsSolver(mdlname);

% Add frame variables (end effector position, orientation, with respect to the arm base frame)
ks_mars_rover.addFrameVariables('Home','T',[mdlname '/Chassis/Arm_Base/F'],[mdlname ,'/Arm/End Effector/EndEffector/F']);
ks_mars_rover.addFrameVariables('Home','R',[mdlname '/Chassis/Arm_Base/F'],[mdlname ,'/Arm/End Effector/EndEffector/F']);

% Add target variables (end effector position and orientation)
ks_mars_rover.addTargetVariables([ks_mars_rover.frameVariables.ID]);

% Add initial guess variables (actuator positions)
rover_arm_jointsIDs = ["j1.Rz.q";"j2.Rz.q";"j3.Rz.q";"j4.Rz.q";"j5.Rz.q";"j6.Rz.q" ];
ks_mars_rover.addInitialGuessVariables(rover_arm_jointsIDs);

% Add output variables (actuator positions)
ks_mars_rover.addOutputVariables(rover_arm_jointsIDs);

if(strcmpi(openClose,'close'))
    close_system(mdlname);
end
