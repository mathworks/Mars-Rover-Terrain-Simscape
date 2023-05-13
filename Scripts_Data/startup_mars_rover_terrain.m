% Startup script for project 
% Copyright 2021-2023 The MathWorks, Inc

%% Code for building Simscape custom library at startup
% Change to folder with package directory
curr_proj = simulinkproject;

% Load parameters
mars_rover_params_all
ks_mars_rover = mars_rover_arm_ik_object_create('close');

% Change to root folder
cd(curr_proj.RootFolder)

mars_rover_terrain

