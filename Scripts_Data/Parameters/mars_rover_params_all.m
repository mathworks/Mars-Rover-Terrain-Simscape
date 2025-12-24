%% Script to setup parameters for the sm_mars_rover model 

% Copyright 2021-2025 The MathWorks, Inc

%% Mars Rover Params
mars_rover_params_chassis; 
mars_rover_params_arm;

%% Terrain data
mars_terrain_grid = stl_to_gridsurface('mars_terrain.stl',100,100,'n');

%% Sample Position
sample_position = [72.3000   30.4729    0]; 
sample_position(3) = interp2(mars_terrain_grid.xg,mars_terrain_grid.yg,mars_terrain_grid.z_heights',sample_position(1),sample_position(2));

%% Rover Path Planning and Control Params
load mars_rover_chassis_target_path.mat
rover_path1.z = interp2(mars_terrain_grid.xg,mars_terrain_grid.yg,mars_terrain_grid.z_heights',rover_path1.x,rover_path1.y);
rover_path1.Offset_vis_z = 0.0500;
rover_path2.z = interp2(mars_terrain_grid.xg,mars_terrain_grid.yg,mars_terrain_grid.z_heights',rover_path2.x,rover_path2.y);
rover_path2.Offset_vis_z = 0.0500;

rover_path = rover_path1;

%% Rover Arm Planning And Control
mars_rover_arm_task_space

