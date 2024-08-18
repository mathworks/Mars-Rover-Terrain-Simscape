%% Mars Rover on Uneven Terrain
% 
% This example shows a six-wheeled autonomous vehicle driving on uneven
% terrain. The vehicle has a robotic arm that collects a sample from the
% ground and inserts it into a storage compartment onboard the vehicle.
% The powertrain can be modeled with ideal actuators or with an electrical
% network.
%
% See documentation for workflows shown in this example: 
% 
% # <matlab:web('mars_rover_workflow_grid_surface.html') Terrain
% Definition>
% # <matlab:web('mars_rover_workflow_point_cloud.html') Point
% Cloud>
% # <matlab:web('mars_rover_workflow_inverse_kinematics.html') Robot Arm Inverse Kinematics>  
% # <matlab:edit('mars_rover_terrain_path_following.mlx') Path Following>  
% 
% Copyright 2021-2024 The MathWorks, Inc.

%% Model

open_system('mars_rover_terrain')

set_param(find_system('mars_rover_terrain','FindAll','on','type','annotation','Tag','ModelFeatures'),'Interpreter','off');

%% Rover Subsystem

open_system('mars_rover_terrain/Rover','force')

%% Chassis Subsystem

open_system('mars_rover_terrain/Rover/Chassis','force')

%% Arm Subsystem

open_system('mars_rover_terrain/Rover/Arm','force')

%% Terrain Subsystem

open_system('mars_rover_terrain/Rover/Terrain','force')

%% Simulation Results from Simscape Logging: Path 1
%
% This shows the results for path 1 where the rover is driven with an ideal
% torque sources on uneven terrain.

set_param('mars_rover_terrain/Rover/Chassis/Powertrain','popup_powertrain','Ideal');
rover_path = rover_path1;
mars_terrain_set_z('uneven');
sim('mars_rover_terrain');
mars_rover_terrain_plot1_chassis_path
mars_rover_terrain_plot3_wheelspdtrq
mars_rover_terrain_plot2_arm_path(logsout_mars_rover_terrain)

%% Simulation Results from Simscape Logging: Path 2
%
% This shows the results for path 2 where the rover is driven with an ideal
% torque sources on uneven terrain.  The destination is the same but the
% rover approaches from a different side.  The terrain elevation and
% position at the sample is different from path 1.  The inverse kinematic
% algorithm uses the measured position of the sample relative to the rover
% to find joint angles that will permit the sample to be obtained.

rover_path = rover_path2;
mars_terrain_set_z('uneven');
set_param('mars_rover_terrain/Rover/Chassis/Powertrain','popup_powertrain','Ideal');
sim('mars_rover_terrain');
mars_rover_terrain_plot1_chassis_path
mars_rover_terrain_plot3_wheelspdtrq

%% Simulation Results from Simscape Logging: Path 2, Flat
%
% This shows the results for path 2 where the rover is driven with an ideal
% torque sources on flat terrain. To simplify the test, we put the rover on
% flat ground, but follow the same x-y trajectory as the previous test.  We
% can see the difference in wheel torques.

set_param('mars_rover_terrain/Rover/Chassis/Powertrain','popup_powertrain','Ideal');
rover_path = rover_path2;
mars_terrain_set_z('flat');
sim('mars_rover_terrain');
mars_rover_terrain_plot1_chassis_path
mars_rover_terrain_plot3_wheelspdtrq
mars_rover_terrain_plot2_arm_path(logsout_mars_rover_terrain)

%% Simulation Results from Simscape Logging: Path 2 Electrical
%
% The model is configured to model the electrical system of the powertrain,
% including 6 motors for propulsion and 4 motors for steering. The results
% of the simulation include the current drawn by the motors as it follows
% path 2.

set_param('mars_rover_terrain/Rover/Chassis/Powertrain','popup_powertrain','Electrical');
open_system('mars_rover_terrain/Rover/Chassis/Powertrain/Electrical/Drive','force')
rover_path = rover_path2;
mars_terrain_set_z('uneven');
sim('mars_rover_terrain');
mars_rover_terrain_plot1_chassis_path
mars_rover_terrain_plot4_motorspdcurr
mars_rover_terrain_plot2_arm_path(logsout_mars_rover_terrain)

%%

%clear all
close all
bdclose all