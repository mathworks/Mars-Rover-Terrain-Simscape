function [out,solutionFlag] =  sm_mars_rover_arm_ik(eePose,eeIgs)
% Uses a persistent KinematicsSolver object to compute the inverse
% kinematics of the rover arm.  Specifically, given the position and
% orientation of the end effector, it computes the corresponding actuator
% positions. It also uses initial guesses to guide the solver to the
% desired solution.

% Copyright 2021-2024 The MathWorks, Inc

persistent ks_mars_rover;

if isempty(ks_mars_rover)
    % Note that this code is only run first time this function is called or
    % if this function is cleared from memory.
    ks_mars_rover = mars_rover_arm_ik_object_create('close');
end

% Solve for multiple end effector targets
for i = 1:size(eePose,1)
    if i ==4
        [out(i,:),status,~,~] = ks_mars_rover.solve(eePose(i,:),out(i-1,:));
    else
        [out(i,:),status,~,~] = ks_mars_rover.solve(eePose(i,:),eeIgs(i,:));
    end
    if status~=1
        error(['Inverse kinematic solution not found'])
    end
end

solutionFlag = status;

end