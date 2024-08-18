% Script for testing models and publishing results
% Copyright 2021-2024 The MathWorks, Inc

% List models with publish scripts that have the same name
mdl_list = {...
    'mars_rover_terrain',...
    'mars_rover_arm',...
    'mars_rover_lib',...
    };

% Close models to avoid shadowing issues
for mdl_list_i = 1:length(mdl_list)
    bdclose(mdl_list{mdl_list_i});
end

% Get root folder
curr_proj = simulinkproject;
rootFolderProj = curr_proj.RootFolder;

% List of publish scripts
overview_list = {...
    'mars_rover_terrain.m',false;...
    'mars_rover_workflow_grid_surface.m',true;...
    'mars_rover_workflow_point_cloud.m',true;...
    'mars_rover_workflow_inverse_kinematics.m',false};

% Loop over models with publish script
for ovw_list_i = 1:size(overview_list,1)

    % Return to root folder
    cd(rootFolderProj);

    % Find publish script and move to its folder
    ov_file = dir(['**' filesep overview_list{ovw_list_i,1}]);
    cd(ov_file.folder);

    % Disable warning for publish scripts with same name as model
    warning('off','Simulink:Engine:MdlFileShadowedByFile');

    % Publish script, showing code if requested above
    publish(overview_list{ovw_list_i,1},'showCode',overview_list{ovw_list_i,2});
    % For debugging
    %disp([overview_list{ovw_list_i,1} ' showCode ' num2str(overview_list{ovw_list_i,2})]);
end

clear rootFolderProj overview_list ovw_list_i
clear mdl_list mdl_list_i
